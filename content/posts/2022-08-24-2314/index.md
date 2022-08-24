---
title: "Search Engineering Newsletter vol.09"
date: 2022-08-24T23:14:39+09:00
cover:
  image: "/posts/2022-01-16/images/1.png"
author: Shunya Ueta
tags:
  - newsletter
  - search
---

今回のイチオシ記事は、Doug さんの What is a Relevance Engineer? と Ubie さんの Esqa の記事です。

## Search

[Elasticsearch の検索精度のチューニング 〜テストを作って高速かつ安全に〜](https://www.slideshare.net/takahi-i/elasticsearch-251621964?utm_source=pocket_mylist)

[ubie\-oss/esqa](https://github.com/ubie-oss/esqa)という Elasticsearch の検索品質をテストできる OSS の紹介。
検索結果に対して、アサーションや過去と現在のランキングの比較を距離として計算してしきい値以上で計算する事ができるらしい。
検索結果のチューニングの辛い点をできるだけ緩和できそうで、これは便利そう。ステートフルなシステムである検索システムをデグレなどを考慮して日々のメンテナンスするの大変ですよね...

[What is a Relevance Engineer? \- OpenSource Connections](https://opensourceconnections.com/blog/2020/07/16/what-is-a-relevance-engineer/)

日本だとあまり聞き慣れない Relevance Engineer という Job Role ですが、Relevance Engineer に求められる職務内容ってなんだろうと Doug Turnbull さん([Relevant Search](https://amzn.to/3POnmFA)の著者)が執筆した記事。
一般的に日本だと検索エンジニアでひとくくりにされていますが、海外だともう少し細分化されるみたいですね。

- Relevance Engineer は、システムの正確性/関連性(Relevance)とパフォーマンス/安定性の間のスイートスポットにまたがる
  - 8 割の問題は、Relevance Engineer は最先端の手法は追いかけず、伝統的な手法で解決する(BM25, Learning to Rank)。なぜならメンテナンス性、スケーラビリティが共に優れているからである
  - 2 割の問題は、先進的な技術を適用する必要がある。NLP や IR 領域の先端事例を常に把握して、その適用を試みる。
- Relevance Engineer の業務はデータ中心である
  - Relevance Engineer はデータ駆動で課題を解決する。意思決定は Relevance 指標, performance metrics を基準に行う。
  - また、Relevance 指標は一概に Ground Truth を決定できないこともある。その場合は、ドメインエキスパートと協業して、顧客がなぜその結果を好んでいるのかを理解して、データを作って行く必要がある。
  - Relevance Engineer は、Kaggle や学会の課題ではなく実際の企業や顧客の検索課題を解決する。これが意味するのは精度と同程度にシステム面のパフォーマンスにも関心を持っていることを意味する。
- Machine Learning Engineer vs Relevance Engineer
  - 最大の差異は、機械学習に焦点を当てているのか、情報検索に焦点をあてているのか
  - また、Relevance Engineer は検索システムを通じて密接に顧客体験に影響を与えるので、それらを考慮する必要がある。
    `NOTE:` ML Engineer も考慮する必要があると思うので、若干ポジショントーク感が強く感じますね。

[Interview Questions for Search Relevance Engineers, Data Scientists, and Product Managers \| by Daniel Tunkelang \| Medium](https://dtunkelang.medium.com/interview-questions-for-search-relevance-engineers-and-product-managers-7a1b6b8cacea)

Relevance Engineer に対するインタビューの質問リストを Daniel さんが記事として公開してくれている。
基礎的だが、実践的な質問も多いので、一覧するのがおすすめです。

[検索改善を支える A/B testing Infrastructure アーキテクチャの概要 \- DMM inside](https://inside.dmm.com/entry/2022/5/17/engineer-search?utm_source=pocket_mylist)
DMM でどのように検索改善のための AB テストを行っているか。DMM さんは積極的に検索改善を自社でどのように行っているかを公開してくれていてとてもありがたいですね。

検索システム本体に AB テストロジックをインテグレーションせずに、プロキシーサーバーを立ててそこで AB テストを行うのは疎結合に実験的な取り組みができるのは良い戦略ですね。

[Rust 製の全文検索システム Tantivy を Ruby で使える Tantiny を導入した \- portal shit\!](https://portalshit.net/2022/05/16/using-tantivy-over-tantiny?utm_source=pocket_mylist)
Rust のポータビリティの高さのおかげで、数時間で Ruby で全文検索を自分の Blog に提供したお話。

## Machine Learning

[How We Scaled Bert To Serve 1\+ Billion Daily Requests on CPUs \- Roblox Blog](https://blog.roblox.com/2020/05/scaled-bert-serve-1-billion-daily-requests-cpus/?utm_source=pocket_mylist)

ゲーム会社の Roblox が 毎日 10 億以上の Bert を使った API へのリクエストをどうさばいているかのお話。

2019 年の頭に、Roblox では新世代の文章分類モデルを開発を開始した。Bert を試しに検証してみたところ十分な精度が検証できた後に、その後の数カ月間で問題が発生しないレベルの速度にどう達成したかを紹介。PyTorch と Hugging face を活用してモデルの蒸留や量子化などを適用した結果、Latency は 10ms、秒間 3015 のリクエストをさばけるようになったとのこと。高速化に向けて段階的にどのような施策を行っていったかを詳細に説明してくれている。

`NOTE:` ゲームでの NLP 応用ってまず真っ先に思いつくのが有害なメッセージの監視ですね。

[Apache Beam 2\.40 で導入された scikit\-lean, Pytorch の効率的な推論が可能になる RunInference API を試してみる \| 🦅 hurutoriya](http://localhost:1313/posts/2022-08-18-1938/)

表題のとおりですが、Apache Beam 2.40 で追加された RunInference API についての記事を書きました。 Beam の特性を活かした効率的な推論が実行可能になる API です。

[KDD2022 で気になった研究 \| 🦅 hurutoriya](http://localhost:1313/posts/2022-08-15-2335/)
KDD 2022 で気になった研究をまとめました。この Newsletter の読者の方が面白く感じるような研究がたくさんあったので、ぜひ御覧ください。

## 感想など

Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter?f=live) のハッシュタグでつぶやいていただくか、[Google フォーム](https://forms.gle/xFgMwRJbeqJxNtfe9) での感想投稿をお待ちしております。

執筆の励みにさせていただきます。

## Search Engineering Newsletter の購読方法

ニュースレターの更新が気になる方は Newsletter が配信される [RSS](https://shunyaueta.com/tags/newsletter/index.xml)も発行されているので、RSS リーダーで記事を管理したい方はご登録してみてください。
また、今までのニュースレターの一覧は[こちら](https://shunyaueta.com/tags/newsletter/)から閲覧できます。
