---
title: "Search Engineering Newsletter vol.05"
date: 2022-05-02T23:50:35+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-01-16/images/1.png"
tags:
  - newsletter
  - search
---

## Search

[Introducing Natural Language Search for Podcast Episodes](https://engineering.atspotify.com/2022/03/introducing-natural-language-search-for-podcast-episodes)

Spotify が Podcast 検索において text matching の従来の検索エンジンではなく、ニューラル検索を導入した解説記事。
ニューラル検索の実運用例として面白かったので、以下に抄訳として内容をまとめた。

---

### Beyond term-based Search

「electric cars climate impact」と自然言語のクエリを Elasticsearch に投げても何も検索結果が表示されなかった...だが検索されなかったのは、Spotify 上の Podcast に関連する内容がなかったからなのだろうか?

`NOTE:`個人的に本当に結果が出なかったのかは気になるところではある。ワードの完全一致ならともかく、BoW や BM25 で検索すれば結果は出るのでは...?

### Natural Language Search

自然言語検索(Natural Language Search、またの名を意味検索(Semantic Search) と呼ばれる技術について調査を始めた。すごくざっくり言えば、従来ではクエリとドキュメントの単語の一致によって検索を行っていたが、意味検索ではクエリとドキュメントの意味的な相関によって検索を行う。

実際の検索結果の例を見ても、クエリのすべての単語が Podcast のタイトルには含まれていない(Elasticsearch が検索結果を出さない理由でもある)が検索結果として妥当なことがわかる。

### Technical solution

これらの結果を実現するために深層学習の技術である、自己教師学習と Transformer を利用、そしてそれらの結果を高速に提供するために近似近傍探索(Approximate Nearest Neighbor (ANN))を利用する。

共通の埋め込み空間上で、クエリのベクトルに近い Podcast を検索結果として計算する。また、Podcast の題目、説明文、そして親ポッドキャストのテキスト情報などを連結して特徴量とする。

### Picking the right pre-trained Transformer model for our task

BERT のような Transformer モデルは、自然言語処理タスクでは現在最高峰の性能を誇っている。
BERT は 2 つの観点から高性能になっている

- 自己教師学習による文章からの巨大なコーパスを作成。文章からランダムにマスクした単語を予想するタスクを主なタスクとしてモデルを構築
- Bidirectional self-attention により、高品質な単語埋め込み空間を獲得可能

だが、基礎の BERT モデルは今回の事例に以下の理由で適していないことが分かった

- [SBERT, “Sentence-BERT: Sentence Embeddings Using Siamese BERT-Networks”](https://arxiv.org/abs/1908.10084)の論文で示されたが、文脈に沿った埋め込み空間を得られるが BERT では文の表現に対しては良い結果が出ない。
- 英語の文章のみで事前学習されているが、我々は多言語の検索をサポートしたい。

それらの課題を解決するための手法として、[Universal Sentence Representation Learning with Conditional Masked Language Model](https://arxiv.org/abs/2012.14388) で提案された CMLM モデルが実験を通して良好な結果を得ることができた。
CMLM モデルは以下の利点がある。

- CMLM モデルは高品質な文章の埋め込み空間を生成可能
- 巨大な 100 以上の言語コーパスから学習された事前学習モデルが [TFHub](https://tfhub.dev/google/universal-sentence-encoder-cmlm/multilingual-base-br/1) で利用可能

### Preparing the data

強力な事前学習モデルを使えるようになったので、次のステップとして Spotify の Podcast データに合わせたモデルの fine-tune が必要である。

- Elasticsearch の検索から得られた過去の検索ログから、成功した検索セッションを元に (クエリ, エピソード)のペアを作成する。
- また過去の検索ログから、セッションを通じて最初の検索が失敗後にクエリを調整して検索が成功したデータを用いて、(調整が成功したクエリ, エピソード)のペアを作成する。これによって学習データにより(クエリ, エピソード)のペアで、単語の一致がクエリとエピソードのメタデータで発生していないより意味的な近さを捉えることができる。
- 学習データの多様性と規模を工場させるために人工的なクエリを人気のエピソードの題目と説明文から作成する。この作成方法は[Embedding-based Zero-shot Retrieval through Query Generation](https://arxiv.org/abs/2009.10270)からアイデアを得た。
- 最後に、人気のあるエピソードに対して、小規模だが激選された「意味的なクエリ」を手動で作成した。

すべてのデータは学習時と評価時の両方に利用されている。(手動で作成した激選されたくいクエリのみ、評価データセットとして飲み使われた。)
また学習データと評価データの分割時には、評価データに含まれるエピソードが学習データに含まれないように確認した。(leakage 予防)

### Training

学習済みの Universal Sentence Encoder CMLM モデルを使って、クエリとエピソードのエンコーダを作成する。また効果的にモデルを学習するためにポジティブな(クエリ, エピソード)のペアだけでなく、ネガティブなペアも必要になった。

「Dense Passage Retrieval for Open-Domain Question Answering (DPR)」や「Que2Search: Fast and Accurate Query and Document Understanding for Search at Facebook」の論文を参考にバッチ内の他のペアからエピソードを抜き出してそれらをネガティブなペアとしてデータを生成する。

### Offline evaluation

In-batch metrics, Full-retrieval setting metrics の２つの指標で評価。

### Integration with production

#### Offline indexing of episode vectors

[Vespa](https://vespa.ai/)を利用して検索インデックスを作成。また、episode の人気情報などに基づいた re-rank なども可能になる。

#### Online query encoding and retrieval

Google Cloud Vertex AI で、Query encoder がデプロイされておりクエリがベクトルに変換される。採用理由としては GPU インスタンスがサポートされおり過去の実験から GPU よりも T4 GPU のほうが 6 倍のコスト削減(この際のコストは費用?)を確認できたらしい。
クエリのベクトル生成後は Vespa により Top30 の意味的に相関が高いエピソードベクトルを検索する。またもちろんクエリのベクトル生成時にキャッシャは作成して同じクエリの encode は避けている。

#### There is no silver bullet in retrieval

自然言語検索は面白い性質を持つが、単語の一致をベースにした伝統的な検索手法に頻繁に検索精度としては劣る場合が発生する。また、計算コストとしても、とても高くなりがちである。
これらの事実から Vespa による自然言語検索で既存の検索システムを置き換えるよりむしろ、追加のデータソースとして扱うようにした。

Spotify の検索では最終段階の re-ranking モデルを運用しており、Elasticsearch, Vespa, 他のデータソースを元に re-ranking を行い最終的なランキング結果を顧客に提示している。

### Conclusion and future works

結果として、vespa による自然言語検索をデータソースとして導入することで A/B テストでは有意に Podcast のエンゲージメント指標が向上した。そして初期の自然言語検索システムはほぼすべての顧客に提供されておりモデルの改善も進んでいる。

---

[Amazon KDD Cup 2022](https://www.aicrowd.com/challenges/esci-challenge-for-improving-product-search)

Amazon が製品検索改善の競技コンペを KDD2022 で開催。データセットは英語・日本語・スペイン語で公開。

タスクは 3 種類

- Query-Product Ranking: クエリと製品のマッチングのランキングを行う。評価指標は`nDCG`
- Multiclass Product Classification: クエリと製品のペアが Exact(E)・Substitute(S)・Complement(C)・Irrelevant(I) のなかでどの関係性になっているかを予測する。
  - Exact(一致): その商品はクエリと関連(relevant)しており、そのクエリは商品の使用を満たすクエリになっている。例)「プラスチックウォーターボトル 24L」 にクエリに記された仕様を満たすウォーターボトルの製品が出ている。
  - Substitute(代替): その商品とクエリはやや関連している。完全に関連はしていないが、マッチした商品は機能的に同じものである。例)「セーター」というクエリに「フリース」の製品
  - Complement(補完): クエリの対して商品は関連していないが、関連した商品と組み合わせて使用できる商品。例)「ランニングシューズ」のクエリに対して、「トラックパンツ」の製品
  - Irrelevant(非関連): クエリに対して関連性がない。例) 「パンツ」のクエリに対して、「ソックス」の製品
- Product Substitute Identification: クエリと製品が Substitute の関係かどうかを予測する 2 値の予測問題。2 番目のタスクの Multiclass Product Classification と入力形式は同一で、Substitute かどうかを当てるのみになっている。

[How Amazon Search achieves low\-latency, high\-throughput T5 inference with NVIDIA Triton on AWS \| AWS Machine Learning Blog](https://aws.amazon.com/jp/blogs/machine-learning/how-amazon-search-achieves-low-latency-high-throughput-t5-inference-with-nvidia-triton-on-aws/)

Nvidia の Trion server(旧名は TensorRT Inference Server という名前だった)の実証実験をしてみたよという記事。プロダクション環境下での AB テストはしていないので、単なる性能実験でしかないが、将来的に機械学習の推論を Trion server でサービングしたいとのこと。

[Enable Amazon Kendra search for a scanned or image\-based text document \| AWS Machine Learning Blog](https://aws.amazon.com/jp/blogs/machine-learning/enable-amazon-kendra-search-for-a-scanned-or-image-based-text-document/)

今回始めて知ったんですが、Amazon Kendra という、自然言語的なクエリでも検索可能な AWS の検索サービスがあるらしいです。
この記事は、手元のスキャンした書類や画像、PDF や画像などを AWS Lambda を介して、Amazon Textract という API で文書化。その後 S3 起点で Amazon Kandera にその情報を同期させて検索可能にできるよという紹介記事。
社内の紙の書類なども検索可能になるという発想は面白い。

[Elasticsearch 運用ノウハウ - メルカリ](https://engineering.mercari.com/blog/entry/20220311-97aec2a2f8/)

メルカリでの Elasticsearch の運用方法をまとめた記事。最近メルカリの検索の内側を紹介する記事が増えているので良いことですね。インデックスをどう管理しているかや、Elasticsearch の各種設定をどう決定しているかなどを説明くれています。

[Building a Deep Learning Based Retrieval System for Personalized Recommendations](https://tech.ebayinc.com/engineering/building-a-deep-learning-based-retrieval-system-for-personalized-recommendations)

1.5 億の顧客と 15 億を超えるアクティブな出品商品がある eBay で、深層学習ベースの推薦システムをどう作り上げたかの解説。

1. オフラインでのバッチ
1. オフラインとニアリアルタイム(NRT)のハイブリッド
1. ニアリアルタイム

のレベルでどう段階的に作り上げていったかの説明をしており、愚直に地道に作り上げた話から学びが多く良記事。

モデルの詳細は KDD2021 の推薦システムに関するワークショップ [IRS workshop 2021](https://irsworkshop.github.io/2021/) で発表されている[^ebay]。
2-tower でモデルは構成されている。1 つめのタワーで商品、もう一つのタワーでユーザーの埋め込み空間を獲得。A 与えられた `user_id` の k 個の ANN による近似近傍探索の商品を返す。

段階を経て、バッチ処理からストリーミング処理に変遷するのはお疲れさまでした感が凄い。
非常に気になる話としては、バッチ処理からニアリアルタイムでのストリーミング処理に置き換えて、それに見合う成果がどれほどでているのかは表に出して欲しい~。

論文[^ebay]では、モデルの投入によってコールドスタートや在庫なしの課題を有意に改善できたとのこと。読んだ感じだとこの論文執筆時では 1 段階目のバッチ処理のアーキテクチャっぽい。

[SearchSage: Learning Search Query Representations at Pinterest](https://medium.com/pinterest-engineering/searchsage-learning-search-query-representations-at-pinterest-654f2bb887fc)

画像検索に強みを持つ Pinretest が、検索システムにテキスト検索と埋め込みでの検索を混ぜることで Top35 の検索結果で 11% CTR を向上させたとのころ。
モデル構成は two-tower らしく、どこもかしこも two-tower を使っている気がする。
モデルの Serving には、TensorFlowServing 上で構築された内製の C++の推論サーバーで運用しているらしくすごくテッキーというか Pinterest らしい構成。
学習は Python、推論は C++で計算コスト効率を目指すことを念頭に置いて、 前処理のために PyTorch の C++オペレータを使用している。(凄い、小並感)
技術的な面の追求だけでなく、ビジネス的な数値もしっかりとリフトさせているのが Pinterest の凄いところですね。

[Near real-time features for near real-time personalization](https://engineering.linkedin.com/blog/2022/near-real-time-features-for-near-real-time-personalization)

Linkedin でのニアリアルタイムでの推薦システム構築の記事。
Table 1.の表のデータが面白く、仕事の推薦モデルに対して応募状況のデータの遅延影響が、どれくらいモデルの精度に影響するかのシミュレーション結果を公開してくれている。
1 分の遅延をベースラインにして、1 時間で 3.51%の ROC-AUC の低下、24 時間で 4.45%まで低下するらしい。
こういう遅延が定量的にどれくらい損益を与えているかを測定しているのは科学をちゃんとしていて、非常に尊敬。
リアルタイムにデータを提供できることで、各種推薦システムも軒並み数値をリフトしており、まさに速さこそ正義[^speedtest]状態になっている。

また記事の締めくくりに

> Short development cycle helps. Successful completion of this initiative required several iterations. Our short development cycle allowed fast iterations. This was in a big part due to prior investments in scaling machine learning productivity, our experimentation platform, and continuous deployment.

基盤への投資によって開発サイクルが短縮され、高速な反復が実現できたんだよ
とものすごく良い話を聞けた。
Linkedin のこの事例は、モデル構築然り、データエンジニアリング、その後の測定などなど、複雑な要素が絡みあうプロジェクトなので基盤への投資による生産性の底上げってのはものすごく効きそうですね。

[Elasticsearch LTR プラグインと特徴量キャッシュ機能の基本](https://techblog.zozo.com/entry/basics-of-elasticsearch-ltr-plugin-and-feature-score-cache)

Elasticsearch で Learning to Rank(LTR)を行うことができるプラグインの詳細。
特徴量キャッシュの PR を作成して本体にマージされているのカッコよすぎますね。
Yahoo さんのこの底力は毎回凄い。人材の層が厚いですね。

[メルカリ Shops の検索改善とそれを支える AB テストの仕組み](https://engineering.mercari.com/blog/entry/20220311-9a1103aed1/)

メルカリ Shops での検索を、メルカリ上での検索とどうインテグレーションしているかの紹介記事。

[DMM の検索改善専門チームが教える！ 検索改善に向けた考え方から効果検証まで \- DMM inside](https://inside.dmm.com/entry/2022/4/7/engineer-search)

検索改善の考え方や向き合い方についての記事。
検索改善で、システム面ではなく仮説検証から AB テストまでのメタ的な枠組みを文章化して説明してくれている記事は良い意味で珍しい気がします。
DMM さんは最近おもしろい記事をたくさん書いてくれていて読んでいて楽しいですね。

[大規模サービスで効率よくレコメンドを提供するために Tensorflow Recommenders を活用する \- DMM inside](https://inside.dmm.com/entry/2022/3/22/engineer-recommend)

DMM さんによる、[tensorflow/recommenders](https://github.com/tensorflow/recommenders) を活用した推薦事例紹介記事。
既にサービスに導入しているらしく、プロダクションで運用されているのは率直に素晴らしいなと思いました。

## Data Science & Machine Learning

[DeepETA: How Uber Predicts Arrival Times Using Deep Learning](https://eng.uber.com/deepeta-how-uber-predicts-arrival-times/)

Uber で到着予想時刻(estimated time of arrival: ETA)をどうやって予測しているかの紹介記事。Uber の事業領域としてこの ETA 予測はすべての顧客体験に根本的な影響を及ぼすほど重要なモデルである。

Uber は数年前から GBDT のモデルを ETA 予測に採用しており、モデルの更新のたびに学習データは着実に巨大化しており、それらをさばくために XGBoost に[分散学習の PR](https://github.com/dmlc/xgboost/issues/4250)を作成したりと XGBoost へのかなりのコントリビューションを行っている。

だが、リアルタイムの交通指標や地図情報などを特徴量として使った深層学習ベースの DeepETA とよばれるモデルの開発を開始した。
考慮すべき点として、Uber のリクエスト規模をさばくことが可能な高速なモデルが求められる。
モデルの軽量化も工夫が凝らされており、これだけ頑張らないとプロダクションに載せられないんだろうなとハラハラした気持ちで読んでいた。

DeepETA のモデルは内製基盤の Michelangelo で運用されており、実際に XGBoost と比較しても良好な結果が得られたのこと。

XGBoost から DeepETA へ移行した経緯を読み取ってみると、深層学習を使うに値する規模のデータが収集してそれらを活かせる環境も整ったから移行したのかなと個人的には思った。
結論でも書かれているが、モデル自体はこれからもいろんなアプローチで改善していくぜと書いてあるので、将来的な改善幅に投資したのでしょう。
現状維持よりもさらなる改善を見据えた投資を行っているのが素晴らしい。

Product Manager の方の Linkedin を見ていると

> In 2021, I helped my team land +$100M of incremental revenue through shipping Deep Learning ETA models, XX% improvements to delivery time estimate accuracy, etc.

と書かれており、100 億円以上の利益向上と書かれており、ギエピーとなりました。
やはり規模の経済...。レバレッジが聞くところに機械学習をやるべきですね。

[How LinkedIn Personalized Performance for Millions of Members using Tensorflow.js — The TensorFlow Blog](https://blog.tensorflow.org/2022/03/how-linkedin-personalized-performance.html)

Linkedin は[Linkedin Lite](https://engineering.linkedin.com/blog/2018/03/linkedin-lite--a-lightweight-mobile-web-experience)というプロジェクトの一環で、クライアントの状況を Performance Quality Model (PQM)[^pqm]と呼ばれる機械学習モデルで予測を行い

- ハイエンドかつネットワーク状況が良好なクライアント: 画像をそのまま提供
- ローエンドかつネットワーク状況が良好でないクライアント: 低解像度の画像を提供

を識別することで状況に応じた最適な web ページをクライアントに返す実験を行った。
その結果、フィードでの数値が大幅に向上させることができた。
動的な配信するアセットを変更するというアイデア、痺れますね。
これもまた速さこそ正義[^speedtest]案件。

そして、そのモデルをどのようにデプロイしたかがこの記事で書かれているのだが、TensorFlow Serving などを使わずに TensorFlow.js でサービング環境を運用しているらしくとてもユニークな記事になっている。

TensorFlow.js の選定理由としては、まず当時の Linkedin では、TensorFlow の運用状況が成熟しているとは言い難く、 TensorFlow Serving を運用する選択肢は無かった。
Linkedin 内では JVM スタックがメインだったが、Node.js をフロントエンドとして運用していたので、Node.js で動く TensorFlow.js が採用された。
だが、実際には Python も TensorFlow の運用環境として採用可能だったが、Node.js を選んだ理由として語られているのが、

- 既に Node.js の環境を構築済だった
- Python よりも Node.js での TensorFlow の 50 percentile が 8%ほど高速だった。

という２つの理由かららしい。この結果は面白く、TensorFlow のレスポンス速度は Node.js のほうが Python よりも早かったのかと驚いた。
もちろんモデルのアーキテクチャや他の条件などにも夜がそれらを踏まえても面白い結果だ。

[日本語における評価用データセットの構築と利用性の向上（JED2022） \| NLP2022 Workshop on Japanese Evaluation Dataset](https://jedworkshop.github.io/jed2022/)

> 日本語における評価用データセットの構築手法そのものに加えて，データセットの公開方式・利用性の高い著作権設定・タスクの複合化といった応用を容易にするための研究を集めて議論することで，日本語データセット公開の流れを加速し，日本語 NLP 業界全体のさらなる発展および生産性向上につなげていきたい．

素晴らしいワークショップが NLP2022 で開催されていました。
知らない日本語のデータセットも知れたり、法的な取り組みも知れたりと学びの多い資料が多い。
日本語データセットの拡充は、まさに日本語自然言語の発展を促進させるので、自分も貢献したいなぁと思っている。 2023 年にも JED2023 が開催されるらしいので楽しみにしています。

## 感想

Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter?f=live) をのハッシュタグでつぶやいていただくか、
[Google フォーム](https://forms.gle/xFgMwRJbeqJxNtfe9) での感想投稿をお待ちしております。

## Search Engineering Newsletter の購読方法

配信記事が蓄積される RSS[^newsletterrss] を作成しています。

また、今までの配信記事一覧もこちら[^newsletters]から閲覧できます。

[^ebay]:
    [Personalized Embedding-based e-Commerce Recommendations
    at eBay](https://irsworkshop.github.io/2021/publications/IRS2021_paper_14.pdf), [YouTube](https://youtu.be/THwyB1gQrxs)

[^speedtest]: 速さ事正義を示す実験事例 [システムの応答速度は本質的な価値提供であることを示す A/B テストの実例](/posts/2021-08-13/)
[^pqm]: OSS で公開されていた https://github.com/linkedin/performance-quality-models
[^newsletterrss]: newsletter RSS: https://shunyaueta.com/tags/newsletter/index.xml
[^newsletters]: https://shunyaueta.com/tags/newsletter/
