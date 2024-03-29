---
title: "Standard SQLで 列と列の組み合わせの数を集計したい"
date: 2021-02-09T23:27:37+09:00
lang: ja
tags:
  - sql
  - dataanalysis
---

group by は集計作業において根幹となる処理ですが、少し手の混んだ集計をしたいときに毎回調べていることが多かったのでここに学んだことをまとめておく

今回やりたいことは

A 列が α になっている行の B 列の種類を集計したい

です。

## はじめに

実際のデータを用意したほうが、理解が深まるので擬似的なテーブルを作成する。
テーブルのデータの概略として、何日に sender (送信者) が receiver (受信者) にいくら送金(price)したかを格納しているテーブルとする。

StandardSQL は WITH を使って簡単にモックテーブルを作れるのが良いところ。

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

を`group by` して COUNT(distinct sender)で集計するアプローチがあるが、

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

だが、`day`を基準に送信者、`A`と`B`の情報を 1 行にまとめたい場合はどうすべきだろうか?

### 1 行に 2 列のパターン数をまとめて集計する

`A`と`B`が送り先の数を調べたいなどの目的がある際には、COUNT()を行う際に IF 文で条件を集計することで上記を達成することができる。

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
2. IF(sender='A', receiver, NULL) で、スキャン時に`A`が送信した場合はその同行の`reciver` を返し、`A`でなかった場合は NULL を返す
3. 2 の結果の重複を排除して、その行数をカウントする

上記の処理のイメージ (`2020-01-01`の場合)

1. COUNT(Distinct IF(sender='A',receiver, NULL))
2. COUNT(Distinct (B,B,B,C,D,D,NULL,NULL,NULL))
3. COUNT((B,C,D))
4. 3

となり、`A`が`2020-01-01`に送信した人数は 3 人となる。

#### 結果

| day        | from_A_receiver_uu | from_B_receiver_uu |
| ---------- | ------------------ | ------------------ |
| 2020-01-01 | 3                  | 2                  |
| 2020-01-02 | 1                  | 1                  |

今回は(A,B)の組み合わせで A を固定した際のパターン数を集計したが、A の種類が大規模な場合は SELECT 文をすべて書ききるの現実ではないが、A 自体が有限で集計したい場合はよくある処理なのでメモとしてまとめた。
UU などを計算したいときは必須の集計になると思います。

#### Ref

- [Syntax to count the number of UNIQUE matching values](https://stackoverflow.com/questions/52281618/syntax-to-count-the-number-of-unique-matching-values)
- [How COUNT(DISTINCT [field]) Works in Google BigQuery](https://chartio.com/resources/tutorials/how-countdistinct-field-works-in-google-bigquery/)
