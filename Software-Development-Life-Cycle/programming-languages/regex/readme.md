# Regex Notes and Cheat sheet

`/[]/` is a character class that allows us to find any matching characters in the string. The character(s) in the character class acts as a delimiter. When a match is found, the characters in the string are divided/split.

The `.` matches any one character followed or preceded by any character in the character class.

- Use groups with parentheses `(group of regex)`

## Tips

1. break it down
2. list what you want to achive
3. build each list of the goals with the regex grammar

Example:
Here we are essentially saying:
Find any matching character in the word forest.
Grab a single character followed by that matching character.
Match zero or more occurrences of (1) and (2)

### Regular expresion

#### find after `:` symbol all the numbers until the end of the line

`:[0-9]*.*`

#### find extensions that start after string dash at the end of line
> tested in vscode

`-m[\w].$`

#### Practical example. Replace spaces for dashes but keep the numbers or digits in each line

- start with sample data

```bash
1 a text
2 another text
3 yet more text
```
- match lines that start with opening parenthesis ( contain digits end with a closing parenthesis )
```cmd
^\(\d+\)
```

- Do the Regex to find/Search the numerical digits and spaces. The group here will be the digits as it is surrounded in parenthesis

```bash
(\d)\s
```

- Run a replace regex ops

```bash
$1-
```

- Outputs

```bash
1-a text
2-another text
3-yet more text
```

#### Find markdown headers level 3

`(^###)(\s)`


### Text containing Time

#### time represented minutes

tested in vscode will match any string that consists of two digits, followed by a colon, followed by two digits

* `23:59`
* `00:30`

```perl
^(\d+:\d+)$
```

---

## References

[breaking-down-a-complex-regex](https://medium.com/better-programming/breaking-down-a-complex-regex-73b6c795a2be)
[pig-latinizer-using-regex](https://aubreeabril.wordpress.com/2018/08/23/pig-latinizer-using-regex/)

[Back to top](#)

[Kiwiki Home](/../../)
