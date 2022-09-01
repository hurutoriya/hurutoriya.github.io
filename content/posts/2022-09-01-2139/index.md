---
title: "Meta が公開したデータ処理の効率化・高速化を狙うエンジン Velox が面白そう"
date: 2022-09-01T21:39:30+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-09-01-2139/images/velox.svg"
tags:
  - dataengineering
---

日課の RSS フィードを眺めていると、クエリエンジンやデータ処理の最適化のための高速化ライブラリが Meta が OSS として公開した[^verox-blog] のを知った。

Velox のリポジトリはこちら

[facebookincubator/velox: A C\+\+ vectorized database acceleration library aimed to optimizing query engines and data processing systems\.](https://github.com/facebookincubator/velox)

実際にリポジトリを観てみると C++で書かれており、たしかにパフォーマンスが高いのが納得。

ドキュメントやチュートリアルなどはこちらのサイトで用意されています。

[Hello from Velox \| Velox](https://velox-lib.io/)

Meta 社内では、Presto や Spark に適用して処理の高速化、PyTorch に活用して前処理や特徴量エンジニアリングの高速化が進められているらしいです。

技術ブログ記事 [^verox-blog]が何をやっているか明瞭なので、かいつまんでメモを残しておきます。

---

- SQL の分析、ストリーミング処理や機械学習のためのデータ処理など実際の処理内容は似通っているが、様々なフレームワークが使われ、独立して進化している。
  - この断片化によって、保守と拡張が困難になっていたが、それらを統合する形で実行可能にするのが Verox
- Presto, Spark などのデータ処理エンジンは、一見異なるように見えるが、レイヤー構造で考えると非常に似通っている。
  - Verox は一般的に実行エンジンレイヤーの代わりとなり、式評価、集約、ソート、結合などの処理を提供する。(一般的に data plane と呼ばれる)
- 実例と結果
  - Presto は Java で実行されるが、それを C++の Velox で置き換えた。Prestissimo というプロジェクト名で進んだ。(カッコいいね)
    - Java での実行と比べると、大体 6 倍ほど高速化された
  - Spark 上では、[Gluten](https://github.com/oap-project/gluten) とよばれるプロジェクトで Velox と同じように C++での実行を試みるプロジェクトが公開されている。
  - PyTorch の [TorchArrow](https://pytorch.org/torcharrow/beta/index.html)を Velox 上で実行可能

最終的には、Velox で従来のデータマネジメントの部分と機械学習インフラストラクチャの部分の垣根を統一することを狙っている。

---

詳細な内容を知りたい方は、VLDB2022 で論文として発表された[^vldb]ので、そちらを読むと良さそうです。

実際に実行して手で触ってみたいという方は、10 分で始める Verox というチュートリアル資料[^verox-10m]があったので、そちらを読むと良さそうです。
コードを眺めると Verox がどんなことをしてくれるのかイメージが付きました。
ものすごく野心的な試みで、これからの発展が楽しみなプロジェクトでした。

[^verox-blog]: [Introducing Velox: An open source unified execution engine](https://engineering.fb.com/2022/08/31/open-source/velox/)
[^vldb]: [Meta’s Unified Execution Engine at VLDB2022\- Meta Research](https://research.facebook.com/publications/velox-metas-unified-execution-engine/)
[^verox-10m]: [Velox in 10 minutes — Velox documentation](https://facebookincubator.github.io/velox/velox-in-10-min.html)
