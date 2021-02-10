---
title: "Standard SQLで 列と列の組み合わせの数を集計する"
date: 2021-02-09T23:27:37+09:00
lang: ja
tags:
- SQL
- Data Analysis
---

group by は集計作業において根幹となる処理ですが、少し込み入った集計をしたいときに毎回調べていることが多かったのでここに学んだことをまとめておく

## はじめに

実際のデータを用意したほうが、理解が深まるので擬似的なテーブルを作成する
テーブルのデータの概略として、sender (送信者) が receiver (受信者) にprice(いくら)を何日に送金したかを格納しているテーブルとする

StandardSQLはWITHを使って簡単にモックテーブルを作れるのが良いところ

```sql
#standardSQL
WITH
  `transactions` AS (
  SELECT
    'A' AS sender,
    'B' AS receiver,
    600 AS price,
    '2020-01-01' AS day
  UNION ALL
  SELECT
    'A',
    'B',
    1200,
    '2020-01-01'
  UNION ALL
  SELECT
    'A',
    'B',
    600,
    '2020-01-01'
  UNION ALL
  SELECT
    'A',
    'C',
    2000,
    '2020-01-01'
  UNION ALL
  SELECT
    'A',
    'D',
    3000,
    '2020-01-01'
  UNION ALL
  SELECT
    'A',
    'D',
    2000,
    '2020-01-01'
  UNION ALL
  SELECT
    'B',
    'C',
    700,
    '2020-01-01'
  UNION ALL
  SELECT
    'B',
    'C',
    300,
    '2020-01-01'
  UNION ALL
  SELECT
    'B',
    'D',
    250,
    '2020-01-01'
  UNION ALL
  SELECT
    'A',
    'B',
    400,
    '2020-01-02'
  UNION ALL
  SELECT
    'A',
    'B',
    1000,
    '2020-01-02'
  UNION ALL
  SELECT
    'A',
    'B',
    1200,
    '2020-01-02'
  UNION ALL
  SELECT
    'A',
    'B',
    2000,
    '2020-01-02'
  UNION ALL
  SELECT
    'B',
    'C',
    450,
    '2020-01-02'
  UNION ALL
  SELECT
    'B',
    'C',
    500,
    '2020-01-02' )
SELECT
    *
FROM
  transactions
```

| sender | receiver | price | day        |
| ------ | -------- | ----- | ---------- |
| A      | B        | 600   | 2020-01-01 |
| A      | B        | 1200  | 2020-01-01 |
| A      | B        | 1800  | 2020-01-01 |
| A      | C        | 2000  | 2020-01-01 |
| A      | D        | 3000  | 2020-01-01 |
| A      | D        | 2000  | 2020-01-01 |
| B      | C        | 700   | 2020-01-01 |
| B      | C        | 300   | 2020-01-01 |
| B      | D        | 250   | 2020-01-01 |
| A      | B        | 400   | 2020-01-02 |
| A      | B        | 1000  | 2020-01-02 |
| A      | B        | 1200  | 2020-01-02 |
| A      | B        | 2000  | 2020-01-02 |
| B      | C        | 450   | 2020-01-02 |
| B      | C        | 500   | 2020-01-02 |

## 列と列の組み合わせの数を集計する

日次ごとに送金者が何人に送ったかを集計したい、つまり(sender, receiver)のペアを考えて、sender を固定した上で何人に送金したいかを集計したとする。
上記のデータだと

2020-01-01 では {(A,B), (A,C), (A,D)} の三通りになる。

愚直に思いつくのは

### group by を２つの列で行うパターン

- day
- sender

を`group by` してCOUNT(distinct sender)で集計するアプローチがあるが、

```sql
SELECT
  day,
  sender,
  COUNT(distinct  receiver) AS receiver_uu
FROM
  transactions
GROUP BY
  day,
  sender
```

#### 結果

| day        | sender | receiver_uu |
| ---------- | ------ | ----------- |
| 2020-01-01 | A      | 3           |
| 2020-01-01 | B      | 2           |
| 2020-01-02 | A      | 1           |
| 2020-01-02 | B      | 1           |

`day`, `sender` の組み合わせとなっている。
このクエリを WITH でテーブルにして、Where でフィルターをかけると

```sql
receiver_uu AS (
  SELECT
    day,
    sender,
    COUNT(DISTINCT receiver) AS receiver_uu
  FROM
    transactions
  GROUP BY
    day,
    sender)
SELECT
  *
FROM
  receiver_uu
WHERE
  sender = 'A'
```

| day        | sender | receiver_uu |
| ---------- | ------ | ----------- |
| 2020-01-01 | A      | 3           |
| 2020-01-02 | A      | 1           |

の結果が得られる。

だが、`day`を基準に送信者、`A`と`B`の情報を1行にまとめたい場合はどうすべきだろうか?

### 1行に2列のパターン数をまとめて集計する

`A`と`B`が送り先の数を調べたいなどの目的がある際には、COUNT()を行う際にIF文で条件を集計することで上記を達成することができる。

```sql
SELECT
  day,
  COUNT(DISTINCT
    -- 以下の結果の重複排除
  IF
    (sender='A',
      -- sender がAだったときに
      receiver,
      -- receiver を返す
      NULL)
    -- それいがいはNULL
    ) AS from_A_receiver_uu,
  COUNT(DISTINCT
  IF
    (sender='B',
      receiver,
      NULL)) AS from_B_receiver_uu
FROM
  transactions
GROUP BY
  day
```

流れを説明すると

1. day で日次を基準にした計算を行う
2. IF(sender='A', receiver, NULL) で、スキャン時にAが送信した場合はその同行のreciver を返し、Aでなかった場合はNULLを返す
3. 2の結果の重複を排除して、その行数をカウントする

上記の処理のイメージ (`2020-01-01`の場合)

1. COUNT(Distinct IF(sender='A',receiver, NULL))
2. COUNT(Distinct (B,B,B,C,D,D,NULL,NULL,NULL))
3. COUNT((B,C,D))
4. 3

となり、Aが`2020-01-01`に送信した人数は3人となる。

#### 結果

| day        | from_A_receiver_uu | from_B_receiver_uu |
| ---------- | ------------------ | ------------------ |
| 2020-01-01 | 3                  | 2                  |
| 2020-01-02 | 1                  | 1                  |

今回は(A,B)の組み合わせでAを固定した際のパターン数を集計したが、Aの種類が大規模な場合はSELECT文をすべて書ききるの現実ではないが、A自体が有限で集計したい場合はよくある処理なのでメモとしてまとめた。

#### Ref

- [Syntax to count the number of UNIQUE matching values](https://stackoverflow.com/questions/52281618/syntax-to-count-the-number-of-unique-matching-values)
- [How COUNT(DISTINCT [field]) Works in Google BigQuery](https://chartio.com/resources/tutorials/how-countdistinct-field-works-in-google-bigquery/)