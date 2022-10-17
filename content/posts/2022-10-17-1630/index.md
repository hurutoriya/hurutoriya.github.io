---
title: "CloudComposer の Variables (環境変数)を gcloud cli で取得する"
date: 2022-10-17T16:30:58+09:00
lang: ja
author: Shunya Ueta
tags:
  - airflow
  - gcp
---

[Airflow 1 系で設定されている環境変数を JSON ファイルとして GUI を使って書き出す方法](/posts/2022-10-04-1549/)の続報です。

前回、Airflow CLI からでも環境変数を JSON ファイルとして出力できる[^cloudcomposer-cli]が、手元から実行しても GCP 上のインスタンスにしか保存されなかったので諦めたと書きました。
ですが、その問題を解決できたので、解決方法を公開しておきます。

[Cloud Storage に格納されるデータ  \|  Cloud Composer  \|  Google Cloud](https://cloud.google.com/composer/docs/concepts/cloud-storage#folders_in_the_bucket)によると、Cloud Composer インスタンス内部のディレクトリは GCS にマッピングされているらしい。

マッピング関係は以下( GCP のドキュメントをそのまま引用)

| フォルダ   | Storage パス               | マッピングされたディレクトリ                                                                                                                                                 | 説明                                                                                                               |
| ---------- | -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| DAG        | `gs://bucket-name/dags`    | `/home/airflow/gcs/dags`                                                                                                                                                     | 環境の DAG を保存します。このフォルダ内の DAG のみが環境にスケジュールされます。                                   |
| プラグイン | `gs://bucket-name/plugins` | `/home/airflow/gcs/plugins`                                                                                                                                                  | カスタム プラグインを保存します。カスタムのインハウス Airflow 演算子、フック、センサー、インターフェースなどです。 |
| データ     | `gs://bucket-name/data`    | `/home/airflow/gcs/data`                                                                                                                                                     | タスクが生成して使用するデータを保存します。このフォルダは、すべてのワーカーノードにマウントされます。             |
| ログ       | `gs://bucket-name/logs`    | タスクの Airflow ログを保存します。ログは [Airflow ウェブ インターフェース](https://cloud.google.com/composer/docs/how-to/accessing/airflow-web-interface)でも利用できます。 |                                                                                                                    |

それを使えば、`/home/airflow/gcs/data` にファイルを保存すれば、CloudComposer が保有している GCS の `gs://bucket-name/data` にアクセスすれば、そのファイルが参照可能になる。

実際に以下のようなコマンドを実行したところ、`gs://bucket-name/data` からファイルを参照できました。
めでたい 🎉

```bash
# GCSにファイルを保存
$ gcloud composer environments run COMPOSER_NAME --location LOCATION variables -- --export /home/airflow/gcs/data/airflow_env.json
# 生成されたファイルをGCS上で確認
$ gsutil cat `gs://bucket-name/data/airflow_env.json
```

これで前回紹介したアプローチの欠点である GUI での操作に依存せず、CLI で完結してファイルを作成できるようになったのでミスも減りますね。
このディレクトリと GCS のマッピング機能を考えた人は、頭いいなと思いました。

まず CloudComposer を GCP 上で提供する上で DAG の同期のためにマッピング機能は不可欠なので、最初からこの機能があるんじゃないかと考えるべきでしたね... 反省

[^cloudcomposer-cli]: [python \- Export all Airflow variables \- Stack Overflow](https://stackoverflow.com/questions/53206003/export-all-airflow-variables)
