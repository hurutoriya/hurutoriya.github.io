---
title: "PythonでSQLクエリに変数を挿入して、柔軟にSQLクエリを構築・実行する"
date: 2021-04-29T22:52:25+09:00
lang: ja
author: Shunya Ueta
tags:
- Python
- SQL
---


データ処理のタスクをこなしていると、PythonでSQLに変数を挿入し柔軟にSQLクエリを構築したくなる。
例えば、

- 中間テーブルを作るためにAirFlowなどで定期的なジョブを実行し、SQLの `created`の時間を当日のものに変更する
- `training`, `dev`, `test` でデータを分割する際に、`created`の条件を変更して3パターンのデータを取得する

などが考えられる。

変数をSQLに組み込んで実行したい際には、[kayak/pypika](https://github.com/kayak/pypika)のような SQL builder もあるが、個人的に可読性が悪くなったり、SQLクエリの作成のためだけに余計なパッケージをいれたくない。そのためパッケージを入れずにシンプルに完結する方法をここでは紹介する。

## 1.  単なる文字列としてSQLクエリを構築

```python
def get_guery(num: int, category: str):
	sql=f"SELECT field1, field2, field3, field4 FROM TABLE WHERE condition1={num} AND condition2={category}"
	return sql
```

- f-string で文字列に変数を挿入して、SQLクエリを構築

だが、

- SQLが長くなるとPEP8に準拠せず、[E501 line too long](https://www.flake8rules.com/rules/E501.html)に抵触する
- 視認性が低く、SQLクエリの実行内容を理解しづらい

## 2,  docstring で複数行文字列として扱いSQLクエリを構築

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

- 1番目と比較すると、docstringを挿入しSQLクエリが複数行になることでで見やすい

だが
 
- SQL構文に関する lint や フォーマッターを活用できない
- SQLへのシンタックスハイライトが無いので、視認性が低い

## 3,  SQL ファイルを文字列として読み込み、 `.format()`で変数を挿入する

SQLファイルが `./sql/test.sql` に設置されている状態とする。

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

- SQLクエリを`SQL`ファイルで管理できるので、フォーマッターやシンタックスハイライトの恩恵を活用できる。
- ファイルオブジェクトに対して `.read()`メソッドを使うことで文字列として扱うことができる。そのおかげで、SQLファイルに`{var_1}`, `{var_2}` のような形式で、Python上の変数をSQLの挿入して柔軟にクエリを構築可能になる。

SQLファイルの中にPythonの `.format()` 記法を事前に埋め込むことが今回のコツですね。

### 余談

SQLファイル内に

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

1行目のようなコメントを入れてしまうと、SQLファイルの中ではコメントとして評価される部分もPythnの文字列内では`.format()`の挿入対象となる。その影響で`.format()`で挿入されるべき変数の数が3つと評価されてしまい、実際の引数は2つしか与えておらずエラーが発生する。
SQLファイルのコメントであろうと、`{}`と記述しないように気をつけておきましょう。

## Ref

- [Python SQL query string formatting](https://stackoverflow.com/questions/5243596/python-sql-query-string-formatting)
