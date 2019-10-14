---
title: "遅すぎる pandas.read_gbq を使わずに、Google BigQueryから巨大なデータをダウンロードする"
date: 2019-10-03T23:52:54+09:00
lang: ja
tags:
- GCP
- BigQuery
- pandas
---

[pandas.read_gbq](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.read_gbq.html) 便利ですよね。
クレデンシャルファイルを認証画面からコピペすればJupyter上でさっと動き、Google Big Queryが実行されてその結果がそのままデータフレームとして扱えます。
JupyterとGoogle BQを連携させたいときはいつも使っています

## 問題点

- そこそこ大きなデータを持ってこようとするとめちゃくちゃ遅くてストレスが半端ない

解決方法として、Google Big Query で巨大なデータをダウンロードする方法について書く

実はGoogle の公式ドキュメントでも記載されている。

- https://cloud.google.com/bigquery/docs/pandas-gbq-migration
- https://cloud.google.com/bigquery/docs/bigquery-storage-python-pandas


方法は以下の２つ。

1. `google-cloud-bigquery` をインストールして、マジックコマンドでGoogle BQを実行
2. BQ実行→BigQuery table として保存→GCSへ保存→ `gsutil` でマシンへコピー

1番目は、Jupyter上でマジックコマンドでGoogle BQが実行できて、速度も `pandas.rad_gbq` よりも高速です
2番目はそもそも実行結果が巨大な場合で、目安としては`1GB以上`なら2番目の方法を使えば楽です。


### 1, `google-cloud-bigquery` をインストールして、マジックコマンドでGoogle BQを実行

```python
pip install --upgrade google-cloud-bigquery[bqstorage,pandas]

```

magic commandを実行

```python
%load_ext google.cloud.bigquery
```

後はJupyter Notebookのセルで以下のコマンドぞを実行すれば、

```
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

`df` にマジックコマンドで実行したSQLの実行結果が格納されます!
便利ですね!

### 2, BQ実行→BigQuery table として保存→GCSへ保存→ `gsutil` でマシンへコピー

1. BigQuery でクエリを実行、実行結果を BigQuery Tableへ保存

- 注)実行結果の容量が巨大なので、保存先は基本的にBig Query Tableへ保存するしか選択肢が無い

- ![can't export large file as one file](/posts/2019-10-03_how_to_download_learge_data_from_google_bq/export-to-bqtable.png)

2. BigQuery table からGCSへテーブルをCSVとして保存

Big Query tableからエクスポート時に、ファイルサイズが大きいとエクスポートできないので、分割が必要です。

- ![can't export large file as one file](/posts/2019-10-03_how_to_download_learge_data_from_google_bq/cant-export-onefile.png)


https://cloud.google.com/bigquery/docs/exporting-data

保存ファイル名を
```
file-*
```

のようにワイルドカードを指定すると、自動的にひとつのテーブルを複数ファイルに分割して保存してくれる

3. `gsutil` commands で任意のマシンへダウンロードする。

`-m` オプションを付け足すと並列ダウンロードが始まるので、複数ファイルダウンロードする場合はおすすめ

ストレスレスなデータ分析ライフを!

