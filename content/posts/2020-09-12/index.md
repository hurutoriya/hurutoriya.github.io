---
title: "Google BigQuery でクエリのUnit Testを行う"
date: 2020-09-12T00:41:50+09:00
draft: true
lang: ja
tags:
- Google BigQuery
- GCP
- Test
---

Google BigQueryを普段から使っている皆様、待望の [ASSERT 機能](https://cloud.google.com/bigquery/docs/reference/standard-sql/debugging-statements
)が2020/07/13 に[公開](https://cloud.google.com/bigquery/docs/release-notes#July_13_2020)されました

## なんで SQL にASSERTが必要なのか？

- データは壊れる
- SQLは期待したデータを返しているか?

過去に [BigQueryを使う処理のテストをどう書くか](https://qiita.com/hagino3000/items/87bdf22bff16811f90bb)などの記事が書かれていますが、この記事待望の

はてなさんが、公開してくれている記事の["壊れにくい"データ基盤を構築するためにMackerelチームで実践していること](https://developer.hatenastaff.com/entry/2020/08/04/093000)もとても面白く、データ活用のためには絶えずデータの整備を行わないと、気づかぬうちにデータの品質は低下していきます。
