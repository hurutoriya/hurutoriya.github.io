---
title: "Search Engineering Newsletter vol.06"
date: 2022-05-24T23:46:38+09:00
author: Shunya Ueta
lang: ja
cover:
  image: "/posts/2022-01-16/images/1.png"
tags:
  - newsletter
  - search
---

六回目の配信です。
今回のイチオシは、DoorDash の検索システム刷新の記事です。

## Search

[Apache Solr Release Notes](https://solr.apache.org/news.html)

Solr 9.0.0 がリリースされました。
Elasticsearch と同じく、 Lucene 9 の ANN をサポートしたことにより、近傍探索機能が追加された。

[Apache Solr 9.0.0 がリリースされました！ - KandaSearch](https://kandasearch.com/news/ac714a31-4a94-42fa-9f2f-3c3da4adc323)

リリース文の日本語訳も公開されていました。

> Also in 9.0 is a brand new Solr Ref Guide, completely re-organized and built on @antoraproject
> which gives us a dozen features we've wanted like search. Which is probably the one you really wanted too:
> https://solr.apache.org/guide/solr/latest/ > https://twitter.com/childerelda/status/1524854759022379017

Solr 9 のリリースに伴い、Apache Solr Reference Guide も再編成されました。検索機能がサイトに搭載されたと言及されているので便利になったのでは?

[On\-device Text\-to\-Image Search with TensorFlow Lite Searcher Library — The TensorFlow Blog](https://blog.tensorflow.org/2022/05/on-device-text-to-image-search-with.html)

TensorFlow Lite を使ってデバイス上での言語クエリから画像検索を行った解説記事。
デバイス上で、検索クエリに対応する画像の埋め込みベクトルを ScaNN(Google が開発した近似近傍探索のアルゴリズム)で近似近傍を行い、Top N 枚の画像のメタデータを検索する。つまり、デバイス上には画像のメタデータのみ保有しており、画像自体は例えばネット経由で表示させることも可能。
記事内では、画像をデバイスに保存しているような記述はなかったので、画像の埋め込み空間のみ保持している模様。
Pixel 6 での実機テストでは、各検索クエリは 6m sec で完結しているらしくすべてデバイス上で完結するだけはある鬼の速さ。

初めて知ったが、[TensorFlow Lite Model Maker](https://www.tensorflow.org/lite/guide/model_maker) というライブラリを使うことで、TensorFlow Lite の学習を簡素化できるらしい。

[ユーザの地域考慮＋機械学習モデルによる CTR 改善 〜 ヤフー検索の入力補助機能での事例 - Yahoo! JAPAN Tech Blog](https://techblog.yahoo.co.jp/entry/2022051130300827/)

関連検索ワードの精度を地理情報によりパーソナライズしてみたお話。
地理に依存したクエリにおいて曖昧性回避のために有効だが、地理情報ごとに QAC のインデックスを作成するの大変そう。
大まかに分けても地方ごと(関西・関東とか?)にインデックスを作成するのだろうか...?

実験結果で、CTR がスマートフォンと PC だと結果が顕著に分かれており、検索結果の上部と下部で PC だと下部が CTR が下がっていて面白かった。
考察しようとしたけどここまで差異がでるのはなぜか思いつかなかった..
これも Web 検索ならではの取り組みがいがある課題ですね。

[OpenSearchCon 2022 · OpenSearch](https://opensearch.org/blog/community/2022/05/opensearchcon/)

2022.09.21 に OpenSearch(Elasticsearch をベースに AWS 主体で開発している検索エンジン)のカンファレンスが開催予定。
OpenSearch は近似近傍探索[^opensaerch-knn]で、 nmslib や faiss を利用しており本元の Elasticsearch と違う方向性に変化していきそうなので、今後に期待している。

[3 Changes to Expand DoorDash’s Product Search Beyond Delivery](https://doordash.engineering/2022/05/10/3-changes-to-expand-doordashs-product-search/)

フードデリバリーユニコーンの DoorDash が検索システムで機能を刷新した 3 つの点を解説した記事。
DoorDash の技術ブログは、機械学習[^doordash-ml]や検索システム[^doordash-saerch]など、自分の興味ある分野で良質な記事が目白押しなので毎回更新を楽しみにしています。

かなり面白かったので深堀りして抄訳しました。

---

### 3 Changes to Expand DoorDash’s Product Search Beyond Delivery 要点まとめ

当初はフードデリバリーのみだったが DoorDash の検索機能は、料理のメニュー検索のために作成された。
ビジネス拡大に伴い、料理のメニュー以外にも、スーパーの食材や雑貨、アルコールやペットフードなど様々な種類の製品を検索可能にする必要があった。

1. まず、データレイヤーの視点では、商品のメニュー以外に検索機能を拡大する際に、スーパーの食材などは SKU の単位として非常に粒度が細かく、領域が拡大するたびにその領域に合わせたデータをインデックスする必要がある。
1. また、新しい領域にビジネスを拡大する際には、膨大な数の SKU にラベル付をする必要があるが、スケールさせるために機械学習ベースの手法でラベリングをスケールさせた。

それら２つの課題を解決するために新しく検索システムのインフラを刷新し、 Query undestanding, Document Understanding によって検索結果のランキングを改善する。

具体的に何をやったのか?

- Rebuilding search infrastructure for new challenges
  - `active/nextgen indexing`: まず DoorDash の事業形態として、高速にインデックスを更新する必要がある。(`NOTE:`オンライン何かをオーダーする際に、検索インデックスが更新されていなかったので、検索結果には表示されていたけど売り切れてるような体験は避けたいですよね)
  - `federated search`: 食料品、料理、アルコールなど複数領域の検索結果を混ぜる
  - `new search storage`: 上記を可能にする検索インフラ
- Improving query and document understanding
  - `new taxonomies`: Query & Document understanding のために、機械学習を用いた製品のラベリングシステムを開発
- Learning-to-rank
  - `learning-to-rank & evaluation system`: Rerank の仕組みと、検索結果の評価を可能にするフレームワークを開発。(モデルの詳細は後日データサイエンスチームがブログ記事を書いてくれるとのこと)

#### Rebuilding search infrastructure for new challenges

##### Implementing active/nextgen indexing

以前 DoorDash は[Building Faster Indexing with Apache Kafka and Elasticsearch \- DoorDash Engineering Blog](https://doordash.engineering/2021/07/14/open-source-search-indexing/) の記事で紹介されたように、Apache Kafka を使って Elasticsaerch へのインデキシング速度を

- 店舗のカタログ全体を backfill する時間を 1 週間から 6.5 時間に短縮
- 商品のカタログ全体を backfill する時間を 2 週間から 6.5 時間に短縮
- 再インデックス(re-index)の時間を 1 週間から 2 時間に短縮

と劇的に改善したが、そこから更にインデキシング速度を向上させた。

具体的なアプローチとして再インデックスをやめて逐次インデキシングを採用することで、優先度の高いデータをリアルタイムに検索エンジンに反映することができるようになった。

##### Building a federated search

料理、雑貨、食品など複数領域の検索結果を混ぜる federated saerch を導入。
`NOTE`: イメージとしては、各領域ごとに検索システムのマイクロサービスを作成して、それらの検索結果を混ぜるマイクロサービスも開発した感じです。

初期はレストラン(料理)検索のみに対応した検索エンジンだったが、新システムでは水平に各領域の検索を行い混ぜることができるようになったので、対応領域拡大の際に、インデックスなどの既存のコードを書き換え対応する必要がなくなった。
また、検索とランキングが水平に分離されたことで、各領域に特化して柔軟に検索性能を向上させることができる。

また、 federated saerch の実現により例えば一つの領域の検索システムがダウンしたとしても検索システム全体がダウンすることは避けることが可能になった。

##### New search storage engine

Elasticsearch を採用していたが、様々な課題が見えてきたので新しい検索エンジンの検討を開始した。
Apache Lucene をベースにして検索システムを構築した。
利点として、速度向上の他にも、Lucene 9 から使用可能な 近似近傍探索も魅力的な点だった。

`NOTE`: yelp の nrtsaerch [^yelp]もそうだが、既存の Elasticsaerch や Solr がボトルネックになると自作検索エンジンを作り始めるのかっこよすぎる。

#### Improving query and document understanding

- 手作業でのラベリングを行う。手作業はスケーラブルではないが、高速に仮説を立証して、数百規模のデータセットを作成する。
- プロセスが標準化された後は、オペレーションチームや外部パートナーと連携して、数千規模のラベリングを行う。
- 収集した数千のデータを基に機械学習モデルを構築して、そのモデルを使ってラベリングをスケールさせる。
- 上記のデータに対して、定期的な品質確認を行う。ラベリングの品質確認は、バイアスの排除やモデルの精度向上に不可欠

##### Using human annotations to create labels

アノテーションの分散を最小化するために、アノテーションプロセスを文書化したガイドライン作成はとても重要である。
Google 検索が公開している検索品質の[素晴らしいガイドライン](https://static.googleusercontent.com/media/guidelines.raterhub.com/en//searchqualityevaluatorguidelines.pdf)があるが、同様に DoorDash もアノテーションガイドラインを作成した。

だが、もし DoorDash のすべての従業員がフルタイムでマニュアルに則ってアノテーションしたとしても数十万規模のアノテーションタスクを終わらせることはできない。
人間によるアノテーションをスケールさせるためには外部の専門のベンダーに頼らざるを得ない。
Amazon Mechanical Turk や、Google Cloud AI Labeling Service, Scale.AI, Appen など多くのアノテーションビジネスが存在している。

基本的にアノテーションタスクは、一人のアノテーターの判断を信頼することはできない。
バイアス除去のために、よく使われる手法としては多数決を取り入れた手法がある。
適切な精度のレベルまで引き上げるに 3-4 人、もしくはそれ以上の人数で同一のアノテーションタスクを行う必要がある。
また、良質なガイドラインはアノテーションの品質や速度の向上にも寄与する。

ベンダーに依頼後、アノテーションデータセットが作成された後にも、我々はデータセットに対する監査を行う必要がある。
(機械学習のシステムであろうと)他のシステムと同様に、品質保証は重要です。

`NOTE`: 同意しか無い。機械学習だから仕方ないよねだと、その先には行けないので`出来得る限り` (多種多様な状況があるので、それに応じたベストな行動を指す)の取り組みで品質保証を行う必要がある。

アノテーションデータセットへ監査を行った際に、面白いテーマが見つかった。

- いくらかのベンダーは特定の地域のアノテーターで構成されており、文化の差異によって誤った判断が発生していた
- 特定のベンダーは他のベンダーと比べて、アノテーターが訓練されており、アノテーション結果がとても良質だった
- 一部の種類のラベルはアノテーションガイドラインに曖昧性が多すぎた。
- アノテーションタスクの複雑さを過小評価した場合、ベンダーはアノテーションタスクの立ち上げと処理に長時間必要とした。

##### Using natural language processing to enrich query context

クエリに対する品詞のアノテーションを行うことで、クエリの言語的な構造を理解ができる。
例えば、 「red pizza」というクエリに対して、パースを行い[JJ NN]というアノテーションを行う。
`JJ`は形容詞で、`NN` は名詞を指している。
結果として、このクエリは形容詞が名詞を修飾しているということがわかる。
検索の際に、「red pizza」という単語が完全一致で存在しなかった場合、緩和を行い「pizza」のみの単語で検索を行うことが可能になる。(一般的にクエリ拡張と呼ばれる技術)

`NOTE`: この POS のアノテーションでわからないのは、クエリ自体正しい英語ではなく誤植まみれの英語がくるから POS アノテーションが必要問事なのかなと思ったりした? 専門分野ではないので素人的発想だが、形態素解析が必要なく誤植ももしなければ POS アノテーションせずとも品詞はすべて把握できそう?
だが、後述の Spacy で

> NLP libraries involve far more than POS tagging

と書いてあるので、アノテーション自体は必要なタスクなんだと理解。

POS タギング自体は [Spacy](https://spacy.io/) を使っている。
POS タギングのサービングだが、検索時にオンライン(リアルタイム)でのサービングが必要なので速度向上のために以下のような選択肢がある。

- オフラインで計算したクエリの品詞のペアを Redis などのインメモリ DB に格納してルックアップテーブルを構築して推論を行わないようにした。(人気のあるクエリのみに焦点をあて、テイルクエリ(頻度の低いクエリ)はカーディナリティが爆発するので DB には格納しない)
- Spacy を使わずに JVM で動く NLP ライブラリを使ってサービングする
- Roblox のようにチューニングを極めることで、トランスフォーマーモデルでもオンライン毎日 10 億規模の推論を実現すること[^roblox]も可能

`NOTE`: 選択肢は色々とありますといいつつも何を採用したかは次の記事に期待してねと書いていた。個人的には DB でルックアップテーブル使うのが初手だと一番良さそう

#### Learning-to-rank

DoorDash の ランキングアルゴリズムの変遷

1. Heuristic Ranker (BM25+ 店舗の人気度)
1. LTR:Pointwise
1. LTR + Personalization

初期の LTR モデルをデプロイ時に、オンラインでの検索評価のフレームワークを社内で議論して方向性を固めていった。
ビジネス指標と情報検索指標の２つのカテゴリの指標を持つ

- ビジネス指標: 検索のコンバージョン率、CTR、first click rank position などは North star 指標
- 情報検索指標: mean-reciprical rank, nDCG

定常的にゴールデンデータを作成する仕組みを作成。アノテーターを配置して、関連性のレーティングを行い、最新のゴールデンデータを常に作成できるようにしている。

Heuristic Ranker から pointwise LTR に切り替えたことで、検索関係のすべての指標が大きく向上。

一方で pointwise LTR の導入には 6 ヶ月以上が費やされた。

その後、LTR + Personalization によって、更に指標が向上。
DoorDash では、２つの明確な検索の使用方法が存在し、

- ブランド検索: レストランの名前を検索する、強い意図を持った検索
- 非ブランド検索: 料理や食品を目的にした検索、検索意図は個人的な思考に強く依存

LTR + Personalization による改善では、非ブランド検索が大きく改善された。(そして検索ボリュームでもかなりの部分を占める)

---

[Mercari ML&Search Talk \#3 ~MLOps & Platform~ \- YouTube](https://www.youtube.com/watch?v=3fo5YyRqRII)

- [Build ML platform using Open-Source (English)](https://www.youtube.com/watch?v=3fo5YyRqRII&t=555s)
  - メルカリ JP 内の機械学習基盤について語ってくれています。積極的に外部発信されていなかったと思うので気になる方は御覧ください。
- [How search system evolves in mercari (Japanese)](https://youtu.be/3fo5YyRqRII?t=2308)
  - [メルカリの検索基盤の変遷について \| メルカリエンジニアリング](https://engineering.mercari.com/blog/entry/20220207-776318b784/)を基にした講演になっており、この記事が面白いと思った人はぜひ見ましょう!
    著者の @shinpei さんはストーリーを語るのが上手いので、自分は記事を読んでいる最中に 2 回笑わせてもらいました。
- [Mercari Lens beta - product development with WebAssembly × AI (Japanese)](https://youtu.be/3fo5YyRqRII)
  - @tkat0 さんによる、WebAssembly を使った機械学習プロダクト開発の裏側の紹介。毎回感嘆するのは、クライアント周りの開発を自分たちでやっているためお客さまの体験に直面する開発になる。インタビューを重ねつつ改善していくのはすごく難しいと思うけど、その姿勢が良いなぁと思っている。バックエンドだけになりがちな機械学習適用ですが、クライアントの要素も考慮しないといけなくなるので、Edge の醍醐味ですね。

[新刊『検索システム ― 実務者のための開発改善ガイドブック』のお知らせ – 技術書出版と販売のラムダノート](https://www.lambdanote.com/blogs/news/ir-system)

> 本書は、探索的検索まで考慮しながら「検索システム」と日々格闘している実務家 6 名による実務家のためのガイドブックです。検索エンジンを支えるデータ構造とアルゴリズム、使い勝手のよい UI、検索システムを定量的に評価しつつ改善する手法、個々のユーザーのニーズに寄り添った検索結果を返すための工夫などなど、「よい検索システムをつくる」ために何をどのように始めたらいいのかを伝える羅針盤となっています。

[mocobeta/building\-search\-system\-book: 「仕事ではじめる検索システム」という本があったなら，という想像の産物です \-> 「検索システム ― 実務者のための開発改善ガイドブック」になりました](https://github.com/mocobeta/building-search-system-book) 1 年半前の構想から、ついに書籍になったという良いお話。
この話題が Twitter で話題になった際に、リポジトリの存在は知ったのですが、[commit history](https://github.com/mocobeta/building-search-system-book/commits/master) を見てみると、ちょこちょこ @mocobeta さんが更新されていたみたいでこの変遷をみるのが書籍完成までの追体験できて面白い。(web 日記みたいで良いですよね 🙂)

発売日に即購入させていただきましたが、まだじっくりと読めていないので精読後に感想記事を書かせていただこうかなと思っています。

[10X の検索を 10x したい \- 10X Product Blog](https://product.10x.co.jp/entry/serch-10x)

ネットスーパーのプラットフォームである Stailer の検索システムを改善したお話。
現状の検索システムを理解、ログからパフォーマンスボトルネックを発見して解消するというお手本のようなストーリーで面白かったです。
実際に速度も 10 倍、CPU 使用率も 68%削減というデカイ成果がでていますね。
また、既存のシステム設計も見直すことで費用も 8 割削減と素晴らしい。

あと冒頭の

> ところで、検索インフラの改善ができるということは、先人たちが検索機能を作り、PMF してサービスが利用されるようになったおかげです。感謝して改善しましょう。

の言葉がリスペクトに満ちていて個人的にとても好きなのと、

最後の

> 検索速度の改善や、インフラ負荷対策は楽しく、改善点は無くならないので永遠にできます。しかし、わたしたちの目的は、よい検索機能をお客さまに提供することであることを忘れてはなりません。

も検索を通じた先の体験改善を念頭においていて素晴らしくないですか?

著者の @metalunk さんは、一緒に取り組んでくれるエンジニアを募集中なので、カジュアル面談大歓迎[^casualtalk]とのことです。

## 感想など

Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter?f=live) のハッシュタグでつぶやいていただくか、
[Google フォーム](https://forms.gle/xFgMwRJbeqJxNtfe9) での感想投稿をお待ちしております。

投稿の励みにさせていただきます。

## Search Engineering Newsletter の購読方法

配信記事が蓄積される RSS[^newsletterrss] を作成しています。

また、今までの配信記事一覧もこちら[^newsletters]から閲覧できます。

[^casualtalk]: @metalunk さんに Twitter で声をかけるといいらしいです https://twitter.com/metalunk
[^opensaerch-knn]: [Approximate search \- OpenSearch documentation](https://opensearch.org/docs/latest/search-plugins/knn/approximate-knn/)
[^doordash-saerch]: [Things Not Strings: Understanding Search Intent with Better Recall](https://doordash.engineering/2020/12/15/understanding-search-intent-with-better-recall/)
[^doordash-ml]: [Machine Learning \- DoorDash Engineering Blog](https://doordash.engineering/category/data-science-and-machine-learning/)
[^yelp]: [Yelp/nrtsearch: A high performance gRPC server on top of Apache Lucene](https://github.com/Yelp/nrtsearch)
[^roblox]: https://blog.roblox.com/2020/05/scaled-bert-serve-1-billion-daily-requests-cpus/ 。知らなかったので後から読むリストに突っ込んだ。 ゲーム会社の Roblox がそんなに機械学習に力を入れているとは知らなかった...。面白い
[^newsletterrss]: newsletter RSS: https://shunyaueta.com/tags/newsletter/index.xml
[^newsletters]: newsltter 一覧ページ: https://shunyaueta.com/tags/newsletter/
