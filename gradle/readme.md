# Gradle for Android and Java

- closures=values are respected. values can be passed around.
- use of groovy syntax. groovy automatically creates getters and setters
### tasks
- list tasks
`gradle tasks --all`
- the project objects
```groovy
# pass a config closure
task myTask {
  description ""
  
}

```
- 