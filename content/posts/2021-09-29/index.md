---
title: "GCPのCloud Composer のDAGを素早く・簡単にデバッグする"
date: 2021-09-29T22:20:23+09:00
author: Shunya Ueta
tags:
- airflow
- gcp
---

GCPでAirflow をマネージドサービスで使えるサービスで Cloud Composer が存在する。
BigQueryやBigTable, PubSub などGCPの各サービスをDAGとして定義してジョブを定期実行できるので非常に便利だが、その代わりDAGを実行するまで結果がわからないので、CloudComposer を一度実行するしか無いのでデバッグが困難になる傾向がある。

また、GitHubのリポジトリにDAGを保存して、CIでCloud Composerを更新するようしていると PRを都度作ってマージされないと確認できないという場合もある。

ローカルでDocker で走らせれば良いのじゃないかというツッコミがあると思いますが、結局 Cloud Composer 上での動作を確かめないといけないので、今回の記事を書くことにしました。

__NOTE:__ 自分が使用しているComposerのversionは`composer-1.8.0-Airflow-1.10.3` です。基本的にやれることは一緒だと思います。また、`dev`, `prod`で同一のDAGが走るCloud Composer を運用しているという前提です。

アプローチは２つ

## logger.info() を仕込んで、DAGのなかで何が起こっているかを理解する

```python
import logging

logger = logging.getLogger(__name__)

logger.info()
```

loggerをDAGを記述した Pythonファイルに仕込んで、内部で何が起こっているかを把握する。

各DAGのlogは、

1. GCPのCloud Composerのページにアクセスして`Airflow webserver` 列のボタンをクリックしてAirflowのWeb applicaiton にログイン
2. 確認したいDAGをクリック
3. DAG内のtask をクリックして表示されるモーダル内の `View Log`をクリックすると、loggerの情報が確認できる

## `gstuil rsync` コマンドでのGCSへのDAGの同期

`gstuil rsync`コマンドを使うことで、リポジトリのDAGファイルをGCSに格納されている開発環境上のCloudComposer のDAGファイルに直接同期してPull Request マージ後のDAGの挙動を確認できる。

Cloud Composer のDAGは、自動作成されたGoogle Cloud Storage(GCS)に格納されており、GCSをCloud Composerが定期的に監視してCloud Composerを更新している。
つまり、GCS上のDAGファイルを直接更新してやるとそれがCloud Composerに反映される。
体感として2-3分に一度は監視されているので、ほぼ待ち状態がない状態で確認できて便利です。

以下のコマンドでリポジトリのDAGファイルをGCSに反映させます。

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

### Composer のための正規のコマンドはあるが...

また、以下のように `gcloud composer environments storage dags import` コマンドで更新する方法もあるので、そちらを使っても大丈夫です。
実行内容自体はGCSのファイルを変更するのと変わりません。
ですが、ディレクトリを対象にしたファイルの同期には対応していないので、上記で説明したコマンドのほうが遥かに楽です。

```bash
gcloud composer environments storage dags import \
    --environment {ENVIRONMENT_NAME} \
    --location {LOCATION} \
    --source {LOCAL_FILE_TO_UPLOAD}
```

__NOTE:__ プロダクションのDAGを直接書き換えるのは危険なのでやめましょう。

## Reference

- [Adding and Updating DAGs (workflows)](https://cloud.google.com/composer/docs/how-to/using/managing-dags)
- [gsutil Top-Level Command-Line Options](https://cloud.google.com/storage/docs/gsutil/addlhelp/TopLevelCommandLineOptions)
- [rsync - Synchronize content of two buckets/directories](https://cloud.google.com/storage/docs/gsutil/commands/rsync)