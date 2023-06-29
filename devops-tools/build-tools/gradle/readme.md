# Gradle for Android and Java

## 2021-03-05
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
- todo explore $GRADLE_PATH
`GRADLE_PATH=/home/devops/code/UDACITY/Graddle-course/ud867/`

[Back to top](#)

[Kiwiki Home](/../../)