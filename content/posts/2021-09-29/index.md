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

また、GitHubのリポジトリにDAGを保存して、CIでCloud Composerを更新するようしていると PRを都度作ってマージされないと確認できないという場合もある

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

## GCSに格納されている開発環境上のCloudComposer のDAGファイルを`gstuil cp` コマンドで直接編集して確認

Cloud Composer のDAGは、自動作成されたGoogle Cloud Storageに格納されており、このGCSをCloud Composerが定期的に監視してCloud Composerを更新している。
つまり、少しハッキーな方法だが、GCS上のDAGファイルを直接更新してやるとそれがCloud Composerに反映されて確認ができる。
体感として2-3分に一度は監視されているので、ほぼ待ち状態がない状態で確認ができる。

以下のコマンドで目的のDAGファイルを更新する。
目的のDAGファイルの場所はCloud Composerのページの`DAGs folder`カラムにあるボタンをクリックするとDAGが格納されているGCSページに遷移するので、そこから確認してください。

```bash
gsutil cp {logal_dag}.py {GCS_dag}.py
```

また、以下のように `gcloud composer` コマンドで更新する方法もあるので、そちらを使っても大丈夫です。(実行内容自体はGCSのファイルを変更する)

```bash
gcloud composer environments storage dags delete 
    --environment {ENVIRONMENT_NAME}
    --location {LOCATION} 
    {DAG_NAME}.py
```

__NOTE:__ プロダクションのDAGを直接書き換えるのは危険なのでやめましょう。

### Reference

- [Adding and Updating DAGs (workflows)](https://cloud.google.com/composer/docs/how-to/using/managing-dags)
