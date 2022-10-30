---
title: "Search Engineering Newsletter vol.11"
date: 2022-10-30T22:57:24+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-01-16/images/1.png"
tags:
  - newsletter
  - search
---

## Search

[qdrant/quaterion: Blazing fast framework for fine\-tuning similarity learning models](https://github.com/qdrant/quaterion)

類似学習のための転移学習を高速に実現できるバッケージ。 PyTorch Lightning をベースに作られている。Qdrant という Rust 製のニューラル検索エンジンを開発する企業が開発している。
Rust による検索エンジンの再開発、盛り上がっていますね~

[Qdrant \- Benchmarks](https://qdrant.tech/benchmarks/) のようなベンチマークを公開していますが、ベクター検索エンジンの公平なベンチマークってとても難しそう(小並感)

- [hurutoriya/doraemon\-himitsu\-dogu\-search: Doraemon Himitsu Dogu Japanese hybrid search based on Elascticsearch ANN x multi match](https://github.com/hurutoriya/doraemon-himitsu-dogu-search)
- [Elasticsearch 8\.4 から利用可能な従来の検索機能と近似近傍探索を組み合わせたハイブリッド検索を試す ](https://shunyaueta.com/posts/2022-10-29-2337/)

Elasticsearch8 系から近似近傍探索機能が利用可能になりましたが、従来の検索機能(term, fillter など)と組み合わせることはできませんでしたが、Elasticsearch 8.4 から待望の knn による近似近傍探索と従来の検索を組み合わせたハイブリッド検索が可能になったので、その機能をドラえもんのひみつ道具をデータセットとして収集して検索エンジンアプリを公開してみました。
実際に近似近傍探索の現実的な適用例が爆発的に普及しそうです。
近似近傍探索の結果を特定のカテゴリで枝刈りする(filtter)などが当たり前に実現できれば、クオリティコントロール自体もブレークスルーが起きそうですね。

実は、GCP Matching Engine では近似近傍探索内部でフィルタリングなども可能なのだが、これは Elasticsearch のような仕組みとは違いそうだなと思っている。
[ベクトル一致をフィルタする  \|  Vertex AI  \|  Google Cloud](https://cloud.google.com/vertex-ai/docs/matching-engine/filtering)
また、ちょっと色が違いますが、近似近傍探索自体を部分集合に対して行いたいなどのモチベーションの研究はあり、東大の松井先生などが論文も出されています。
[Reconfigurable Inverted Index](https://yusukematsui.me/project/rii/index.html)

[スタンバイにおける検索への取り組み \- Stanby Tech Blog](https://techblog.stanby.co.jp/entry/queryhandling)

求人検索を提供するスタンバイさんの検索エンジンがどのように構築されているかの記事。Yahoo Japan!さんと連携して検索エンジンを実装している模様。

[Algolia vs Elasticsearch vs Meilisearch vs Typesense Comparison](https://typesense.org/typesense-vs-algolia-vs-elasticsearch-vs-meilisearch/)

Typesense という OSS の検索エンジンが紹介する検索エンジンの比較記事。
言わずもがな Typesense 推しではあるが、比較記事としては面白い。

[【10X/M3/CADDi】検索エンジン運用勉強会 \- connpass](https://m3-engineer.connpass.com/event/256388/)

10X, M3, CADDi さんらが共同で開催した検索エンジンの運用面に注目した勉強会。資料公開非常にありがたいです。

- [検索基盤移行時の思考 \- Speaker Deck](https://speakerdeck.com/po3rin/jian-suo-ji-pan-yi-xing-shi-falsesi-kao)
  - 医者向けと患者向けで検索傾向や仕様が全く異なる中で Elascitsearch を統合したお話。Sudachi の魅力的な機能が紹介されており使ってみたくなった。特に移行時の QA はこれはかなり茨の道なのでお疲れさまでしたとし言いようがない。また、@po3rin さんが自分でぶち当たった課題に対してツールを自分で作成して技術で殴るという姿勢が非常にかっこいいですね。
- [OpenSearch で実現する画像検索とテスト追加で目指す安定運用 \- Speaker Deck](https://speakerdeck.com/caddi_eng/opensearchdeshi-xian-suruhua-xiang-jian-suo-totesutozhui-jia-demu-zhi-suan-ding-yun-yong)
  - OpenSearch(AWS が主導で開発する Elasticsearch をベースにした検索エンジン)の活用事例は国内で初めてみた気がします。選定理由としては、まず kNN(近似近傍探索ではなく、全探索)とフィルタリングの組み合わせが必須条件で、OpenSearch では 2021 年 7 月の時点で導入されていたからとのことです。Elasticsearch は 2022 年 5 月に 8.2 でサポート。
  - また、実際にぶち当たった問題など検索システム運用の奥深さが公開されていて読んでいて面白かったです。PM「ちょっと精度悪いんだけど?」の 22p は、検索システムを運用していく上で、あるある過ぎて笑ってしまった。定量的指標で語り合うこと大事ですよね。
- [10X の検索を 10x したい at 【10X/M3/CADDi】検索エンジン運用勉強会 \- Speaker Deck](https://speakerdeck.com/metalunk/10xfalsejian-suo-wo10xsitai)
  - 本番環境で自動 mapping 使われている場合ってあるんだな?と自分は思ったが、実際みんな使うのだろうか? 怖くないかなと思ったり。ここは読者の方の反応が知りたい。ネットスーパーの検索システムは肝となる体験だと思うのでやりがいがありそう。

[オンラインドキュメントと日本語全文検索](https://voluntas.medium.com/%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%83%89%E3%82%AD%E3%83%A5%E3%83%A1%E3%83%B3%E3%83%88%E3%81%A8%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%85%A8%E6%96%87%E6%A4%9C%E7%B4%A2-30cc38d7b1c3)
Rust 製の検索エンジン Meilisearch を使って、Sphinx のドキュメントを日本語で全文検索可能にしたお話。こういう需要って多そうだけどサクッと実現できるようになったのは素晴らしいですね。例えば、前回紹介した[お手軽な検索 API 構築 | メルカリエンジニアリング](https://engineering.mercari.com/blog/entry/20210906-46976c788c/)でも同じようなことは実現できそうです。

[Amazon Search Query Understanding Page](https://amazonsearchqu.github.io/)

Amazon 検索の Query Understanding チームの成果と構成メンバーの公式サイト。
EC 検索で Query Understanding に興味がある場合は、Amazon の論文を参考にして間違いは無いので、気になったときに参照してみて下さい。

[The Information Retrieval Anthology](https://ir.webis.de/anthology/)

情報検索関係の論文が集約されたサイト、情報検索の論文を探す場合まずはここから探してみるのが良さそうです。

[放送レコメンド機能を TensorFlow Recommenders で作り、AB テストしてみた](https://zenn.dev/canonrock/articles/standfm_user_to_episode)

GCP の機能をモリモリに使って、放送コンテンツの推薦をやってみたよという話。推薦システムを TensorFlow Recommenders で行っており、色々と現状の制約などを知れます。推薦システムを出すのがはじめての状況らしいですが、そこでちゃんと AB テストで評価するという姿勢が良いですね(なぜならプロダクト開発の速度感の兼ね合いもあるので、いつ AB をやるべきなのかという意思決定は難しいので)
有意差は出なかったようですが、一度この仕組みを作ってしまえば AB テストを実施する仕組みはできているので、得るものは大きそうです。

> AI Platform Prediction でサービングしているモデル部分だけで、50 パーセンタイルで 600~700ms,95 パーセンタイルで 1000ms 程度のレイテンシが発生しています。実際にクライアントアプリにおすすめセクションが表示されるまでにはバックエンド側で行っているフィルタリング処理にかかる時間も乗ってくるので、更に+α で時間がかかります。

と AI Platform Prediction のサービングの時間がなかなかにかかるので、もはやオンライン処理は諦めてバッチ処理にしたほうが良いのかなと思える速度ですね。

また、個人的にはもっと軽い仕組み(過去に視聴したカテゴリ、タグなどを推薦とか？)でパーソナライゼーションした場合の AB テストを最初にやってみたほうが迅速に学びを得れるのではと感じました。

## 感想など

Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter?f=live) のハッシュタグでつぶやいていただくか、[Google フォーム](https://forms.gle/xFgMwRJbeqJxNtfe9) での感想投稿をお待ちしております。
執筆の励みにさせていただきます。

## Search Engineering Newsletter の購読方法

ニュースレターの更新が気になる方は Newsletter が配信される [RSS](https://shunyaueta.com/tags/newsletter/index.xml)も発行されているので、RSS リーダーで記事を管理したい方はご登録してみてください。
また、今までのニュースレターの一覧は[こちら](https://shunyaueta.com/tags/newsletter/)から閲覧できます。
