- [Gradle for Android and Java](#gradle-for-android-and-java)
  - [2021-03-05](#2021-03-05)
    - [Building](#building)
    - [Tasks](#tasks)
      - [list tasks](#list-tasks)
  - [Debugging](#debugging)
    - [lock file error](#lock-file-error)

[Kiwiki Home](/../../)

# Gradle for Android and Java
> Gradle now with Kotlin syntax

## 2021-03-05
- closures=values are respected. values can be passed around.
- use of groovy syntax. groovy automatically creates getters and setters
### Build tasks
```bash
gradle clean build --console plain
```

### Build Set up tasks
### Documentation tasks
### Verification tasks
```bash
gradle check --warning-mode all
```
### Help tasks
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
## Debugging
for version 7.3.3 of gradle there are some issues when running graddle commands. solution for this case is to restart the gradle process

```bash
gradle --stop
```
### lock file error
```bash
FAILURE: Build failed with an exception.

* What went wrong:
Gradle could not start your build.
> Could not create service of type FileHasher using BuildSessionServices.createFileHasher().
   > java.io.IOException: Input/output error

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.

* Get more help at https://help.gradle.org
```

#### Dependencies & configurations
```bash
gradle --refresh-dependencies
```

[Back to top](#)

[Kiwiki Home](/../../)
