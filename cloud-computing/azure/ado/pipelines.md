# Azure DevOps (ADO) Pipelines

A reference guide of reusable YAML snippets for Azure Pipelines, structured from top to bottom as they appear in an `azure-pipelines.yml` file.

* **Official Documentation (Latest):**
  * [Azure DevOps Get Started](https://learn.microsoft.com/en-us/azure/devops/get-started/?view=azure-devops)
  * [Azure Pipelines Documentation](https://learn.microsoft.com/en-us/azure/devops/pipelines/?view=azure-devops)
  * [YAML Schema Reference for Azure Pipelines](https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/?view=azure-devops)
  * [Predefined Variables Reference](https://learn.microsoft.com/en-us/azure/devops/pipelines/build/variables?view=azure-devops)
  * [Expressions Reference](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/expressions?view=azure-devops)
  * [Built-in Tasks Reference](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/?view=azure-devops)

---

## Pipeline Hierarchy Overview

```text
Pipeline
 └── Stage(s)                # Logical boundaries (e.g., Build, Test, Deploy_Dev, Deploy_Prod)
      └── Job(s)             # Execution unit assigned to an Agent Pool (Standard Job or Deployment Job)
           └── Step(s)       # Sequential tasks or scripts executed on the agent
```

---

## 1. Pipeline Naming & Run Properties

Define the build number format and whether commit messages are appended to the run description.

```yaml
name: $(Date:yyyyMMdd)$(Rev:.r)-$(Build.SourceBranchName)
appendCommitMessageToRunName: true
```

---

## 2. Triggers (`trigger`, `pr`, `schedules`)

### Continuous Integration (CI) Trigger

```yaml
trigger:
  batch: true # Batch changes if a build is already running
  branches:
    include:
      - main
      - release/*
    exclude:
      - experimental/*
  paths:
    include:
      - src/**
      - azure-pipelines.yml
    exclude:
      - docs/**
      - '**/*.md'
  tags:
    include:
      - v*.*.*
```

### Pull Request (PR) Trigger

> Note: For Azure Repos Git, PR validation is typically configured via **Branch Policies**, though `pr:` works for GitHub and Bitbucket Cloud repos.

```yaml
pr:
  autoCancel: true # Cancel in-progress PR runs when a new commit is pushed
  drafts: false    # Skip draft PRs
  branches:
    include:
      - main
      - develop
  paths:
    exclude:
      - README.md
      - docs/**
```

### Scheduled Trigger (Cron)

Cron syntax uses UTC time (`mm HH DD MM DW`).

```yaml
schedules:
  - cron: '0 2 * * 1-5' # 02:00 UTC Monday through Friday
    displayName: Nightly Weekday Build
    branches:
      include:
        - main
    always: false # Run only if there have been source code changes since the last successful scheduled run
```

### Disable Implicit Triggers (Manual / Triggered by Another Pipeline Only)

```yaml
trigger: none
pr: none
```

---

## 3. Runtime Parameters (`parameters`)

Parameters are evaluated at **queue / compile time** (`${{ parameters.paramName }}`) and render interactive UI controls when manually running a pipeline.

```yaml
parameters:
  - name: environment
    displayName: Target Environment
    type: string
    default: dev
    values:
      - dev
      - staging
      - prod

  - name: runIntegrationTests
    displayName: Run Integration Tests?
    type: boolean
    default: true

  - name: timeoutMinutes
    displayName: Job Timeout (Minutes)
    type: number
    default: 60

  - name: serviceList
    displayName: Microservices to Deploy
    type: object
    default:
      - auth-service
      - payment-service
```

---

## 4. Resources (`resources`)

Reference external repositories (e.g., central YAML templates), containers, or upstream pipelines.

```yaml
resources:
  repositories:
    - repository: templatesRepo
      type: git
      name: MyProject/devops-pipeline-templates
      ref: refs/heads/main

  pipelines:
    - pipeline: upstreamBuild
      source: 'Core-App-CI'
      trigger:
        branches:
          include:
            - main
```

---

## 5. Variables (`variables`)

### Variable Syntax Comparison

| Syntax | Name | Evaluated When | Typical Use Case |
| :--- | :--- | :--- | :--- |
| `$(varName)` | Macro syntax | Runtime (before a task executes) | Inside `script`, task `inputs`, step parameters |
| `${{ variables.varName }}` | Template expression | Compile time (before pipeline starts) | Conditional stage/job/step inclusion, template expansion |
| `$[variables.varName]` | Runtime expression | Runtime (stage/job/step evaluation) | `condition:` expressions and dynamic job/stage variables |

### Defining Variables (Inline, Groups, and Templates)

```yaml
variables:
  # 1. Inline variable
  - name: buildConfiguration
    value: 'Release'
    readonly: true

  # 2. Conditional compile-time variable based on branch or parameter
  - name: isMain
    value: $[eq(variables['Build.SourceBranch'], 'refs/heads/main')]

  # 3. Variable Group (from Pipelines -> Library, optionally backed by Azure Key Vault)
  - group: 'shared-kv-secrets-dev'

  # 4. External Variable Template
  - template: variables/common-vars.yml
```

### Setting Dynamic & Cross-Job Output Variables (Logging Commands)

* Set a variable for subsequent steps in the **same job**:

```yaml
steps:
  - bash: |
      APP_VERSION="1.2.$(Build.BuildId)"
      echo "##vso[task.setvariable variable=appVersion]$APP_VERSION"
    displayName: 'Set job-scoped variable'

  - bash: |
      echo "Version is $(appVersion)"
    displayName: 'Read job-scoped variable'
```

* Set an **output variable** to pass across jobs or stages (`isOutput=true`):

```yaml
stages:
  - stage: BuildStage
    jobs:
      - job: ProduceVarJob
        steps:
          - bash: |
              echo "##vso[task.setvariable variable=commitShortSha;isOutput=true]$(git rev-parse --short HEAD)"
            name: setVarStep # Step 'name' is required when referencing isOutput=true

      - job: ConsumeInSameStage
        dependsOn: ProduceVarJob
        variables:
          shortSha: $[ dependencies.ProduceVarJob.outputs['setVarStep.commitShortSha'] ]
        steps:
          - bash: echo "Short SHA from previous job: $(shortSha)"

  - stage: DeployStage
    dependsOn: BuildStage
    variables:
      # Reference across stages: stageDependencies.<StageName>.<JobName>.outputs['<StepName>.<VarName>']
      shortShaFromBuild: $[ stageDependencies.BuildStage.ProduceVarJob.outputs['setVarStep.commitShortSha'] ]
    jobs:
      - job: DeployJob
        steps:
          - bash: echo "Deploying version $(shortShaFromBuild)"
```

### Commonly Used Predefined Variables

```yaml
# Workspace & Directories
$(Pipeline.Workspace)             # Root workspace directory (e.g., /home/vsts/work/1)
$(Build.SourcesDirectory)         # Local path where repo is cloned (alias: $(System.DefaultWorkingDirectory))
$(Build.ArtifactStagingDirectory) # Local path to stage artifacts before publishing
$(Agent.TempDirectory)            # Temporary folder cleaned up after each pipeline job

# Git & Build Metadata
$(Build.BuildId)                  # Unique ID of the build
$(Build.BuildNumber)              # Name of the completed build
$(Build.SourceBranch)             # Full Git ref (e.g., refs/heads/main or refs/pull/12/merge)
$(Build.SourceBranchName)         # Last segment of ref (e.g., main)
$(Build.SourceVersion)            # Commit SHA

# System & Auth
$(System.AccessToken)             # OAuth token for the running build identity
$(System.TeamFoundationCollectionUri) # Organization URL (e.g., https://dev.azure.com/myorg/)
$(System.TeamProject)             # ADO Project name
```

---

## 6. Agent Pools (`pool`)

### Microsoft-Hosted Agent

```yaml
pool:
  vmImage: 'ubuntu-latest' # Other options: 'windows-latest', 'macOS-latest', 'ubuntu-24.04'
```

### Self-Hosted Agent Pool with Demands

```yaml
pool:
  name: 'SelfHosted-Linux-Pool'
  demands:
    - docker
    - Agent.OS -equals Linux
```

---

## 7. Stages, Jobs & Deployment Strategies

### Standard Job vs. Matrix Strategy Job

```yaml
stages:
  - stage: Test
    displayName: 'Run Test Matrix'
    jobs:
      - job: TestMatrix
        timeoutInMinutes: 30
        cancelTimeoutInMinutes: 5
        workspace:
          clean: all # Options: outputs | resources | all
        strategy:
          maxParallel: 3
          matrix:
            Python310:
              pythonVersion: '3.10'
            Python311:
              pythonVersion: '3.11'
            Python312:
              pythonVersion: '3.12'
        steps:
          - task: UsePythonVersion@0
            inputs:
              versionSpec: '$(pythonVersion)'
          - script: pytest tests/
            displayName: 'Run pytest on Python $(pythonVersion)'
```

### Deployment Job (`deployment`) with Environment Approvals

Deployment jobs integrate with **Environments** (`Pipelines -> Environments`), enabling manual approvals, business-hours gates, exclusive locks, and deployment history tracking.

```yaml
stages:
  - stage: DeployProd
    displayName: 'Deploy to Production'
    dependsOn: Test
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
    jobs:
      - deployment: DeployWebApp
        displayName: 'Deploy App to Prod Environment'
        environment: 'production-env' # Configured in ADO UI with approval gates
        strategy:
          runOnce:
            preDeploy:
              steps:
                - script: echo "Running pre-deployment health checks..."
            deploy:
              steps:
                - download: current
                  artifact: drop
                - script: echo "Deploying artifact from $(Pipeline.Workspace)/drop..."
            routeTraffic:
              steps:
                - script: echo "Shifting traffic..."
            postRouteTraffic:
              steps:
                - script: echo "Running smoke tests..."
            on:
              failure:
                steps:
                  - script: echo "Rolling back deployment!"
              success:
                steps:
                  - script: echo "Deployment completed successfully."
```

---

## 8. Common Tasks & Step Snippets (`steps`)

### Checkout Repository (`checkout`)

```yaml
steps:
  # Shallow fetch (default in ADO is fetchDepth: 1) vs Full history (needed for SonarQube / GitVersion)
  - checkout: self
    fetchDepth: 0
    clean: true
    persistCredentials: true # Allows running authenticated 'git push / tag' commands in subsequent scripts
    submodules: true
```

### Inline Scripts (`script`, `bash`, `pwsh`)

```yaml
steps:
  # Cross-platform default shell (cmd on Windows, bash on Linux/macOS)
  - script: echo "Hello from default shell"
    displayName: 'Run default script'

  # Bash script (works on Linux, macOS, and Windows via Git Bash)
  - bash: |
      set -euo pipefail
      echo "Branch: $(Build.SourceBranch)"
      ls -la $(Build.SourcesDirectory)
    displayName: 'Run Bash script with strict mode'
    workingDirectory: $(Build.SourcesDirectory)
    env:
      SECRET_TOKEN: $(mySecretVar) # Secret variables must be explicitly mapped to env vars

  # PowerShell Core (cross-platform: Linux, macOS, Windows)
  - pwsh: |
      Write-Host "Running PowerShell Core $($PSVersionTable.PSVersion)"
    displayName: 'Run PowerShell Core'
    errorActionPreference: stop
```

### Azure CLI (`AzureCLI@2`)

```yaml
steps:
  - task: AzureCLI@2
    displayName: 'Run Azure CLI commands'
    inputs:
      azureSubscription: 'my-azure-service-connection' # ARM Service Connection name
      scriptType: 'bash'                               # Options: bash | pscore | ps | batch
      scriptLocation: 'inlineScript'
      addSpnToEnvironment: true                        # Exposes $servicePrincipalId, $idToken, $tenantId
      inlineScript: |
        az account show -o table
        az group list -o table
```

### Azure Key Vault Secrets (`AzureKeyVault@2`)

```yaml
steps:
  - task: AzureKeyVault@2
    displayName: 'Fetch secrets from Azure Key Vault'
    inputs:
      azureSubscription: 'my-azure-service-connection'
      KeyVaultName: 'kv-myapp-prod'
      SecretsFilter: 'db-connection-string,api-key' # Use '*' to download all secrets
      RunAsPreJob: false
```

### Dependency Caching (`Cache@2`)

```yaml
steps:
  - task: Cache@2
    displayName: 'Cache npm packages'
    inputs:
      key: 'npm | "$(Agent.OS)" | package-lock.json'
      restoreKeys: |
        npm | "$(Agent.OS)"
      path: $(Pipeline.Workspace)/.npm
```

### Docker Build and Push (`Docker@2`)

```yaml
steps:
  - task: Docker@2
    displayName: 'Build and Push Docker Image'
    inputs:
      containerRegistry: 'my-acr-service-connection'
      repository: 'myapp/backend'
      command: 'buildAndPush'
      Dockerfile: '**/Dockerfile'
      buildContext: '$(Build.SourcesDirectory)'
      tags: |
        $(Build.BuildId)
        latest
```
## Tests CI

* run dotNet test suite

```yaml
- task: VSTest@3
  inputs:
    testSelector: 'testAssemblies'
    testAssemblyVer2: |
      **\*test*.dll
      !**\*TestAdapter.dll
      !**\obj\**
```

### Publish Test Results & Code Coverage

```yaml
steps:
  - task: PublishTestResults@2
    displayName: 'Publish JUnit Test Results'
    condition: succeededOrFailed() # Always publish test results even when tests fail
    inputs:
      testResultsFormat: 'JUnit' # Options: JUnit | NUnit | VSTest | XUnit | CTest
      testResultsFiles: '**/test-results/*.xml'
      failTaskOnFailedTests: true
      testRunTitle: 'Unit Tests - $(Build.BuildNumber)'

  - task: PublishCodeCoverageResults@2
    displayName: 'Publish Code Coverage'
    condition: succeededOrFailed()
    inputs:
      summaryFileLocation: '$(System.DefaultWorkingDirectory)/**/coverage.xml'
      failIfCoverageEmpty: false
```

### Copy, Publish, and Download Pipeline Artifacts

```yaml
steps:
  # 1. Copy only needed files to staging directory
  - task: CopyFiles@2
    displayName: 'Copy build outputs to staging'
    inputs:
      SourceFolder: '$(Build.SourcesDirectory)/dist'
      Contents: '**'
      TargetFolder: '$(Build.ArtifactStagingDirectory)/app'

  # 2. Publish Pipeline Artifact (preferred over legacy PublishBuildArtifacts@1)
  - publish: '$(Build.ArtifactStagingDirectory)/app'
    artifact: 'webapp-drop'
    displayName: 'Publish webapp-drop artifact'

  # 3. Download Pipeline Artifact (in a downstream job/stage)
  - download: current
    artifact: 'webapp-drop'
    displayName: 'Download webapp-drop artifact'
```

---

## 9. Conditions & Logging Commands Cheat Sheet

### Common `condition:` Expressions

```yaml
# Run only if previous steps succeeded AND branch is main
condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))

# Run only on a Pull Request build
condition: and(succeeded(), eq(variables['Build.Reason'], 'PullRequest'))

# Run even if a previous step failed (unless the run was canceled)
condition: succeededOrFailed()

# Always run (even if canceled)
condition: always()

# Run only when a previous dependency failed
condition: failed()

# Run if branch starts with refs/heads/release/
condition: and(succeeded(), startsWith(variables['Build.SourceBranch'], 'refs/heads/release/'))
```

### Useful ADO Logging Commands (Inside Scripts)

```bash
# Log a warning or error annotation in the pipeline UI summary
echo "##vso[task.logissue type=warning]Disk usage is above 80%"
echo "##vso[task.logissue type=error]Configuration file missing"

# Complete a task with SucceededWithIssues (yellow warning badge)
echo "##vso[task.complete result=SucceededWithIssues;]Completed with non-critical warnings"

# Prepend a directory to the agent PATH for subsequent steps in the same job
echo "##vso[task.prependpath]/custom/bin/directory"

# Update the current build number dynamically
echo "##vso[build.updatebuildnumber]1.0.0-$(Build.BuildId)"

# Add a tag to the current build
echo "##vso[build.addbuildtag]production-candidate"
```

---

## 10. Reusable Templates (`template` & `extends`)

### Step / Job Template (`templates/build-steps.yml`)

```yaml
parameters:
  - name: nodeVersion
    type: string
    default: '20.x'

steps:
  - task: NodeTool@0
    displayName: 'Install Node.js ${{ parameters.nodeVersion }}'
    inputs:
      versionSpec: ${{ parameters.nodeVersion }}

  - script: |
      npm ci
      npm run build
    displayName: 'npm ci & build'
```

### Calling the Template in `azure-pipelines.yml`

```yaml
steps:
  # Local repo template
  - template: templates/build-steps.yml
    parameters:
      nodeVersion: '22.x'

  # External repo template (declared under 'resources.repositories')
  - template: pipelines/steps/security-scan.yml@templatesRepo
```

---

## 11. Complete End-to-End Starter Pipeline (`azure-pipelines.yml`)

```yaml
name: $(Date:yyyyMMdd)$(Rev:.r)

trigger:
  batch: true
  branches:
    include:
      - main
      - develop

pr:
  autoCancel: true
  branches:
    include:
      - main

parameters:
  - name: deployEnvironment
    displayName: 'Target Environment'
    type: string
    default: 'dev'
    values:
      - dev
      - staging
      - prod

variables:
  - name: vmImageName
    value: 'ubuntu-latest'
  - name: isMainBranch
    value: $[eq(variables['Build.SourceBranch'], 'refs/heads/main')]

pool:
  vmImage: $(vmImageName)

stages:
  - stage: BuildAndTest
    displayName: 'Build & Unit Test'
    jobs:
      - job: Build
        displayName: 'Build Application'
        steps:
          - checkout: self
            clean: true

          - bash: |
              set -euo pipefail
              echo "Building branch $(Build.SourceBranchName)..."
              mkdir -p $(Build.ArtifactStagingDirectory)/drop
              echo "version=$(Build.BuildNumber)" > $(Build.ArtifactStagingDirectory)/drop/build.info
            displayName: 'Compile & Package'

          - publish: $(Build.ArtifactStagingDirectory)/drop
            artifact: drop
            displayName: 'Publish Artifact: drop'

  - stage: Deploy
    displayName: 'Deploy to ${{ parameters.deployEnvironment }}'
    dependsOn: BuildAndTest
    condition: and(succeeded(), or(eq(variables['isMainBranch'], 'true'), eq('${{ parameters.deployEnvironment }}', 'dev')))
    jobs:
      - deployment: DeployApp
        displayName: 'Deploy to ${{ parameters.deployEnvironment }}'
        environment: 'app-${{ parameters.deployEnvironment }}'
        strategy:
          runOnce:
            deploy:
              steps:
                - download: current
                  artifact: drop

                - bash: |
                    set -euo pipefail
                    echo "Deploying to ${{ parameters.deployEnvironment }}..."
                    cat $(Pipeline.Workspace)/drop/build.info
                  displayName: 'Execute Deployment'
```

## References

* Azure Pipelines [task reference](https://learn.microsoft.com/en-au/azure/devops/pipelines/tasks/reference/?view=azure-pipelines)

