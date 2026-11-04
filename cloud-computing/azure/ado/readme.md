[Kiwiki Home](/../../)
[Back to Azure](../readme.md)

# Azure DevOps (ADO)

Azure DevOps provides developer services to support teams in planning work, collaborating on code development, and building and deploying applications.

* **Official Documentation (Latest):** [Azure DevOps Documentation](https://learn.microsoft.com/en-us/azure/devops/get-started/?view=azure-devops)
* **ADO Pipelines Guide & Snippets:** [ADO Pipelines](./pipelines.md)

---

## Core Services

* **[Azure Boards](https://learn.microsoft.com/en-us/azure/devops/boards/?view=azure-devops):** Agile tools for planning and tracking work, code defects, and issues using Kanban and Scrum methods (Epics, Features, User Stories, Tasks, Bugs).
* **[Azure Repos](https://learn.microsoft.com/en-us/azure/devops/repos/?view=azure-devops):** Unlimited cloud-hosted private Git repositories (and Team Foundation Version Control) with pull requests, branch policies, and advanced file management.
* **[Azure Pipelines](./pipelines.md):** Cloud-hosted CI/CD pipelines for Linux, macOS, and Windows with YAML or Classic definitions. ([Official Docs](https://learn.microsoft.com/en-us/azure/devops/pipelines/?view=azure-devops))
* **[Azure Test Plans](https://learn.microsoft.com/en-us/azure/devops/test/?view=azure-devops):** Planned and exploratory testing solutions for manual and automated testing.
* **[Azure Artifacts](https://learn.microsoft.com/en-us/azure/devops/artifacts/?view=azure-devops):** Package hosting for Maven, npm, NuGet, Python (pip), and Universal Packages from public and private sources.

---

## Azure DevOps CLI (`az devops`)

The `azure-devops` extension for Azure CLI allows managing Azure DevOps from the terminal.

* **Official CLI Reference:** [az devops CLI Reference](https://learn.microsoft.com/en-us/cli/azure/devops?view=azure-cli-latest)

### Installation & Setup

* Install the Azure DevOps extension

```bash
az extension add --name azure-devops
```

* Update the extension

```bash
az extension update --name azure-devops
```

* Authenticate using a Personal Access Token (PAT)

```bash
export AZURE_DEVOPS_EXT_PAT="your_personal_access_token"
# Or login interactively:
az devops login --organization https://dev.azure.com/<OrgName>
```

* Configure default organization and project

```bash
az devops configure --defaults organization=https://dev.azure.com/<OrgName> project=<ProjectName>
```

* Verify current configuration

```bash
az devops configure --list
```

### Common CLI Commands

* List projects in the organization

```bash
az devops project list -o table
```

* List Git repositories in the default project

```bash
az repos list -o table
```

* List active Pull Requests for a repository

```bash
az repos pr list --repository <RepoName> --status active -o table
```

* Create a Pull Request from the current branch to `main`

```bash
az repos pr create \
  --repository <RepoName> \
  --source-branch <FeatureBranch> \
  --target-branch main \
  --title "feat: description of changes" \
  --description "Detailed PR description"
```

* List pipelines

```bash
az pipelines list -o table
```

* Trigger a pipeline run on a specific branch

```bash
az pipelines run --name <PipelineName> --branch main
```

* Show details of a work item

```bash
az boards work-item show --id <WorkItemId> -o table
```

---

## References

* [Get started with Azure DevOps documentation](https://learn.microsoft.com/en-us/azure/devops/get-started/?view=azure-devops)
* [Azure DevOps CLI Documentation](https://learn.microsoft.com/en-us/azure/devops/cli/?view=azure-devops)
* [Azure DevOps REST API Reference](https://learn.microsoft.com/en-us/rest/api/azure/devops/?view=azure-devops-rest-7.1)

[Back to top](#)
[Kiwiki Home](/../../)

