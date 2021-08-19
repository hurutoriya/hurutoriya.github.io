---
title: "gRPC client の evans を使って、portforward 先のリモートサーバーに対して REPL を起動する方法"
date: 2021-08-19T16:51:05+09:00
lang: ja
author: Shunya Ueta
tags:
- grpc
- dev
---


[evans](https://github.com/ktr0731/evans) 

evans は対象のサーバーのgRPC のリフレクション機能が起動されていれば、proto ファイルを参照せずに便利な [REPL mode](gRPC のリフレクション機能) を使用できます。

> If your server is enabling gRPC reflection, you can launch Evans with only -r (--reflection) option.

gRPC のリフレクション機能については evans 作者の ktr0731さんが解説している記事が非常にわかりやすいです。

[gRPC リフレクションはなにをしているか？](https://syfm.hatenablog.com/entry/2020/06/23/235952)


ローカルの5000 番のポートをリモートサーバの5000番ポートにフォワード (port-forward)しているとします。
例えば、kubectl だと以下のような実行コマンドになります。

[Forward a local port to a port on the Pod](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/#forward-a-local-port-to-a-port-on-the-pod) 

```bash
kubectl port-forward pods/hoge-asas32s 5000:5000
```

この際に 対象となる`localhost:5000` に対して、`--host`, `--port` オプションで指定してやれば evans のREPLモードが起動します。

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

evans で快適な gRPC ライフを楽しみましょう。