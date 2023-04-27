---
title: "Pythonで、変数を挿入して柔軟にSQLクエリを構築する"
date: 2021-04-29T22:52:25+09:00
lang: ja
author: Shunya Ueta
tags:
  - python
  - sql
---

データ処理のタスクをこなしていると、Python で SQL に変数を挿入し柔軟に SQL クエリを構築したくなる。
例えば、

- 中間テーブルを作るために Airflow などで定期的なジョブを実行し、SQL の `created`の時間を当日のものに変更する
- `training`, `dev`, `test` でデータを分割する際に、`created`の条件を変更して 3 パターンのデータを取得する

などが考えられる。

変数を SQL に組み込んで実行したい際には、[kayak/pypika](https://github.com/kayak/pypika)のような SQL builder もあるが、個人的に可読性が悪くなったり、SQL クエリの作成のためだけに余計なパッケージをいれたくない。そのためパッケージを入れずにシンプルに完結する方法をここでは紹介する。

## 編集履歴

- 2021/05/12: twitter で docstring ではなく string literal ですよという指摘をいただき修正 [ref](https://twitter.com/cocu_tan/status/1392481952662310925)
- 2021/05/12: twitter での意見を反映

## 1. 単なる文字列として SQL クエリを構築

```python
def get_guery(num: int, category: str):
	sql=f"SELECT field1, field2, field3, field4 FROM TABLE WHERE condition1={num} AND condition2={category}"
	return sql
```

- f-string で文字列に変数を挿入して、SQL クエリを構築

だが、

- SQL が長くなると PEP8 に準拠せず、[E501 line too long](https://www.flake8rules.com/rules/E501.html)に抵触する
- 視認性が低く、SQL クエリの実行内容を理解しづらい

## 2. 複数行文字列として SQL クエリを構築

```python
def get_guery(num: int, category: str):
    sql = f"""
        SELECT field1, field2, field3, field4
        FROM table
        WHERE condition1={num}
        AND condition2={category}
    """
	return sql
```

- 1 番目と比較すると、複数行を扱える[string literal-longstring](https://docs.python.org/3/reference/lexical_analysis.html#string-and-bytes-literals)を採用することで、SQL クエリが複数行になることでで見やすい (@cocu_tan さん、[ご指摘](https://twitter.com/cocu_tan/status/1392481952662310925)ありがとうございます!)

だが

- SQL 構文に関する lint や フォーマッターを活用できない
- SQL へのシンタックスハイライトが無いので、視認性が低い

## 3. SQL ファイルを文字列として読み込み、 `.format()`で変数を挿入する

SQL ファイルが `./sql/test.sql` に設置されている状態とする。

```sql:test.sql
SELECT
  field1,
  field2,
  field3,
  field4
FROM
  TABLE
WHERE
  condition1={num}
  AND condition2={category}
```

Python 側での実装例

```python
import os


def get_guery(num: int, category: str, filename: str)->str:
    """
    SQLファイルに変数を挿入してクエリを作成する

    Args:
        num (int): 年齢
        category (str): 好きな果物
        filename (str): SQLファイルの名前

    Returns:
        str: SQLクエリ
    """
    with open(os.path.join("./sql", filename), "r") as f:
        return f.read().format(num=num, category=category)

print(get_guery(num=18, category="apple", filename="test.sql"))
```

実行結果

```bash
SELECT
  field1,
  field2,
  field3,
  field4
FROM
  TABLE
WHERE
  condition1=18
  AND condition2=apple
```

- SQL クエリを`SQL`ファイルで管理できるので、フォーマッターやシンタックスハイライトの恩恵を活用できる。
- ファイルオブジェクトに対して `.read()`メソッドを使うことで文字列として扱うことができる。そのおかげで、SQL ファイルに`{var_1}`, `{var_2}` のような形式で、Python 上の変数を SQL の挿入して柔軟にクエリを構築可能になる。

SQL ファイルの中に Python の `.format()` 記法を事前に埋め込むことが今回のコツですね。

### 余談

SQL ファイル内に

```sql:test.sql
-- {}の中にPythonから変数が挿入される
SELECT
  field1,
  field2,
  field3,
  field4
FROM
  TABLE
WHERE
  condition1={num}
  AND condition2={category}
```

1 行目のようなコメントを入れてしまうと、SQL ファイルの中ではコメントとして評価される部分も Pythn の文字列内では`.format()`の挿入対象となる。その影響で`.format()`で挿入されるべき変数の数が 3 つと評価され、実際の引数は 2 つしか与えておらずエラーが発生する。
SQL ファイルのコメントであろうと、`{}`と記述しないように気をつけておきましょう。

## 追記

Twitter でみんなの管理方法をお聞きできたので、記しておく。
ありがたい。

### @shuhei_fujiwara さん

https://twitter.com/shuhei_fujiwara/status/1387815866436243458

> BigQuery の話だけど僕は
>
> - ほとんどの場合 => parameterized query
> - 本当に短くて自明なクエリ => 1 or 2
> - どうにもならんとき => 3
>   https://cloud.google.com/bigquery/docs/parameterized-queries
>   3 はわかるんだけど、Python コードで読み込む前提よりは SQL ファイル単体で成立している方が好きなので可能なら避けてます

単体で成立したい気持ち、たしかに分かる~

### @satoshihirose さん

https://twitter.com/satoshihirose/status/1387776005943840772

> Airflow のみの話にはなってしまいますが、sql はファイルとして管理して基本 jinja template 対応のオペレーター使ってましたね https://qiita.com/munaita_/items/6bdcfb10f36c8c6b4753

Airflow のときに jinja 使えるんですね。今度から使います!

### @reto_nayuta さん

https://twitter.com/reto_nayuta/status/1387801584512364544

> 私も（Airflow ではないですが）jinja 使うことが多いですね

### @SassaHero さん

https://twitter.com/SassaHero/status/1387878168481075200

> 3 を、from string import Template で変数置き換えを実現してます！

`from string import Template` 知らなかった

## Ref

- [Python SQL query string formatting](https://stackoverflow.com/questions/5243596/python-sql-query-string-formatting)
