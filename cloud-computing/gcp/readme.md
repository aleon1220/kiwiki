# Google Cloud Engine

* [GCE](https://console.cloud.google.com/)

## Admin ops

* list all available Google Cloud regions

```bash
gcloud compute regions list
```

## Admin ops

* list all available Google Cloud regions

```bash
gcloud compute regions list
```

* Run GCE CLI as a container

```bash
docker run --rm gcr.io/google.com/cloudsdktool/google-cloud-cli:latest gcloud version
```

## Auth to Google Cloud

```bash
alias gcloudcli docker run -ti --name gcloud-config gcr.io/google.com/cloudsdktool/google-cloud-cli
gcloudcli gcloud auth login
```

after login and save the config credentials to  **gcloud-config,** you can run commands to your account

* login auth default local user

```bash
gcloud auth application-default login
```

### GCP Authenticate Service account credential

* create the service account

  
```bash
  gcloud iam service-accounts create prod-svc
  ```


* add the account to a project


  ```bash
  gcloud projects add-iam-policy-binding $PROJECT_ID -member="serviceAccount:prod-svc@$PROJECT_ID -roles"roles/owner"
  ```
  

* Create Auth keys generate the Key as JSON file

  ```bash
  gcloud iam service-accounts keys create prod-svc-creds.json --iam-account=prod-svc@$PROJECT_ID.iam.
  gserviceaccount.com.iam.gserviceaccount.com"
  ```
  
* Place it in a secure storage and fetch the credentials from a password manager. for terraform can be used as environment variable as below

  ```bash
  export GOOGLE_APPLICATION_CREDENTIALS="projectID-serviceAccountID.json"
  ```

* download the `JSON` file

* set the environment var
  
  ```bash
  KEY_FILE_PATH="$HOME/workspace-spinnaker-install/gcp/service-accounts/sa-gcp-project.json"
  ```

* enable service account access

  ```bash
  gcloud auth activate-service-account --key-file="$KEY_FILE_PATH"
  ```

* you can authenticate to GCP. e.g. run terraform commands

```bash
gcloud project list
```

* obtain the project number of your current project

```shell
gcloud projects describe $(gcloud config get-value core/project) --format=value\(projectNumber\)
```

* list service accounts in project

```bash
gcloud iam service-accounts list
```

## Storage

```bash
gcloud storage ls gs://my-bucket
```

* Upload files (recursive and path preservation):

```bash
gcloud storage cp -r ./local-folder/ gs://my-bucket/destination/
```

## Cloud Build

* List build history

```bash
gcloud builds list --limit=10
```

## Cloud Run

List deployed Cloud Run services:

```Bash
gcloud run services list
```

## Cloud SQL


## Storage

gcloud storage ls gs://my-bucket


* Upload files (recursive and path preservation):

gcloud storage cp -r ./local-folder/ gs://my-bucket/destination/

## Cloud Build

* List build history

gcloud builds list --limit=10

## Cloud Run

List deployed Cloud Run services:

```Bash
gcloud run services list
```

## Cloud SQL

## References

* [GCE site](https://cloud.google.com/sdk/docs/downloads-docker)
* [GCP Quotas Cloud Armor](https://cloud.google.com/armor/quotas)
* [workload-identity-federation](https://cloud.google.com/iam/docs/workload-identity-federation)
* [Token Exchange reference](https://datatracker.ietf.org/doc/html/rfc8693)
* [What is OpenID Connect](https://openid.net/developers/how-connect-works/)
