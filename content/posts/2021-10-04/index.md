---
title: "CloudComposer のDAGをCIで更新する"
date: 2021-10-04T22:23:24+09:00
lang: ja
author: Shunya Ueta
tags:
- airflow
- gcp
- circleci
---

Cloud Composer(Airflow) のDAGをGitHub リポジトリで管理して、CIによりリポジトリで管理しているDAGをPull RequestがマージされるとCloud ComposerのDAGへ同期する方法について説明する。

DAGは、ルートディレクトリ直下の `dags/` というディレクトリに格納されている状態を前提とする。

以下の２つのコマンドラインツールを利用して実現できる。

- Service Account の認証のために `gcloud`
- DAGの同期のために `gsutil` 

CircleCI によるワークフローの記述例は以下のとおり

```yaml
version: 2.1

jobs:
  rsync-dags:
    working_directory: ~/workspace
    docker:
    - image: gcr.io/google.com/cloudsdktool/cloud-sdk:alpine
      environment:
        GOOGLE_APPLICATION_CREDENTIALS: /gcp-service-key.json
    steps:
    - checkout
    - run:
        name: Sync DAG folder to GCS's DAG folder
        command: |
            echo "${CLOUD_COMPOSER_CREDENTIALS_JSON}" > ${GOOGLE_APPLICATION_CREDENTIALS}
            gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}

            gsutil -m rsync -d -r dags \
            "$(gcloud composer environments describe {COMPOSER_NAME} --project={GCP_PROJECT} --location={REGION}  --format="get(config.dagGcsPrefix)")"
workflows:
  rsync_dags:
    jobs:
    - rsync-dags
```

`Sync DAG folder to GCS's DAG folder` で行っている内容を順を追って説明する。

1. サービスアカウントのクレデンシャルファイルをCircleCIの環境変数として保存しておき、リダイレクトによりJSONファイルとして書き出す

```bash
echo "${CLOUD_COMPOSER_CREDENTIALS_JSON}" > ${GOOGLE_APPLICATION_CREDENTIALS}
```

__注意:__ セキュリティ対策としてクレデンシャルファイルは必ず環境変数として扱う。

2. 1で生成したクレデンシャルファイルにより、サービスアカウント認証をgcloud コマンドで行う

```bash
gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}
```

3. CloudComposer のDAGが格納されているGCSのバケットをgcloudコマンドで取得して、gsutilコマンドでDAGファイルの同期を行う

```bash
gsutil -m rsync -d -r dags "$(gcloud composer environments describe {COMPOSER_NAME} --project={GCP_PROJECT} --location={REGION}  --format="get(config.dagGcsPrefix)")"
```

{XXX} には使用する環境の情報を置換してください。

- `"$(gcloud composer environments describe {COMPOSER_NAME} --project={GCP_PROJECT} --location={REGION}  --format="get(config.dagGcsPrefix)")"` 
  - 指定したGCP Project で動くCloud Composer のDAGが格納されているGCSのパスを取得できる。
- `gsutil -m rsync -d -r dags`
  - `-m` は並列処理
  - `-d` は元のディレクトリに存在しないファイルがコピー先にあれば削除(ミラーリング)。これにより、GCS上でDAGを新たに作成して、デバッグしていたとしても、CIが走ればリポジトリにないDAGファイルは削除され、リポジトリのDAGと完全に同期される。
  - `-r` はディレクトリとしてコピー
  - 上記のオプションにより`dags` ディレクトリのDAGファイルをGCSにミラーリングで同期を行う。


[GCPのCloud Composer のDAGを素早く・簡単にデバッグする](/posts/2021-09-19/) の記事では、デバッグする方法について書いてあるので、そちらもCloud Composer を使っている人は役に立つと思うので見てみてください

## Referemce

- [gsutil Top-Level Command-Line Options](https://cloud.google.com/storage/docs/gsutil/addlhelp/TopLevelCommandLineOptions)
- [rsync - Synchronize content of two buckets/directories](https://cloud.google.com/storage/docs/gsutil/commands/rsync)