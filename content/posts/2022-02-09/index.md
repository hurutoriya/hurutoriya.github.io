---
title: "Search Engineering Newsletter vol.02"
date: 2022-02-09T22:17:06+09:00
lang: ja
author: Shunya Ueta
tags:
  - newsletter
  - search
---

2 回目のニュースレター配信です。

前回の人気記事 Top3 を紹介

1. [LINE MUSIC が挑んだパフォーマンス改善。膨大な楽曲数を扱うための Elasticsearch の設計](https://engineering.linecorp.com/ja/interview/line-music-elasticsearch/) 7 clicks
1. [Elasticsearch Learning to Rank プラグインの使い方とポイント](https://techblog.zozo.com/entry/elasticsearch-learning-to-rank-plugin) 5 clicks
1. [DMM の検索に機械学習を導入して、A/B テストで圧勝した考え方](https://inside.dmm.com/entry/2021/12/30/search_machinelearning) 4 clicks

## Articles

### Search

[Building a Search Technology Radar](https://opensourceconnections.com/blog/2022/01/10/search-technology-radar)

`Technology Radar` という概念を検索技術領域に適用してみたよという記事。
`Technology Radar` をざっくり紹介すると、同心円状の領域を 4 象限に分割して、中心に近ければ近いほど必ずこの技術に適応していおくべき、そして中心から外れていくと将来的に重要になっていくだろうというトピックを可視化する概念。
概念としては面白んだが、ざっくりしすぎてるなと思っていたら著者の Eric さんが気になる領域を挙げてくれていた。

- The Rise of Neural Search
  - Neural Search の定義としては、形態素ベースの検索を超えた検索手法の総称(広すぎる...w)。 Neural Search は今はみんな使っていないけれども、近いうちに使い始める未来が来るんじゃないかという予想
- Blossoming of Non Lucene-based Engines

  - 長年全文検索エンジンの Lucene ベースの検索サーバーである Elasticsearch, Solr がメインで使われてきたが。最近は非 Lucene ベースの検索エンジンも出てきた。例として挙げられたソフトウェアとしては
    - [Tantivy](https://github.com/quickwit-oss/tantivy): Java 言語ではなく Rust で書かれた Lucene の再実装
    - [milvus](https://milvus.io/), [weaviate](https://github.com/semi-technologies/weaviate): ベクトル検索エンジン

[メルカリの検索基盤の変遷について](https://engineering.mercari.com/blog/entry/20220207-776318b784/)

[Blog Series of Introduction of Developer Productivity Engineering at Mercari](https://engineering.mercari.com/en/blog/entry/20220116-blog-series-of-introduction-of-developer-productivity-engineering-at-mercari/)の一環で公開されたメルカリの検索基盤の変遷について詳細に語られた記事。
2013 年の創業当初の Solr から、Elastic Cloud on Kubernetes への運用と現在に至るまでの変遷を語ってくれており非常に面白い記事になっています。
現状のメルカリの検索システムを詳細に語っているのは初めてだと思うので、その点でも面白い記事ですね。

[検索の応答性能を維持するための Benchmarking Automation](https://engineering.mercari.com/blog/entry/20220207-8ff8aad53e/)

こちらも同様の Blog series で公開された、メルカリでの検索システムの応答速度のベンチマーキングについて説明された記事になっています。ベンチマーキングを行う際に考慮する点なども書かれていて、実際に自分たちで検索システムのベンチマーキングを行う際にも参考になりそうです。

### 検索システムのベンチマーキングや CI 事例

検索システムのベンチマーキングや CI 関連に興味があって調べてみた。

#### Lucene

[Lucene nightly benchmarks](http://people.apache.org/~mikemccand/lucenebench/index.html)

2011 年から Mike McCandless さんがメンテンスしている Lucene nightly benchmarks。
作成経緯としては[Catching slowdowns in Lucene](https://blog.mikemccandless.com/2011/04/catching-slowdowns-in-lucene.html) で紹介されている。
2011 年の Superbowl では Twitter で、4064 tweet/second がインデックスされていて、それらがリアルタイムに検索可能だったなど当時の検索システムの最先端を歴史をしれて面白い記事なので、興味のある方はぜひ読んでみてください。
また、2011 年にリリースされた nightly benchmarks は現在も活発にメンテンスされていて、Mike さんやはり神。

#### Elasticsearch

[Elasticsearch Benchmarks](https://elasticsearch-benchmarks.elastic.co/)

Lucene nightly benchmarks におそらく影響を受けた、Elasticsearch の benchmark 結果。
[elastic/rally](https://github.com/elastic/rally) rally という Elasticsearch のための Macrobenchmarking framework を使ってベンチマーキングされている。
rally の日本語での使い方解説は @pakio さんがわかりやすく記事を書いてくれていました。

[Elasticsearch 公式のベンチマーキングツール : Rally](https://zenn.dev/pakio/articles/esrally-tutorial)

#### Solr

[Solr Nightly Benchmarks](https://michael-sun-github.github.io/index.html)

Solr も Nightligh benchmarks が提供されているが、Lucene や Elasticsearch とまだ未完成な印象。該当する JIRA のチケット([SOLR-10317](https://issues.apache.org/jira/browse/SOLR-10317))もまだ close されていない?

---

上記の Nightliy benchmarks は単一の検索エンジンで、パフォーマンスの劣化が起きていないかを定点観測するのが目的です。

逆に検索エンジン間でのパフォーマンスを計測したい場合は
[Search Benchmark, the Game](https://tantivy-search.github.io/bench/) などが面白そうです。

#### 検索システムの Continuous Integration 事例

以前抄訳した Amazon での Lucene 活用事例では、

[Amazon が e コマース検索を Lucene により、どうスケールさせているか at Berlin Buzzwords 2019](https://shunyaueta.com/posts/2021-11-26/)

Amazon は検索サーバーに変更を加えるたびに CI でインデックス構築をして Release ready な状態まで自動化されているというのはエキサイティングで面白かった。
...が、逆にこれ以外の検索システムの CI 事例は自分は見たことが無いので誰か知っている方いたら教えて欲しい。

### Machine Learning

[Product Lessons from ML Home: Spotify’s One-Stop Shop for Machine Learning
](https://engineering.atspotify.com/2022/01/19/product-lessons-from-ml-home-spotifys-one-stop-shop-for-machine-learning)

Spotify で内製機械学基盤の運用を通じて学んだことを紹介。
機械学習ワークフロー自体は社内基盤で完結できるようになっていたが、課題点を洗い出し、以下の２つにまず取り組んだ。

- 中央集権的に集約されたメタデータレイヤー(モデルや、評価結果、学習データの関係性など)
- ワークフローから生成されるメタデータを追跡・管理できるレイヤーの提供

作成した内製基盤の技術的な解説というよりも、内製基盤開発ってここが辛いよね・ハマるよねをつらつらと書いてくれていた。機械学習に関わらず、社内の内製基盤開発をしている人は面白く読めそう。

[Testing ML Systems: Code, Data and Models](https://madewithml.com/courses/mlops/testing/)

機械学習のコード、データ、モデルをどうやってテストしていくかの解説記事。
Pytest を使って実際にどのように test を書いていけばよいかをわかりやすく記事を書いてくれている。機械学習のデータやモデルの振る舞いをどうテストするかの具体例を網羅的に説明してくれているので素晴らしい記事だった。

機械学習の振る舞いに対してテストはかけないと言われがちな気もするが、やれることはある(かつやるべきことはある)のでこの記事を参考に取り組んでみると良さそう。特に実際にデプロイしてみると挙動が想定していたものと異なるケースとかに遭遇するのを減らせるのは事前に test するのが最も近道かつ確実ですよね。

[MLOps を支えるヤフー独自のモデルモニタリングサービス](https://techblog.yahoo.co.jp/entry/2022013130257343)

なぜ独自内製の決断した背景をちゃんと説明してくれていたのは素晴らしい記事だった。提供した結果、データドリフトを検知できてすぐさま対応できたというのは良い話。内製でここまで作り上げる体力は凄い。

[Vertex Model Monitoring で活用する、Google の MLOps 監視手法](https://cloud.google.com/blog/ja/topics/developers-practitioners/monitor-models-training-serving-skew-vertex-ai)

Google 内部で実際に Training-serving skew でどのような課題に直面したのかを公開してくれるのはありがたいし、なぜ必要なのかの必然性の説得力が上がるから素晴らしいですね。

[390 億から 820 億パラメータへ｜ LINE の巨大言語モデル HyperCLOVA 開発の裏側](https://ainow.ai/2022/01/31/262132)

LINE での大規模汎用言語モデルの開発裏話を @overlast さんが赤裸々に話してくれている。

> モデルの構築は、67 億、130 億、390 億とパラメータを小さいサイズから順番に積み上げています。130 億の時、精度がガクンと落ちてしまったんですが、データを整えるなどの試行錯誤をしていくと 390 億の時に突き抜けて高くなったんですね。
> このように、宝探しやハッカソンのように実際に試してみないとわからないことがとても多く、そのうえ、1 回の試行錯誤に 2 週間〜1 ヶ月必要だったのが大変でした。
> またコーパス作りも大変でした。モデルを学習させるデータは基本的には権利関係を明確にしながら、法律面だけでなく感情面的なところにも深く配慮してコーパスを作りました。

ここらへんのチラ裏的な話がめちゃくちゃおもしろかったです。130 億でがくんと落ちた後に 390 億に挑戦したのは読んでいるこっちがハラハラした。一回の試行錯誤に 2 週間から一ヶ月かかるというのも精神衛生上つらそうだけど、それを乗り越えて大規模汎用言語モデルの開発を推進していってるのは、ただただ凄い。

> なので、HyperCLOVA 以外で問題なく公開できるモデルに関しては、オープンソースにしていこうと動いています。

の点は、[NEologd](https://github.com/neologd/mecab-ipadic-neologd)の開発者の overlast さんだからこその、とてつもない信頼感がある

関連した動きとしては

[rinna 社、日本語に特化した 13 億パラメータの GPT 言語モデルを公開](https://prtimes.jp/main/html/rd/p/000000025.000070041.html)

の記事。日本語に特化した GPT 言語モデルを商用可能なライセンスで公開したのは素晴らしいですね。
[Huggingface でモデルが公開](https://huggingface.co/rinna/japanese-gpt-1b)されていて、Web 上でどんな結果になるのかものすごくお手軽に試せるのは感動ですね。Notebook とか開くまでもなく、Web 上で推論結果をさっと試せれる Huggingfface のプラットフォームが凄い。
