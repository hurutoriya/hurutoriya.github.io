---
title: "Service Account が実行している BigQuery Job を確認しようとして、Job IDが REDACTED と表示されている場合は権限不足"
date: 2024-02-22T14:53:42+09:00
lang: ja
author: Shunya Ueta
tags:
  - bigquery
  - gcp
---

タイトルのまんまです。

[ジョブの管理  \|  BigQuery  \|  Google Cloud](https://cloud.google.com/bigquery/docs/managing-jobs?hl=ja#required_permissions)

で紹介されていますが、
`roles/bigquery.admin`の権限が必要です。

完全に落とし穴なのが、BQ Job の project history を WEB の UI で見ようとしても、権限が不足していますなどのメッセージは表示されないので、何かしら不具合なのかなと思ってしまうのが罠でした。

![](/posts/2024-02-22-1453/images/bq_job_history.png)

まんまとかかりました。
REDACTED bq job と調べたら、stackoverflow が出てきて助かった。

[ REDACTED Error in BigQuery project history tab while submitting google datastream job \- Stack Overflow](https://stackoverflow.com/questions/75539865/redacted-error-in-bigquery-project-history-tab-while-submitting-google-datastr)
