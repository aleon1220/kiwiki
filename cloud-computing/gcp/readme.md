- [Google Cloud Engine](#google-cloud-engine)
      - [Run GCE CLI as a docker container](#run-gce-cli-as-a-docker-container)
  - [Auth to Google Cloud](#auth-to-google-cloud)
      - [local user auth](#local-user-auth)
    - [GCP Service account credential](#gcp-service-account-credential)
      - [obtain the project number of your current project](#obtain-the-project-number-of-your-current-project)
  - [References](#references)

[Kiwiki Home](/../../)

# Google Cloud Engine

https://console.cloud.google.com/

#### Run GCE CLI as a docker container

```bash
docker run --rm gcr.io/google.com/cloudsdktool/google-cloud-cli:latest gcloud version
```

## Auth to Google Cloud

```bash
docker run -ti --name gcloud-config gcr.io/google.com/cloudsdktool/google-cloud-cli gcloud auth login
```

after login and save the config credentials to  **gcloud-config,** you can run commands to your account

#### local user auth

```bash
gcloud auth application-default login
```

### GCP Service account credential

* create the service account
```bash
gcloud iam service-accounts create prod-svc
```
* add the account to a project
  ```bash
  gcloud projects add-iam-policy-binding $PROJECT_ID -member="serviceAccount:prod-svc@$PROJECT_ID -roles"roles/owner"
  ```
* Create Auth keys generate the Key as JSON file
  ```
  gcloud iam service-accounts keys create prod-svc-creds.json --iam-account=prod-svc@$PROJECT_ID.iam.
  gserviceaccount.com.iam.gserviceaccount.com"
  ```
* Place it in a secure storage and fetch the credentials from a password manager. for terraform can be used as environment variable as below

```bash
export GOOGLE_APPLICATION_CREDENTIALS="projectID-serviceAccountID.json"
```

* you can authenticate to GCP. e.g. run terraform commands

```bash
gcloud project list
```
#### obtain the project number of your current project
```shell
gcloud projects describe $(gcloud config get-value core/project) --format=value\(projectNumber\)
```

#### list service accounts in project
```bash
gcloud iam service-accounts list
```

## References

- [GCE site](https://cloud.google.com/sdk/docs/downloads-docker)
- [GCP Quotas Cloud Armor](https://cloud.google.com/armor/quotas)
- [workload-identity-federation](https://cloud.google.com/iam/docs/workload-identity-federation)
- [Token Exchange reference](https://datatracker.ietf.org/doc/html/rfc8693)
- [What is OpenID Connect](https://openid.net/developers/how-connect-works/)

[Back to top](#)

[Kiwiki Home](/../../)
