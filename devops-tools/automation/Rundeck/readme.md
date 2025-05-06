[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

# Rundeck
Introduction [webinar](https://www.pagerduty.com/ty/webinar/introduction-to-process-automation/)
https://www.rundeck.com/downloads

## Install Rundeck Docker
```bash
docker pull rundeck/rundeck:4.16.0
```

## Containerised Rundeck 
- OSS
```bash
docker run --rm -it -p 4440:4440  rundeck/rundeck:4.16.0
```
- Enterprise
```bash
docker run --rm -it -p 4440:4440 rundeckpro/enterprise:4.16.0
```