---
title: "gRPCurl で `Failed to process proto source files.: could not parse given files:` エラーが出たときの対処方法"
date: 2022-04-28T21:14:16+09:00
lang: ja
author: Shunya Ueta
tags:
  - development
---

gRPCurl [^grpcurl] を使ってリクエストを送る際に、 reflection を機能を使わずに protobufs のファイルを読み込もうとすると

```bash
Failed to process proto source files.: could not parse given files: ~ no such file or directory
```

とエラーがでてコマンドが実行できなかった。

対処方法としては grpcurl コマンドを実行する際に、`-proto` フラグを利用するだけではなく、`-import-path` フラグを指定する必要がある[^proto]。

`-import-path`フラグの指定により、参照する protobufs の依存関係のパスを grpcurl に伝えることで上記のエラーが解消される。

例えば、protobufs の内部で

```proto
import "~/---.proto"
```

のように他の protobufs を import していると上記のエラーの発生原因となる。

つまり、`-import-path`を指定しないと、import 文実行時に grpcurl 内部で、参照する protobufs の root path が不明なので、パスがうまく処理されずに import 文の実行処理がコケてしまうと理解。

[^grpcurl]: [fullstorydev/grpcurl: Like cURL, but for gRPC: Command\-line tool for interacting with gRPC servers](https://github.com/fullstorydev/grpcurl)
[^proto]: [Proto Source Files](https://github.com/fullstorydev/grpcurl#proto-source-files)
