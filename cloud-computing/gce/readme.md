- [Google Cloud Engine](#google-cloud-engine)
  - [Run GCE CLI as a docker container](#run-gce-cli-as-a-docker-container)
  - [Auth to Google Cloud](#auth-to-google-cloud)
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

```
gcloud project list
```



## References

- [GCE site](https://cloud.google.com/sdk/docs/downloads-docker)

[Back to top](#)

[Kiwiki Home](/../../)
