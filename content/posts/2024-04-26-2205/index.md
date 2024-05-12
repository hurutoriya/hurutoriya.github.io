---
title: "検索エンジンOSS勉強会 第2回を開催した"
date: 2024-04-26T22:05:04+09:00
lang: ja
author: Shunya Ueta
tags:
  - 検索エンジンOSS勉強会
  - vespa
  - opensearch
  - lucene
---

検索エンジン OSS 勉強会の第 2 回を開催しました。

この勉強会に興味ある人は、[検索エンジン OSS 勉強会 ガイドライン \- Google ドキュメント](https://docs.google.com/document/d/13UC8xhI67qIiNZCRH8fEjRPi5fmeuivJ3-s2Ke_U0CE/edit) から参加できます!

## 発表内容

- @hotchpotch せこんさん
  - [Vespa の Multi\-Vector HNSW の実装を読む](https://p0q.notion.site/Vespa-Multi-Vector-HNSW-7050cc005a16489c9b19cea0eec5e8a3)
    - Github の URL 末尾に、`.diff` や `.patch`をつけることで、LLM(Claude)に読ませて code reading したとのこと。めちゃくちゃ頭いいですね。そのまま commit page や PR の URL 渡すよりも余分な情報がないから明快に説明してくれそうです。
    - 日本語 ReRank モデルを ONNX に変換して、そのまま vespa 上で動かしていたりとひたすら手を動かされていてすごい。
    - 各 OSS で multi vector index をどのように扱うのか、そしてパフォーマンス劣化はどれくらい起こるのかは気になる話ですね。 Elasticsearch の nested field はパフォーマンスが悪化するので
- @gteu さん
  - [OpenSearch の Filtering を理解する @昨日](https://iced-goat-d86.notion.site/OpenSearch-Filtering-29cf842d38b941c6a8c0cb71ab7e71b4)
  - 図を交えた説明でわかりやすかったです。
  - フィルタ条件がすでに既知なら、Post filter やるよりも Pre filter のほうが良いのではという疑問があったが、Post filter は逐次的に ANN を終えたあとに filter を愚直に行えばいいだけだが、 Pre filter の場合は filter をかけてしまうと HNSW のグラフが壊れるといっており、確かにパフォーマンスを考慮したうえでの実装面での難易度は高そう。
  - Lucene が Efficient k-NN filtering を実装して、それを OpenSearch が追う形で Opensearch の faiss コンポーネント内部で実装したとのこと。faiss 本家では filter 需要というか実装するという話はでてきているのだろうか?
  - @johtani さんが共有してくれたが、[Move max vector dims limit to Codec by mayya\-sharipova · Pull Request \#12436 · apache/lucene](https://github.com/apache/lucene/pull/12436) Lucene のベクトルの上限が Codec で設定できるようにして、各ユーザーが自由にベクトルの上限を設定できるようになったとのこと。この方向性はみんな幸せになるし、ベクトルの次元の大きさを各自が設定可能に

発表してくれたお二人に感謝です!

自分は家庭の事情で発表予定でしたが時間が捻出できず無念の時代となりました...が他の人の発表聞いてるとモチベーションが上がったのでありがたいお話です。

## 今回の余談

- Go 言語製の検索エンジン bleve に https://github.com/blevesearch/bleve/releases 2.4 から vector serach が可能になった話がきになったり、 backend は faiss っぽいです。
- NVIDIA の cu family の一環で cuvs という OSS が作成されていた。 https://github.com/rapidsai/cuvs
- qdrant ですが、ANN の filtering の問題は、Lucene, OpenSearch とは異なる独自の方法で解決してるっぽいですね https://qdrant.tech/articles/filtrable-hnsw/ 。 @gteu さんに教えてもらいました。
