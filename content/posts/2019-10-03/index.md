---
title: "遅すぎる `pandas.read_gbq` を使わずに、Google BigQueryから高速にデータを読み込む"
date: 2019-10-03T23:52:54+09:00
lang: ja
author: Shunya Ueta
tags:
  - gcp
  - bigquery
  - pandas
  - python
---

[pandas.read_gbq](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_gbq.html) 便利ですよね。
クレデンシャルファイルを認証画面からコピペすれば Jupyter Notebook上で簡単に認証され、Google BigQuery が実行されてその結果がそのままデータフレームとして扱えます。
Jupyter Notebookと Google BigQuery を連携させたいときは愛用していました(過去形)。

## 問題点

- そこそこ大きなデータを持ってこようとすると、めちゃくちゃ遅くてストレスが凄い

解決方法として、Google BigQuery で巨大なデータをダウンロードする方法について書きます。

実は Google の公式ドキュメントでも推奨されています。

- https://cloud.google.com/bigquery/docs/pandas-gbq-migration
- https://cloud.google.com/bigquery/docs/bigquery-storage-python-pandas

方法は以下の２つ。

1. `google-cloud-bigquery` をインストールして、マジックコマンドで Google BQ を実行
2. BQ 実行 →BigQuery table として保存 →GCS へ保存 → `gsutil` でマシンへコピー

1 番目は、Jupyter 上でマジックコマンドで Google BQ が実行できて、速度も `pandas.rad_gbq` よりも高速です
2 番目はそもそも実行結果が巨大な場合で、目安としては`1GB以上`なら 2 番目の方法を使えば楽です。

### 1, `google-cloud-bigquery` をインストールして、Jupyter Notebookのマジックコマンドで Google BQ を実行

```python
pip install --upgrade google-cloud-bigquery[bqstorage,pandas]
```

magic command を実行

```python
%load_ext google.cloud.bigquery
```

後は Jupyter Notebook のセルで以下のコマンドを実行すれば、

```python
%%bigquery df --use_bqstorage_api
SELECT
  CONCAT(
    'https://stackoverflow.com/questions/',
    CAST(id as STRING)) as url,
  view_count
FROM `bigquery-public-data.stackoverflow.posts_questions`
WHERE tags like '%google-bigquery%'
ORDER BY view_count DESC
LIMIT 10
```

`df` にマジックコマンドで実行した SQL の実行結果が格納されます!
便利ですね

### 2, BQ 実行 →BigQuery table として保存 →GCS へ保存 → `gsutil` でマシンへコピー

-  BigQuery でクエリを実行、実行結果を BigQuery Table へ保存
- 注)実行結果の容量が巨大なので、保存先は基本的に Big Query Table へ保存するしか選択肢が無い

![can't export large file as one file](/posts/2019-10-03/images/export-to-bqtable.png)

- BigQuery table から GCS へテーブルを CSV として保存

Big Query table からエクスポート時に、ファイルサイズが大きいとエクスポートできないので、分割が必要です。

![can't export large file as one file](/posts/2019-10-03/images/cant-export-onefile.png)

https://cloud.google.com/bigquery/docs/exporting-data

保存ファイル名を `file-*` のようにワイルドカードを指定すると、自動的にひとつのテーブルを複数ファイルに分割して保存してくれる

`gsutil` commands で任意のマシンへダウンロードする。

`-m` オプションを付け足すと並列ダウンロードが始まるので、複数ファイルダウンロードする場合はおすすめです

ストレスレスなデータ分析ライフを!
