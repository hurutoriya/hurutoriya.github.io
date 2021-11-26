---
title: "Amazonでは Lucene によりeコマース検索をどうスケールさせているか"
date: 2021-11-26T20:59:21+09:00
lang: ja
author: Shunya Ueta
draft: true
tags:
- search
- amazon
- lucene
---

[情報検索・検索技術 Advent Calendar 2021](https://adventar.org/calendars/6430) 1日目の記事です。

[Berlin Buzzwords](https://2021.berlinbuzzwords.de/) はドイツで毎年開催されているOSSでの検索、データ処理、データベースに焦点をあてたカンファレンスです。

検索関係のシステムに携わっている場合、毎年面白い内容が目白押しなのでぜひとも見てほしい。

今回は Berlin Buzzwords 2019 で発表された「AmazonではLucene をどう活用してeコマース検索をスケールさせているか」の講演動画を社内勉強会で紹介するために視聴したので、そのメモを公開する。

## E-Commerce search at scale on Apache Lucene

- [YouTube](https://www.youtube.com/watch?v=EkkzSLstSAE)
- [Web page](https://2019.berlinbuzzwords.de/19/session/e-commerce-search-scale-apache-lucene-tm.html)
- [PDF](https://2019.berlinbuzzwords.de/sites/2019.berlinbuzzwords.de/files/media/documents/bbuzzamazonlucene2019.pdf)

自分の所感などを切り分けるため、自分の意見はIMOではじめた文にして、メモっています。

## Overview

- クエリのp999レイテンシーに対して非常に厳しい制限を行っている
    - IMO: p99.9 を監視しているのはたしかにとてもシビア。 
- Amazonの query rate はめちゃくちゃピーキー (daily, weekly, yearly)
- Why Lucene?
    - Lucene は成熟しており、豊富な検索エンジンの機能が揃っている
    - 情熱を持ったコミュニティが存在している
    - Uber, Airbnb, Linkedin 全部 Lucene を使っている
    - [maxscore scoring](https://issues.apache.org/jira/browse/LUCENE-4100) , Weak AND, Lucene 8.0 での Codec の衝撃
- Lucene design
    - 純粋な 100% Java で書かれている
    - on-disc search with small in-memory index
    - 巨大な index を扱えるが、小さなRAMで実行可能
    - 高い並列性を兼ね揃えたインデキシングと検索機能
    - ニアリアルタイムでの検索とインデキシング機能
- Amazon でのLucene利用例
    - ニアリアルタイムでのセグメントレプリケーション (Solr, Elastic Search とは別のレプリケーションの仕組み)
        - IMO: 登壇者のMike さんが Lucene 6.0 をベースにした Near realtime replicationが可能な[lucene server](https://github.com/mikemccand/luceneserver) を公開している。
        - yelp が2021/09にOSSとして、上記のlucene server をベースにしたOSSを公開。解説記事も公開してくれている。[Nrtsearch: Yelp’s Fast, Scalable and Cost Effective Search Engine](https://engineeringblog.yelp.com/2021/09/nrtsearch-yelps-fast-scalable-and-cost-effective-search-engine.html)
    - 並行検索→複数のスレッドでの並行検索処理が可能 (Luceneで利用可能だが、Solr, ElasticSearchでは2019年時点では利用不可)
    - query time ではなく、index time でjoin を行いデータの結合を行っている。Lucene 6.0 で追加されたBKD-tree を利用した Dimensional points機能は、多次元空間を効率的に検索することができ、プライムデーで重宝されている。
    - また拡張性の高いデザインのおかげでカスタマイズも容易。
    - Custom term frequency などもとても便利。当初Lucene にこの機能は存在しなかったので、我々で機能開発を行いLucene にこの機能が搭載された。
    - 2019年時点では、Solr, Elastic Searchを使っていない。理由としては、Concurrent faceting, multi-phase ranking などの機能はSolr, Elastic Search は当時は利用できなかった。また、現時点でLucene ベースでのモジュールを多数開発しているのも要因。
- Open Source at Amazon
    - パフォーマンス課題や小さなバグなどを発見して、それらを解決していった。これはコミュニティみんなが嬉しい。(Solr, Elastic Search にも還元されるのでとても健全な流れだよね)
    - 以下のLucene の機能はAmazon が開発を行い、貢献した
        - Custom term frequencies
        - Concurrent indexing updates
        - Concurrent faceting
        - FST direct arc addressing
            - [該当チケット](https://issues.apache.org/jira/browse/LUCENE-8781)
            - 日本語での解説記事: [Luceneで使われてるFSTを実装してみた（正規表現マッチ：VMアプローチへの招待）](https://qiita.com/ikawaha/items/be95304a803020e1b2d1)
        - Off-heaps FSTs

## Service architecture 

- Near-real-time replicaiton
    - Black Friday や Prime day などの爆発的にアクセスが増加するイベントなどに対応するために作成
    - Solr, Elastic Search で提供されるdocument level レプリケーションでは限界がある
- Service architecture
    - AWSで構築
    - ECSコンテナでインデクサー、サーチャーが稼働している
    - Kinesis, DynamoDBからカタログが更新される
    - ニアリアルタイムで、S3にインデックスは保存される
    - インデックスはソフトウェアが更新されるたびに、全て再構築される
    - 人為的なクエリでサービスを暖機運転
- Service system design
    - ![Amazon serarch architecture](/posts/2021-12-01/images/1.png)
    - リクエストが来た際に、Collators がリクエストをさばいて、適切なview に割り振る。
    - Index(i001, i002, ...) はS3にリアルタイムで保存され、service はそのindex を読み込んで検索を行って、レスポンスを返す。
- Searching a segmented index
    - Lucene には検索インデックスが必要で、分割型のアーキテクチャとなっている
    - merge して結果を返す
- Searching a segmented index concurrently
    - index は統計的に商品品質によりソート済
    - この機能はシャードが巨大化している我々にとってレイテンシーを抑えるために非常に有用な機能
- p999 latency figure
	- 青色のグラフの挙動は、Lucene の分割型アーキテクチャによって発生しており、並行検索がどのように優位性をもっているのかを説明する。縦軸は latency
	- 緑色のグラフは、どれくらいのサイズのセグメントがレプリカにコピーされているかを示している。縦軸は GB。
		- 大きなセグメントがマージされたときにスパイクが発生する
        - 通常は、小さなインデックスがマージされて大きなインデックスになることは良いことである、なぜならたくさんのファイルを開く必要がなくなるし、すべてのセグメントを探索しなくても良くなる。
        - だが、Amazonの場合は、並行検索を行っているので、大きなセグメントが存在すると逆にレイテンシーが増加の原因となる。なぜならセグメントの数が減少すると、検索の並行性も失われるため。例えば、10のセグメントがあった場合、10スレッドで並行検索を行えるが、一つのセグメントになってしまった場合、1スレッドでの検索しかできなくなる。例えば一つのセグメントに対して、複数スレッドで並行検索できるようになればさらなる改善が見込めると考えている。
	- セグメントインデックスに対して、並行検索が可能になったことで、大きなセグメントを取り扱うことを避けれるようになった

## Performance mesurement

- Bemchmarking
	- [Lucene nightly benchmarks](https://home.apache.org/~mikemccand/lucenebench/)
    - 上記と同じような方法で、各種クエリのパフォーマンスを常に測定している。
	- perfoamance regression の検知は困難
	- performance だけではなく、検索性能も自動的に評価
- Concurrent refresh
	- Lucene は、並行リフレッシュのために、インデックスサイドのアプリケーションのスレッドを借りるという問題があった
    - 解決方法として、インデキシングが行われていないときのみ並行リフレッシュを行う機能を開発
        - [Solution: use expert Lucene API to refresh concurrently ](https://issues.apache.org/jira/browse/LUCENE-8700)
- Gathering metrics using Lucene’s abstractions
	- Lucene の抽象化機能を使って、各指標を容易にモニタリング可能に
- Garbate correction is too hard
    - IMO: ここらへんは知識が足りず理解できなかったので、後から勉強

## Analysis challanges

- Context sensitive analysis
    - planeは何を意味する?
    - おもちゃのairplane? `plane ←→ airplane` の同義語
    - synonym 拡張ををindex time のみで行う 
- Numbers a special
    - Toy for 3 year old というクエリには、 2-4歳対象という文章は対象になる
    - 1500ml は 1.5 litters とマッチするべき
    - 1,100、1100、1.100 は一緒で、1/100、1:100 とは違う
    - 標準的な tokenizer の後に上記のハンドリングをするのは難しい
    - 句読点の取り扱いには注意
- WordDelimiterGraphFiltter
    - [Lucene docs](https://lucene.apache.org/core/7_4_0/analyzers-common/org/apache/lucene/analysis/miscellaneous/WordDelimiterGraphFilter.html)
        - 英語と数字の分割など細かい前処理が可能になる
            - e.g. "SD500" → "SD", "500"
    - 機械学習はこの問題は解決可能だが、検索ではこのような機能もやはりまだ必要である。
        - IMO: Lucene の機能を使って解決可能なら、たしかにできる限り機械学習を使いたくない気持ちは非常に共感できる。ここまでレイテンシーの制約が厳しいなら増加要因は可能な限り抑えたい...

## Query optimization

- Indexed Queries
    - 多くのクエリは共通のフィルターを使っている。
    - 大元のインデックスに対して、共通で使われているフィルターを適用した結果を、インデキシングしてる? (post-processing index)。
    - single term に置き換えて、パフォーマンスをチューニング
- Factoring queries
    - Boolean query 
    - [FP growth algorithm](https://towardsdatascience.com/the-fp-growth-algorithm-1ffa20e839b8)
- Query 最適化のおかげで、 +30% redline QPS が増加。p99 latency は 81ms から 54ms へ。
    - IMO: P99のレイテンシー公開して良いだろうか...??? (p99.9 は公開していなかったので気になる)
- Indexing tuples 
    - multi stage search を single stage に圧縮している
    - IMO: ここらへんの最適化は、Lucene の検索の仕組みをもっと理解しないとどうやって実現しているかまだ深く理解できない
- Lighting deals using dimensional points
	- 当初はmike さんにより、地理検索などを目的として作られた機能。だが、地理検索には使用せず、Amazon でのlighting deal に三次元データ(start time, end time, id) での三次元検索にこのdimensional points 機能を使ってる。
	- IMO: by @takuya-a さん
        - 社内で発表した際に、なぜstart-time, end-time の2次元ではなく、idを入れた3次元にした検索にしたのかという質問に対する完璧な @takuya-a さんの推測
		-  > IDも空間インデックスに含めることで、パフォーマンスを上げているのだとおもいます。IDが別フィールドだと、そっちのインデックスも検索して、空間インデックスの検索結果とマージして、って処理が後段で必要になるのですが、最初からIDも含めておくと BKD-tree の検索で全部処理できちゃうので。同じ期間で別のIDをもつセール対象商品がヒットしないので最初の段階でかなり絞り込めるようになるのだと思います
	-  BKD tree の解説は @pon さんの記事がわかりやすいです
		-  [検索エンジンの数値インデックスを支える Bkd-Tree](https://po3rin.com/blog/bkdtree)

## Multi phase ranking

- Ranking
	- Machine Leraning models
	- Multi phase ranking
	- [Prorated early termination](https://issues.apache.org/jira/browse/LUCENE-8681)
    - IMO: スコアリングの知識が欠如しているのでメモだけ
- Summary
	- Amazonで検索してるときにはLucene が使われているよ100%ではないけども

## Question

- Q. indexing synonym を行っていると言っていたが、例えば query timing でsynonym を扱えれば、検索者の文脈などを考慮した同義語を扱えるのではないのだろうか?
    - A. indexing synonym は主に効率性を重視した意思決定であり、基本的にトレードオフの関係となっている。Query rewrite なども行っているが、今回のトークは主に検索エンジンなので優先順的にQuery Understanding 関係の話はしていません。

## Reference

- [What Amazon gets by giving back to Apache Lucene](https://aws.amazon.com/jp/blogs/opensource/amazon-giving-back-apache-lucene/)

Lucene に詳しい同僚からは、Lucene に興味あるならこの本がおすすめと言われので読んでおきたい。
ちなみに著者は、この講演者のうちの一人であるMike McCandless さん... (14年間Lucene の開発をしている!!)

- [Lucene in Action 2nd edition](https://amzn.to/3FP8DWn)

余談ですが、この人のことを同僚が、

> Lucene 界隈では神として知られていますね

と言っていて、笑ったw

*** 

[情報検索・検索技術 Advent Calendar 2021](https://adventar.org/calendars/6430)  の次の記事は
@sz_dr さんで4日目を担当してくれます!
