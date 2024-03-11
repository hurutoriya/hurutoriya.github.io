---
title: "検索エンジンOSS勉強会 第1回を開催した"
date: 2024-03-11T23:32:26+09:00
lang: ja
author: Shunya Ueta
tags:
  - 検索エンジンOSS勉強会
  - lucene
  - vespa
---

検索エンジン OSS 勉強会 の第一回を開催した。

この勉強会に興味ある人は、[検索エンジン OSS 勉強会 ガイドライン \- Google ドキュメント](https://docs.google.com/document/d/13UC8xhI67qIiNZCRH8fEjRPi5fmeuivJ3-s2Ke_U0CE/edit) から参加できます!

## 発表内容

- [Apache Lucene の PR \#12962 Speedup concurrent multi\-segment HNSW graph search 2 を理解したい 検索エンジン OSS 勉強会](https://shunyaueta.com/posts/2024-03-11-0120/)
  - 自分は近似近傍探索で複数のセグメントに対して並行検索を可能にする PR を解説した。PR 自体の粒度も大きくなく、どのように複数セグメントに対して分散的に近似近傍探索を実現したかを理解できた。気がする。
  - この発表の締め切り駆動で、頑張って読む時間を捻出して読むことができた。締め切り駆動をしたいわけではないが、人に説明しようとするとちゃんと考えて理解しようとするので、本腰を入れて読めた。
  - 実際にここはこう動いているんだよと説明できるようになるって、楽しいですね。自分が尊敬する h_nakagawa さんの名言の「コード読め、コード読んだら何が起きているかは理解できる」に一歩踏み出せた感じがして良い。
- [Vespa の ColBERT 実装をツマミ読んで得られた知見 \- そもそも Vespa や ColBERT とは?](https://p0q.notion.site/Vespa-ColBERT-Vespa-ColBERT-d896152d78c54de092a59384a784a792)
  - [セコン](https://secon.dev/)さんが一週間前に飛び入りで発表表明してくれて非常に感謝。
  - 自分で色々と精力的に手を動かして成果を公開されていてすごい。

## 懇親会と言う名の雑談で話したトピック

- [Increase max number of vector dims to 2048 by mayya\-sharipova · Pull Request \#95257 · elastic/elasticsearch](https://github.com/elastic/elasticsearch/pull/95257)
  - 近似近傍探索で Elasticserach は 2048 次元まで扱えるように、パッチを当てている。Lucene は 1024 次元までという制約を取り払っている
- 最近は OpenAI の embedding などはパラメータで次元数を指定できるとセコンさんから聞いた。
- [OpenSearch で実現する画像検索とテスト追加で目指す安定運用 \- Speaker Deck](https://speakerdeck.com/caddi_eng/opensearchdeshi-xian-suruhua-xiang-jian-suo-totesutozhui-jia-demu-zhi-suan-ding-yun-yong?slide=10)
  - 近似近傍探索を実運用する際に考慮したい点って色々と異なる。
    - 例えば自分の場合は filter と組み合わせて近似近傍探索をやりたい

これからもゆるーく、OSS への貢献を前提にした検索エンジン OSS 勉強会を続けていきます。

- 1.5-2 ヶ月の間隔で開催していけたらなと思います
- 今回突発的に開催した懇親会も良い感じに盛り上がれるように考えている。内容としては、ちょっと検索システムで考えていること話したいとかの場とかにできたらなと考えています。
