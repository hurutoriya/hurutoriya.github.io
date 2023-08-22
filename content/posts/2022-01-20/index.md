---
title: "OSS の Google BigQuery UDF `bqutil.fn` を使えば UDF の独自実装を置き換えられるかもしれない"
date: 2022-01-20T00:03:07+09:00
lang: ja
author: Shunya Ueta
tags:
  - bigquery
  - gcp
---

## TL;DR;

UDF を独自実装する前に、`bqutil.fn`を眺めておくと車輪の再発明が回避できるかも

## 背景

SQL は、特定の処理を行う際にデータの型が同一でないとエラーが発生しますが、もとのスキーマを紹介するよりももっとお手軽にカラムの型を確認したいときがありませんか?

例えば、出力結果を見ただけでは、`12345` が STRING なのか INT64 なのか判別不可能ですよね。(もし判別可能な方法知っている人いたら教えて下さい...)

## GCP による OSS UDF の bqutil.fn

なのでお手軽に BigQuery の結果の型を確認したい時になにか良い方法がないかなと調べていたら、OSS で`bqutil.fn`という UDF が GCP から提供されていた。

例えば型の確認の場合、以下の ユーザー定義関数（UDF) はどの GCP プロジェクトから実行しても実行可能

```sql
bqutil.fn.typeof()
```

この`bqutil.fn` は[bigquery-utils/udfs/community/](https://github.com/GoogleCloudPlatform/bigquery-utils/tree/master/udfs/community#typeofinput-any-type)のディレクトリに格納されている UDF が`bqutil` という GCP プロジェクトの`fn` データセットに同期されているので、どの GCP プロジェクトの Google BigQuery から実行しても `bqutil.fn.typeof()`を実行可能にしているらしい。
頭良い

> This directory contains community contributed user-defined functions to extend BigQuery for more specialized usage patterns. Each UDF within this directory will be automatically synchronized to the bqutil project within the fn dataset for reference in queries.

実際に以下のクエリを Google BigQuery で実行すると

```sql
SELECT
  bqutil.fn.typeof(""),
  bqutil.fn.typeof(b""),
  bqutil.fn.typeof(1.0),
  bqutil.fn.typeof(STRUCT()),
```

```
STRING
BYTES
FLOAT64
STRUCT
```

の結果が出力され、各カラムのデータの型を確認できる。

![result](/posts/2022-01-20/images/1.png)

便利!

これで置き換え可能な UDF は置き換えればメンテンスしないといけない UDF が削減されて嬉しいですね

`bqutil.fn.typeof()` の UDF の実態としては
[bigquery-utils/udfs/community/typeof.sqlx](https://github.com/GoogleCloudPlatform/bigquery-utils/blob/master/udfs/community/typeof.sqlx)が参照されて実行されている。

他にも

- URL の key を抽出できる[bqutil.fn.url_keys()](https://github.com/GoogleCloudPlatform/bigquery-utils/tree/master/udfs/community#url_keysquery-string)
- ランダムな値を出力できる[bqutil.fn.url_keys()](https://github.com/GoogleCloudPlatform/bigquery-utils/tree/master/udfs/community#random_valuearr-any-type)

など、自前で正規表現で頑張って書いているけど実際は OSS の UDF として公開されているケースも多々ありそうなかゆいところに手が届く UDF が多数公開されていた。

変わり種としては、
[StatsLib: Statistical UDFs](https://github.com/GoogleCloudPlatform/bigquery-utils/tree/master/udfs/community#statslib-statistical-udfs)という統計的な処理を行う UDF も公開されていた。

線形回帰や p 値の計算ができる UDF も公開されており、面白い

## References

- [bigquery type check operator? like typeof in Javascript; or workaround](https://stackoverflow.com/questions/43730045/bigquery-type-check-operator-like-typeof-in-javascript-or-workaround)
- [typeof(input ANY TYPE)](https://github.com/GoogleCloudPlatform/bigquery-utils/tree/master/udfs/community#typeofinput-any-type)
