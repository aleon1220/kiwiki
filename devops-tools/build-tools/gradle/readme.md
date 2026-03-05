# Gradle 

[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

## Android and Java
> Gradle now with Kotlin syntax
#### check gradle installations with sdkman.io
```bash
sdkman list gradle
```
#### as complexity grows, check the projects
```bash
gradle projects
```

## 2021-03-05
- closures=values are respected. values can be passed around.
- use of groovy syntax. groovy automatically creates getters and setters

### Build tasks
use [plugin shadow](https://plugins.gradle.org/plugin/com.gradleup.shadow) to generate better Fat Jars

#### clean plain build
```bash
gradle clean build --console plain
```

#### fresh gradle build stderr and stdout into unified viewing
```bash
gradle clean build 2>&1
```

#### check build outcome
```bash
ls -lh lib/build
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

#### run the build passing arguments
```bash
gradle run --args="--help"
```

#### run test suite
```bash
gradle test
```

[Back to top](#)

[Kiwiki Home](/../../)
