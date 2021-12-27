---
title: "gRPC client evans で portforward 先のリモートサーバーにリクエストを行う"
date: 2021-08-19T16:51:05+09:00
lang: ja
author: Shunya Ueta
tags:
  - grpc
---

[evans](https://github.com/ktr0731/evans)

evans は対象のサーバーの gRPC のリフレクション機能が起動されていれば、proto ファイルを参照せずに便利な [REPL mode](gRPC のリフレクション機能) を使用できます。

> If your server is enabling gRPC reflection, you can launch Evans with only -r (--reflection) option.

gRPC のリフレクション機能については evans 作者の ktr0731 さんが解説している記事が非常にわかりやすいです。

[gRPC リフレクションはなにをしているか？](https://syfm.hatenablog.com/entry/2020/06/23/235952)

ローカルの 5000 番のポートをリモートサーバの 5000 番ポートにフォワード (port-forward)しているとします。
例えば、`kubectl` だと以下のような実行コマンドになります。

[Forward a local port to a port on the Pod](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/#forward-a-local-port-to-a-port-on-the-pod)

```bash
kubectl port-forward pods/hoge-asas32s 5000:5000
```

そして、ポートフォワードのシェルは保持した上で、別にシェルを起動します。

この際に 対象となる`localhost:5000` に対して、`--host`, `--port` オプションで指定してやれば evans の REPL モードが起動します。

## REPL

```bash
> evans  -r --host localhost --port 5000

  ______
 |  ____|
 | |__    __   __   __ _   _ __    ___
 |  __|   \ \ / /  / _. | | '_ \  / __|
 | |____   \ V /  | (_| | | | | | \__ \
 |______|   \_/    \__,_| |_| |_| |___/

 more expressive universal gRPC client

```

## CLI

CLI は cli というサブコマンドを追記するだけで起動できます。
シェル変数などを使って実行したい場合は、こちらが便利です。

```bash
evans  -r --host localhost --port 5000 cli list
```

evans で快適な gRPC ライフを楽しみましょう。
