---
title: "Standard SQLのCOALESCEで、時間経過によってカラム名が変化したデータを柔軟に抽出する"
date: 2021-11-06T22:40:02+09:00
lang: ja
author: Shunya Ueta
tags:
- sql
- bigquery
---

データの蓄積帰還が長くなってくると、例えば JSON形式でログを取っているが、同じデータでもマイグレーションやロギングロジックの更新などで`key` の名前が変化したりする場合がある。

その場合取り扱いに困るのが、古いkeyと新しいkey をどのように併合するかだ。
例えば特定の日次できれいにデータが入れ替わっているのなら、色々やりようがあるが、クライアントなどのログの場合データの変化も均一ではないので、徐々に変化していることが大半なので、日次で別々の抽出をして結合するというアプローチも難しい。

その際に役立つのが Standard SQL 条件付き構文の [COALESCE]((https://cloud.google.com/bigquery/docs/reference/standard-sql/conditional_expressions#coalesce)) だ。

`COALECSCE` は、引数の最初の非NULLの値を返す関数で、

```sql
COALESCE(NULL, 'B', 'C') 
```
だと `B`が返される。この関数を使うことで、複数カラムを一つに併合することができる。

## 具体例を交えつつ実践してみる

例えば、以下のように昔のカラム名が `title` で、全く同じデータが新しいカラムの `title_v2` に入ってきているとする。

__NOTE:__ json を例題にkeyの抽出にしたほうが実際の状況に沿いますが、カラムのみで表現したほうが説明が簡単なので今回はそちらを採用。

### 用意したデータ

```sql
WITH menues AS
 (SELECT "うどん" as title, NULL as title_v2, "2021/10/06" as created UNION ALL
  SELECT "ラーメン", NULL, "2021/10/07"  UNION ALL
  SELECT NULL, "そば", "2021/10/08" UNION ALL
  SELECT "カツ丼", NULL, "2021/10/09" UNION ALL
  SELECT "カツ丼", "カツ丼", "2021/10/10" UNION ALL
  SELECT NULL, "カレー", "2021/10/11")
SELECT * FROM menues
```

***

| title | title\_v2 | created    |
| ----- | --------- | ---------- |
| うどん   |           | 2021/10/06 |
| ラーメン  |           | 2021/10/07 |
|       | そば        | 2021/10/08 |
| カツ丼   |           | 2021/10/09 |
| カツ丼   | カツ丼       | 2021/10/10 |
|       | カレー       | 2021/10/11 |

`2021/10/10` のデータなどは旧カラムと新カラムにダブルライトされています。

### COALESCE で複数カラムを併合する

```sql
WITH menues AS
 (SELECT "うどん" as title, NULL as title_v2, "2021/10/06" as created UNION ALL
  SELECT "ラーメン", NULL, "2021/10/07"  UNION ALL
  SELECT NULL, "そば", "2021/10/08" UNION ALL
  SELECT "カツ丼", NULL, "2021/10/09" UNION ALL
  SELECT "カツ丼", "カツ丼", "2021/10/09" UNION ALL
  SELECT NULL, "カレー", "2021/10/10")
SELECT
COALESCE(title, title_v2) as title,
created
FROM menues
```

#### 結果

| title | created    |
| ----- | ---------- |
| うどん   | 2021/10/06 |
| ラーメン  | 2021/10/07 |
| そば    | 2021/10/08 |
| カツ丼   | 2021/10/09 |
| カツ丼   | 2021/10/09 |
| カレー   | 2021/10/10 |

はい、上記の結果のように`COALESCE` を使えば２つの時間経過によって別れてしまったカラムを一つのカラムとして併合することができました。非常に便利ですね。
## Reference

[BigQuery Conditional expressions- COALESCE](https://cloud.google.com/bigquery/docs/reference/standard-sql/conditional_expressions#coalesce)