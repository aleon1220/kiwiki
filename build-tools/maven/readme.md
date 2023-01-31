# Maven
https://maven.apache.org/

2023-01-31 
i started checking my Java eb Project from uni. It requires some extra maven fixes. I will be upgrading it to graddle.

#### check extra help
``` bash
mvn --help
```

#### Check version
``` bash
mvn -v
```

#### clean up resources
``` bash
mvn clean
```

### perform a build
``` bash
mvn build
```
#### Validate POM.xml file
``` bash
mvn validate
```
#### package app
``` bash
mvn package
```
#### Analyze dependencies
``` bash
mvn dependency:analyze
```
#### verify
this command packaged my WAR
``` bash
mvn verify
```