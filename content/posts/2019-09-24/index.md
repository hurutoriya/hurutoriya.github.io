---
title: "How to connect the Google Compute Engine via Visual Studio Code"
date: 2019-09-24T17:35:05+09:00
lang: en
tags:
  - gcp
  - vscode
---

## 1. Generate SSH config file using `gcloud` command line

```bash
gcloud compute config-ssh
```

https://cloud.google.com/sdk/gcloud/reference/compute/config-ssh

You cant get ssh config for your Google Compute Engine project!

Notice: you need choose target GCP project before run below command.

```bash
gcloud config set project <your-project-id>
```

## 2. Install `Remote SSH` extention in Visual Studio Code.

https://code.visualstudio.com/blogs/2019/07/25/remote-ssh

## 3. Press `⇧⌘P` & Select target connection in Visual Studio Code!

Finaly you can connect in Visual Studio Code. Welcome to VS code when you write the code in SSH connection.
