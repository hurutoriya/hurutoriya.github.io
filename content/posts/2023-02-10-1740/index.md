---
title: "redis-cli の結果を標準出力として受け取って jq できれいに表示したい"
date: 2023-02-10T17:40:23+09:00
lang: ja
author: Shunya Ueta
tags:
  - redis
  - cli
---

## 動機

Redis を扱っているのだが、その際にデバッグ用途で、内部で保存されているデータを `redis-cli` で対象の redis に対してコマンドを実行して確認する。

だがこのままだとコマンドの結果が JSON として返されるが見にくいので見やすく整形したいのが動機。

### 詳細

自分が知っている方法だと

```shell
redis-cli
```

で、対象の redis に対してコマンドを実行できるインタラクティブモードに入る。
そして以下のコマンドを実行すると、VALUE の結果が確認できる。

```shell
get KEY
```

この結果は JSON として出力されるが、ターミナル上では整形されず非常に見づらかった。

## 解決方法

よく見ると公式ドキュメントに書かれていた[^redis-std]。

以下のように redis-cli と同じ行で、redis に対して実行したいコマンドを追記して実行すれば、標準出力として表示される。

```shell
redis-cli get KEY
```

この結果が JSON として出力され、可読性を向上させるために jq[^jq] で整形したい場合は、以下のようなコマンドを実行すればよい

```shell
redis-cli get KEY | jq .
```

[^redis-std]:
    > To run a Redis command and return a standard output at the terminal, include the command to execute as separate arguments of `redis-cli`. https://redis.io/docs/ui/cli/

[^jq]: [jq - jq is a lightweight and flexible command-line JSON processor.](https://stedolan.github.io/jq/)
