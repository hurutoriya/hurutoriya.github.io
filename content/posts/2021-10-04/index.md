---
title: "CloudComposer のDAGをCircleCIで更新する"
date: 2021-10-04T22:23:24+09:00
lang: ja
author: Shunya Ueta
tags:
  - airflow
  - gcp
  - circleci
---

Cloud Composer(Airflow) の DAG を GitHub リポジトリで管理して、CI によりリポジトリで管理している DAG を Pull Request がマージされると Cloud Composer の DAG へ同期する方法について説明する。

DAG は、ルートディレクトリ直下の `dags/` というディレクトリに格納されている状態を前提とする。

以下の２つのコマンドラインツールを利用して実現できる。

- Service Account の認証のために `gcloud`
- DAG の同期のために `gsutil`

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

1. サービスアカウントのクレデンシャルファイルを CircleCI の環境変数として保存しておき、リダイレクトにより JSON ファイルとして書き出す

```bash
echo "${CLOUD_COMPOSER_CREDENTIALS_JSON}" > ${GOOGLE_APPLICATION_CREDENTIALS}
```

**NOTE:** セキュリティ対策としてクレデンシャルファイルは必ず環境変数として扱う。

2. 1 で生成したクレデンシャルファイルにより、サービスアカウント認証を gcloud コマンドで行う

```bash
gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}
```

3. CloudComposer の DAG が格納されている GCS のバケットを gcloud コマンドで取得して、gsutil コマンドで DAG ファイルの同期を行う

[GCP の Cloud Composer の DAG を素早く・簡単にデバッグする](/posts/2021-09-29/) の記事でも紹介した方法で DAG の同期を行う。

```bash
gsutil -m rsync -d -r dags "$(gcloud composer environments describe {COMPOSER_NAME} --project={GCP_PROJECT} --location={REGION}  --format="get(config.dagGcsPrefix)")"
```

{XXX} には使用する環境の情報を置換してください。

- `"$(gcloud composer environments describe {COMPOSER_NAME} --project={GCP_PROJECT} --location={REGION} --format="get(config.dagGcsPrefix)")"`
  - 指定した GCP Project で動く Cloud Composer の DAG が格納されている GCS のパスを取得できる。
- `gsutil -m rsync -d -r dags`
  - `-m` は並列処理
  - `-d` は元のディレクトリに存在しないファイルがコピー先にあれば削除(ミラーリング)。これにより、GCS 上で DAG を新たに作成して、デバッグしていたとしても、CI が走ればリポジトリにない DAG ファイルは削除され、リポジトリの DAG と完全に同期される。
  - `-r` はディレクトリとしてコピー
  - 上記のオプションにより`dags` ディレクトリの DAG ファイルを GCS にミラーリングで同期を行う。

## Reference

- [gsutil Top-Level Command-Line Options](https://cloud.google.com/storage/docs/gsutil/addlhelp/TopLevelCommandLineOptions)
- [rsync - Synchronize content of two buckets/directories](https://cloud.google.com/storage/docs/gsutil/commands/rsync)
