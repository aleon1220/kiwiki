# KIWIKI

## Introduction - Information Technology Wiki

This project is a collection of CLI commands, utilities, and technical knowledge gathered over 15+ years in software engineering.

- **2019-11-10:** Lost my Google Docs wiki file. Important lesson learned.
- **2020-04-28:** Started this markdown wiki after years of accumulated IT knowledge disappeared.
- **2021-04-07:** Processing and reorganizing knowledge base.

I was born in Colombia and started my career in software engineering, systems engineering, and computer science in 2011. I realized it's useful to collect code snippets for different operating systems and platforms. My interests span complex use cases with regex, programming languages, Docker, and more.

**Journey:** Started with a `.txt` file (2012) → Google Docs (accidentally deleted 2019) → This markdown wiki (2020-present)

> **Lesson Learned:** Don't rely on the cloud 100%. Maintain local copies of your digital material.
> *Built by [andres.nz](www.andres.nz) — A Colombian adopted by Kiwis since 2016*

---

# Table of Contents

## 1. [Soft Skills](./03-My-Soft-skills/readme.md)
Professional development, communication, leadership, and personal growth.

## 2. Cloud Computing
- [AWS](./cloud-computing/aws/readme.md)
- [Azure](./cloud-computing/azure/readme.md)
- [Google Cloud Platform (GCP)](./cloud-computing/gcp/readme.md)

## 3. Containers & Virtualization
- [Docker](./containers/readme.md)
- [Virtualization](./Virtualization/readme.md)

## 4. Software Engineering & DevOps Tools

### 4.1 CI/CD Pipeline
- [CI - Continuous Integration](./devops-tools/CI/readme.md)
  - [Jenkins](./devops-tools/CI/jenkins/readme.md)
    - [Functions](./devops-tools/CI/jenkins/functions/readme.md)
    - [Pipeline Templates](./devops-tools/CI/jenkins/pipeline-templates/readme.md)
- [CD - Continuous Deployment/Delivery](./devops-tools/CD/readme.md)
  - [Spinnaker](./devops-tools/CD/spinnaker.md)

### 4.2 Infrastructure & Automation
- [Infrastructure as Code (IaC)](./devops-tools/IaC/readme.md)
  - [Terraform](./devops-tools/IaC/terraform/readme.md)
- [Automation Tools](./devops-tools/automation/readme.md)
  - [Ansible](./devops-tools/automation/ansible/readme.md)
  - [Rundeck](./devops-tools/automation/Rundeck/readme.md)

### 4.3 Build & Version Control
- [Build Tools](./devops-tools/build-tools/readme.md)
  - [Gradle](./devops-tools/build-tools/gradle/readme.md)
  - [Maven](./devops-tools/build-tools/maven/readme.md)
- [Git](./devops-tools/git/readme.md)

### 4.4 Development Tools & Productivity
- [IDEs - VSCode](./devops-tools/productivity-tools/vscode-setup/readme.md)
- [Markdown](./devops-tools/markdown/readme.md)
- [Productivity Tools](./tools/productivity-tools/readme.md)
  - [PDF Tools](./tools/pdf/readme.md)

## 5. Software Development Lifecycle

### 5.1 Programming Languages
- [Java](./Software-Development-Life-Cycle/programming-languages/java/readme.md)
- [JavaScript](./Software-Development-Life-Cycle/programming-languages/javascript/readme.md)
- [Python](./Software-Development-Life-Cycle/programming-languages/python/readme.md)

### 5.2 Code Quality & Process
- [Regular Expressions](./Software-Development-Life-Cycle/regex/readme.md)
- [Security](./Software-Development-Life-Cycle/security/readme.md)
- [Testing](./Software-Development-Life-Cycle/testing/readme.md)
- [Software-Development-Life-Cycle Overview](./Software-Development-Life-Cycle/readme.md)

## 6. Operating Systems
- [Bash/Shell](./operating-systems/bash/readme.md)
- [Linux](./operating-systems/linux/readme.md)
- [Windows](./operating-systems/windows/readme.md)
- [iOS](./operating-systems/ios/readme.md)

## 7. Infrastructure & Data
- [Computer Hardware](./computer/computer.md)
- [Databases & SQL](./databases/sql.md)
- [LDAP](./LDAP/)
- [Networking](./networking/readme.md)

## 8. Enterprise Solutions
- [Business Process Management](./Enterprise-Solutions/readme.md)

## 9. Media & Content

* [Multimedia](./multimedia/readme.md)

---

## Inbox

* categorise the commands below

```bash
drawio --version

drawio --export --format png --recursive docs/diagrams/

drawio -x -f png --output devops-continuous-delivery-framework.png devops-continuous-delivery-framework.drawio

drawio -x -f png --scale 2.5 -o devops-loop.png devops-loop.drawio

drawio -x -f png --output tooling-map.png tooling-map.drawio

# verbosity
ELECTRON_ENABLE_LOGGING=1 drawio --export --format svg --recursive --output docs/diagrams/imgs/svgs/ ./docs/diagrams/
```

* Windows users powershell 7.6 and above set var

```powershell
$video_name="2025_08_11_DCYL.avi"
```

* extract the frames

```powershell
ffmpeg -i $video_name -filter:v "select='eq(t,2)+eq(t,5)+eq(t,7)+eq(t,10)'" -fps_mode passthrough %03d-Colombia-coral-2025-08-11.png -loglevel verbose
```

> [!NOTE]  
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]  
> Crucial information necessary for users to succeed.

> [!WARNING]  
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.
