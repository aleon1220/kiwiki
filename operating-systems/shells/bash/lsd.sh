#!/usr/bin/env bash

# Script to list:
#      directories (if called "lsd")
#      files       (if called "lsf")
#      links       (if called "lsl")
#      executables (if called "lsx")
#  or  pipes       (if called "lsp")
# but not any other type of filesystem object.
#
# Usage:
#   <command_name> [switches valid for ls command] [dirname...]
#
# Works with names that include spaces and that start with a hyphen.
#
# Created by Nick Clifton.
# Version 1.5
# Copyright (c) 2006, 2007 Red Hat.
#
# This is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 3, or (at your
# option) any later version.
#
# It is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# ---------------------------------------------------------------------------
# Modifications in 1.5 (see ../readme.md, "17 Bash Scripting Best Practices"):
#
#   Completed ToDo/FIXME items
#     * lsp, to list named pipes.
#     * Recursion, eg "lsl -R".
#     * Switches that take an argument, eg "--block-size K" and "-I *.o",
#       which were previously mistaken for directory names.
#     * --all, --almost-all, --ignore-backups, --ignore and --hide.
#       These are applied to "find", not "ls": once ls is handed an explicit
#       list of names it no longer filters it, so passing them through had
#       no effect at all.  That is why they were listed as FIXMEs.
#
#   Fixed defects
#     * "-alF" never enabled dotfiles.  A quoted right hand side of =~ is a
#       literal string in bash 3.2+, so the test could never match.  Replaced
#       with a glob, which also removes the bash 3.0 caveat.
#     * list_objects passed the literal string "i" instead of "$i".  It only
#       worked because array subscripts are an arithmetic context.
#     * A debug "echo args ..." line printed on every invocation.
#     * --version reported 1.2 while the header said 1.4.
#     * A missing directory still exited 0.  It now exits 1.
#
#   Applied practices
#     * set -euo pipefail, and n=$(( n + 1 )) over "let n++", which returns 1
#       when n is 0 and so aborts an errexit script.
#     * Arrays for the ls/find argument lists, so quoting survives.
#     * A subshell instead of pushd/popd, so a failure cannot strand the
#       caller in the wrong directory.
#     * Diagnostics on stderr, so they do not pollute a piped listing.
#
# Requires bash 4.4+, GNU find, GNU xargs and GNU coreutils sort.
# ---------------------------------------------------------------------------

set -o errexit
set -o nounset
set -o pipefail

readonly VERSION="1.5"

# --------------------------------------------------------------------------
# Diagnostics.  Both write to stderr so that stdout stays a clean listing,
# eg "lsd | wc -l" must not count error text.
# --------------------------------------------------------------------------

report ()
{
  printf '%s: %s\n' "$prog" "$*" >&2
}

fail ()
{
  report "$*"
  exit 1
}

internal_error ()
{
  report "internal error: $*"
  exit 1
}

usage ()
{
  local what

  case "$find_type" in
    d) what="directories" ;;
    l) what="symbolic links" ;;
    p) what="named pipes" ;;
    f) if (( ${#find_extras[@]} > 0 )) ; then
         what="executables"
       else
         what="regular files"
       fi ;;
    *) internal_error "usage called before the program name was resolved" ;;
  esac

  cat <<USAGE
$prog - a version of 'ls' that lists only $what.

Usage: $prog [OPTION]... [DIRECTORY]...

Most 'ls' options are passed straight through.  These are handled here
instead, because 'ls' ignores them once it is given an explicit list of
names:

  -a, --all               do not hide entries starting with .
  -A, --almost-all        likewise, but omit . itself
  -B, --ignore-backups    do not list entries ending with ~
  -I, --ignore=PATTERN    do not list entries matching shell PATTERN
      --hide=PATTERN      same as --ignore
  -R, --recursive         list subdirectories recursively

      --help              display this help and exit
      --version           output version information and exit

Use -- to mark the end of the options, eg "$prog -- -weird-dir".
USAGE
}

# --------------------------------------------------------------------------
# Global state.  Declared up front so that "set -u" gives a clear error if a
# code path ever forgets to initialise one of them.
# --------------------------------------------------------------------------

init ()
{
  # Directories to list.  Defaults to the current directory, applied after
  # parsing so that an explicit argument replaces it rather than adding to it.
  declare -g -a dirs=()

  # Switches forwarded verbatim to ls.
  declare -g -a ls_opts=()

  # Extra find predicates that select the object type, eg executables.
  declare -g -a find_extras=()

  # Extra find predicates that exclude names, built from the dotfile mode
  # and any --ignore/--hide/-B patterns.
  declare -g -a find_filters=()
  declare -g -a ignore_globs=()

  # none   - hide everything starting with a dot (the default)
  # almost - show dotfiles but not . itself   (-A)
  # all    - show everything                  (-a)
  declare -g dotfile_mode="none"

  declare -g recursive=0
  declare -g show_headers=0
  declare -g exit_status=0

  # Set by resolve_program.
  declare -g find_type=""
  declare -g prog=""
}

# --------------------------------------------------------------------------
# Decide what we are listing from the name we were invoked under.  Stripping
# a .sh suffix means the script works both as a symlink named "lsd" and when
# run directly as "./lsd.sh".
# --------------------------------------------------------------------------

resolve_program ()
{
  prog="$(basename -- "$0")"
  prog="${prog%.sh}"

  case "$prog" in
    lsf)
      find_type=f
      ;;
    lsd)
      find_type=d
      # -d stops ls from listing the contents of each directory it is given.
      ls_opts=( -d )
      ;;
    lsl)
      find_type=l
      # -d stops ls from following the links it is given.
      ls_opts=( -d )
      ;;
    lsx)
      find_type=f
      # Any of the three execute bits.
      find_extras=( -perm /111 )
      ;;
    lsp)
      find_type=p
      ;;
    *)
      fail "unrecognised program name '$prog', expected 'lsd', 'lsf', 'lsl', 'lsx' or 'lsp'"
      ;;
  esac
}

# --------------------------------------------------------------------------
# Command line parsing.
# --------------------------------------------------------------------------

# Long ls options that consume the following word when written without "=".
long_opt_takes_arg ()
{
  case "$1" in
    --block-size | --format | --indicator-style | --quoting-style | --sort | --tabsize | --time | --time-style | --width)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

parse_args ()
{
  local no_more_args=0
  local cluster passthru arg ch idx

  while (( $# > 0 ))
  do
    # Everything after -- is a name, even if it looks like a switch.
    if (( no_more_args )) ; then
      dirs+=( "$1" )
      shift
      continue
    fi

    case "$1" in
      --)
        no_more_args=1
        ;;

      -a | --all)
        dotfile_mode="all"
        ;;

      -A | --almost-all)
        # -a wins if both are given, matching ls.
        if [[ "$dotfile_mode" != "all" ]] ; then
          dotfile_mode="almost"
        fi
        ;;

      -B | --ignore-backups)
        ignore_globs+=( '*~' )
        ;;

      -R | --recursive)
        recursive=1
        ;;

      --ignore=* | --hide=*)
        ignore_globs+=( "${1#*=}" )
        ;;

      --ignore | --hide)
        if (( $# < 2 )) ; then
          fail "option '$1' requires an argument"
        fi
        ignore_globs+=( "$2" )
        shift
        ;;

      --version)
        printf '%s version %s\n' "$prog" "$VERSION"
        exit 0
        ;;

      --help)
        usage
        exit 0
        ;;

      --*=*)
        # Self contained, eg --block-size=K.  Hand it to ls untouched.
        ls_opts+=( "$1" )
        ;;

      --*)
        if long_opt_takes_arg "$1" ; then
          if (( $# < 2 )) ; then
            fail "option '$1' requires an argument"
          fi
          ls_opts+=( "$1" "$2" )
          shift
        else
          ls_opts+=( "$1" )
        fi
        ;;

      -?*)
        # A single dash can carry several switches, eg "lsd -alF".  Walk the
        # cluster so that -a is acted on here and the rest reaches ls.
        cluster="${1#-}"
        passthru=""
        idx=0

        while (( idx < ${#cluster} ))
        do
          ch="${cluster:idx:1}"

          case "$ch" in
            a) dotfile_mode="all" ;;
            A) if [[ "$dotfile_mode" != "all" ]] ; then dotfile_mode="almost" ; fi ;;
            B) ignore_globs+=( '*~' ) ;;
            R) recursive=1 ;;

            I | T | w)
              # These take an argument, either glued on to the switch or
              # supplied as the next word.
              arg="${cluster:idx+1}"

              if [[ -n "$arg" ]] ; then
                # The remainder of the cluster is the argument.
                idx=${#cluster}
              else
                if (( $# < 2 )) ; then
                  fail "option '-$ch' requires an argument"
                fi
                arg="$2"
                shift
                idx=$(( idx + 1 ))
              fi

              if [[ "$ch" == "I" ]] ; then
                ignore_globs+=( "$arg" )
              else
                ls_opts+=( "-$ch" "$arg" )
              fi
              continue
              ;;

            *)
              passthru+="$ch"
              ;;
          esac

          # Not (( idx++ )): that evaluates to 0 on the first pass, which is
          # a non zero exit status, which errexit would treat as a failure.
          idx=$(( idx + 1 ))
        done

        if [[ -n "$passthru" ]] ; then
          ls_opts+=( "-$passthru" )
        fi
        ;;

      *)
        dirs+=( "$1" )
        ;;
    esac

    shift
  done

  if (( ${#dirs[@]} == 0 )) ; then
    dirs=( "." )
  fi

  # Name the directory in the output whenever more than one listing follows.
  if (( ${#dirs[@]} > 1 || recursive )) ; then
    show_headers=1
  fi
}

# --------------------------------------------------------------------------
# Turn the parsed options into find predicates.
# --------------------------------------------------------------------------

build_find_filters ()
{
  local glob

  case "$dotfile_mode" in
    none)
      find_filters+=( -not -name '.*' )
      ;;
    almost)
      # Show .config and friends, but never . itself.
      find_filters+=( -not -name '.' )
      ;;
    all)
      : # No name filtering at all.
      ;;
    *)
      internal_error "unknown dotfile mode '$dotfile_mode'"
      ;;
  esac

  for glob in ${ignore_globs[@]+"${ignore_globs[@]}"}
  do
    find_filters+=( -not -name "$glob" )
  done
}

# --------------------------------------------------------------------------
# Listing.
# --------------------------------------------------------------------------

list_things_in_dir ()
{
  local dir

  # Paranoia checks - the user should never encounter these.
  if (( $# != 1 )) ; then
    internal_error "list_things_in_dir expects exactly one argument, got $#"
  fi

  dir="$1"

  if [[ -z "$dir" ]] ; then
    internal_error "list_things_in_dir called with an empty directory name"
  fi

  # Catch directory names that start with a dash - they confuse cd.
  if [[ "${dir:0:1}" == "-" ]] ; then
    dir="./$dir"
  fi

  if [[ ! -d "$dir" ]] ; then
    report "directory '$dir' could not be found"
    exit_status=1
    return
  fi

  # Check access before cd, so an unreadable directory produces one tidy
  # message rather than a raw "line NNN: cd: Permission denied" from bash.
  # Reading the names needs r, entering the directory needs x.
  if [[ ! -r "$dir" || ! -x "$dir" ]] ; then
    report "directory '$dir' is not readable"
    exit_status=1
    return
  fi

  if (( show_headers )) ; then
    printf '%s:\n' "$dir"
  fi

  # A subshell rather than pushd/popd: the cd cannot leak, and a failure
  # part way through cannot leave the caller in the wrong directory.
  #
  # cd into the directory rather than passing it to find so that the names
  # reaching ls have no path prepended, which keeps the output identical to
  # a plain ls.
  #
  # -printf with a NUL terminator and --null carry names containing spaces,
  # newlines or a leading dash safely.  sort -z keeps the order stable when
  # xargs has to split a large directory across several ls invocations.
  if ! (
        cd -- "$dir" || exit 1

        find . -maxdepth 1 \
             -type "$find_type" \
             ${find_extras[@]+"${find_extras[@]}"} \
             ${find_filters[@]+"${find_filters[@]}"} \
             -printf '%f\0' \
          | sort -z \
          | xargs --null --no-run-if-empty ls ${ls_opts[@]+"${ls_opts[@]}"} --
      ) ; then
    exit_status=1
  fi
}

# Depth first walk for -R, honouring the dotfile mode so that "lsd -R" does
# not descend into .git and friends.
list_recursively ()
{
  local root="$1"
  local sub
  local -a prune=()

  if [[ "$dotfile_mode" == "none" ]] ; then
    prune=( -name '.*' -not -name '.' -prune -o )
  fi

  if [[ ! -d "$root" ]] ; then
    report "directory '$root' could not be found"
    exit_status=1
    return
  fi

  while IFS= read -r -d '' sub
  do
    list_things_in_dir "$sub"
  done < <( find "$root" ${prune[@]+"${prune[@]}"} -type d -print0 | sort -z )
}

list_objects ()
{
  local dir

  for dir in "${dirs[@]}"
  do
    if (( recursive )) ; then
      list_recursively "$dir"
    else
      list_things_in_dir "$dir"
    fi
  done
}

main ()
{
  if (( BASH_VERSINFO[0] < 4 || ( BASH_VERSINFO[0] == 4 && BASH_VERSINFO[1] < 4 ) )) ; then
    printf '%s: requires bash 4.4 or newer, found %s\n' \
           "$(basename -- "$0")" "$BASH_VERSION" >&2
    exit 1
  fi

  init
  resolve_program
  parse_args "$@"
  build_find_filters

  list_objects

  exit "$exit_status"
}

# Invoke main.  Plain "$@" is safe in bash even with no arguments, so the
# old ${1+"$@"} workaround for pre-POSIX shells is no longer needed.
main "$@"
