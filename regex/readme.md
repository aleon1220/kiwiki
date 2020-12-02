# Regex Notes and Cheat sheet

/[]/ is a character class that allows us to find any matching characters in the string. The character(s) in the character class acts as a delimiter. When a match is found, the characters in the string are divided/split.

The `.` matches any one character followed or preceded by any character in the character class.

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

---
## References
https://medium.com/better-programming/breaking-down-a-complex-regex-73b6c795a2be
https://aubreeabril.wordpress.com/2018/08/23/pig-latinizer-using-regex/