#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Function: extract
# Description: Extracts common archive types with appropriate utilities.
# Accepts one or multiple archive files.
# -----------------------------------------------------------------------------

extract() {
    if [ $# -eq 0 ]; then
        echo "Usage: extract <archive_file> [<archive_file_2> ...]" >&2
        return 1
    fi

    for file in "$@"; do
        if [ -f "$file" ]; then
            case "${file,,}" in
                *.tar.bz2|*.tbz2)   tar -xvjf "$file" ;;
                *.tar.gz|*.tgz)     tar -xvzf "$file" ;;
                *.tar.xz|*.txz)     tar -xvJf "$file" ;;
                *.tar.zst)          tar --zstd -xvf "$file" ;;
                *.tar)              tar -xvf "$file" ;;
                *.bz2)              bunzip2 "$file" ;;
                *.rar)              unrar x "$file" ;;
                *.gz)               gunzip "$file" ;;
                *.zip)              unzip "$file" ;;
                *.z)                uncompress "$file" ;;
                *.7z)               7z x "$file" ;;
                *.xz)               unxz "$file" ;;
                *.zst)              unzstd "$file" ;;
                *.deb)              ar -x "$file" ;;
                *)                  echo "extract: '$file' - cannot extract (unknown archive type)" >&2 ;;
            esac
        else
            echo "extract: '$file' is not a valid file" >&2
        fi
    done
}