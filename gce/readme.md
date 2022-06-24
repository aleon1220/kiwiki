# Google Cloud Engine

https://console.cloud.google.com/

## Run GCE CLI as a docker container

```bash
docker run --rm gcr.io/google.com/cloudsdktool/google-cloud-cli:latest gcloud version
```

## Auth to Google Cloud

```bash
docker run -ti --name gcloud-config gcr.io/google.com/cloudsdktool/google-cloud-cli gcloud auth login
```

once you login and save the config credentials to the container **gcloud-config,** you can run commands to your account

[reference GCE site](https://cloud.google.com/sdk/docs/downloads-docker)

[Back to top](#)