- [Maven](#maven)
      - [check extra help](#check-extra-help)
      - [Check version](#check-version)
      - [clean up resources](#clean-up-resources)
    - [perform a build](#perform-a-build)
      - [Validate POM.xml file](#validate-pomxml-file)
      - [package app](#package-app)
      - [Analyze dependencies](#analyze-dependencies)
      - [verify](#verify)

[Kiwiki Home](/../../)
# Maven

https://maven.apache.org/

2023-01-31
i started checking my Java EE Project from uni. It requires some extra maven fixes. I will be upgrading it to graddle.

#### check extra help

```bash
mvn --help
```

#### Check version

```bash
mvn -v
```

#### clean up resources

```bash
mvn clean
```

### perform a build

```bash
mvn build
```

#### Validate POM.xml file

```bash
mvn validate
```

#### package app

```bash
mvn package
```

#### Analyze dependencies

```bash
mvn dependency:analyze
```

#### verify

this command packaged my WAR

```bash
mvn verify
```

#### generate artifacts
in <sourceRoot> directory that you specify
```bash
mvn generate-sources
```

#### generate a Cucumber archetype
```bash
mvn archetype:generate "-DarchetypeGroupId=io.cucumber" "-DarchetypeArtifactId=cucumber-archetype" "-DarchetypeVersion=7.12.1" "-DgroupId=bank" "-DartifactId=bank" "-Dpackage=bank" "-Dversion=1.0.0-SNAPSHOT" "-DinteractiveMode=false"
```

[Back to top](#)

[Kiwiki Home](/../../)