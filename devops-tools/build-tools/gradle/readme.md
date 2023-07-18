- [Gradle for Android and Java](#gradle-for-android-and-java)
  - [2021-03-05](#2021-03-05)
    - [Building](#building)
    - [Tasks](#tasks)
      - [list tasks](#list-tasks)

[Kiwiki Home](/../../)

# Gradle for Android and Java

## 2021-03-05
- closures=values are respected. values can be passed around.
- use of groovy syntax. groovy automatically creates getters and setters
### Building
```bash
gradle clean build --console plain
```
### Tasks
#### list tasks
```bash
gradle tasks --all
```
- define groovy task
```groovy
# pass a config closure
task myTask {
  description ""
}
```


[Back to top](#)

[Kiwiki Home](/../../)