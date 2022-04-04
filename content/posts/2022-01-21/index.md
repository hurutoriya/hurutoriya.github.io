---
title: "Search Engineering Newsletter vol.01"
date: 2022-01-21T22:11:45+09:00
lang: ja
author: Shunya Ueta
tags:
  - newsletter
  - search
---

以前に告知したとおり、検索領域と機械学習領域で面白かった記事をここで紹介していきます。
ガッツリ量を書くために溜め込むよりも一定量溜まったら配信したほうが、書く側としても気が楽なので暫くその方針で行ってみます。

## Articles

### Search

[elastic/elasticsearch - Integrate ANN search #78473](https://github.com/elastic/elasticsearch/issues/78473)

elasticsearch 8.x では Lucene 9.0 から提供される ANN(近似近傍探索)機能が提供される予定。以前から提供されていた elasticsearch の exact k NN はプロダクション環境下では使えない性能だったが、Lucene の ANN 検索は結果がどうなるか非常に気になる。ES に組み込まれることで、ANN の結果に対して、フィルタリング、ハイブリッド検索など ES の検索エンジンと組み合わせた利用が期待できるので追っておきたい。

[apache/solr - SOLR-15880 #476](https://github.com/apache/solr/pull/476)

Solr も同じく ANN の提供を準備中。

個人的には、ANN のことを kNN と書くのは紛らわしいのでやめてほしいし、ANN のことを Neural Search と読んでいて、え?いいの??と思ったりした。

これが実装されれば、[Vespa](https://vespa.ai/)や、各 OSS やエンタープライズの近似近傍探索エンジンがどうなっていくのかは非常に面白い未来ですね。

[Reddit Search: A new API](https://www.reddit.com/r/RedditEng/comments/rli3ke/reddit_search_a_new_api/)

Reddit が検索 API を刷新したお話。
システム的にどう嬉しいかや、チーム編成が変わって、10 年間でインフラエンジニアが兼業で開発していた状態から、検索エンジニア、専任のクライアントエンジニアがフルタイムで改善していく体制に変わったなど、変化がしれて面白かった。

今までの[reddit の検索システム Blog 記事シリーズ](https://www.reddit.com/r/changelog/comments/qrr3v9/whats_up_with_reddit_search_episode_iv_a_new/)も面白そうだったので読もう。

[Search at Shopify—Range in Data and Engineering is the Future](https://shopify.engineering/search-at-shopify)

[Relevant Search](https://www.manning.com/books/relevant-search) 著者 Doug Turnbull さんの Shopify の技術ブログ。

ここからは抄訳

> 検索チームをどう機能するかについて。
> Shopify の検索チームメンバーは、エンジニアでもデータサイエンティストのどちらでもない。代わりにその両者のスキルを同時に活用しないといけない場面が多々ある。つまるところ、良い検索のための意思決定には、Data science, Engineering の両方のスキルを併せ持つことが必要である。

> 理由としては、どちらかだけのスキルだと非現実的な意思決定しかできず、良い意思決定ができないため。
> 例えば、Data Scientist のサイロでは、非現実的な Data ETL やモデルのインテグレーションやサービングは自分の仕事ではないと言いだし、エンジニアにすべてを任せてしまう。
> 逆にエンジニアのサイロでは、ランキング改善のために必要な引き出しが足りずアイデアが出ない。その知識がないとプロジェクトは失敗して、筋が悪い解決方法を行ってしまう。優れたエンジニアリングとは、制約を考慮した上で最善の意思決定を下すことなので、Data Science 領域の制約を考慮できないことには検索改善をすることは難しい。

> Shipify では、検索のためにエンジニアリング、Data Science の線引をすることなく、検索改善のためなら両者の領域を活用することに積極的だ。
> Data Scientist, エンジニアの２つのチームがあるのではなく、検索チームには一つのチームしかありません。互いにどちらかの領地を奪い合う敵対した関係性もない。

> Data Science と Enginnering の未来として両者を自由に行き来することこそが検索改善につながる

と、めちゃくちゃ良いこと書いていて感動しました。
自分が考えていることと完全に一緒で、あぁやっぱりその世界って良いよねと自己の方向性の決断に自身が上乗せされた感覚がある。

Doug さんの記事を読んだのは初めてなのですが、文章も読ませる文章で読んでて楽しい...!
積極的にいろんな記事を過去に書いてくれているので、それも徐々に読んでいきたい。

[SearchSage: Learning Search Query Representations at Pinterest](https://medium.com/pinterest-engineering/searchsage-learning-search-query-representations-at-pinterest-654f2bb887fc)

[ISIR-eCom 2022 at WSDM workshop](https://isir-ecom.github.io/)

sigir-ecom の WSDM 版のようなワークショップ。sigir-ecom よりかはシステム面に特化した貢献が認められているので、投稿論文が公開されるのが非常に楽しみ。継続的にぜひとも開催してほしい

[LINE MUSIC が挑んだパフォーマンス改善。膨大な楽曲数を扱うための Elasticsearch の設計](https://engineering.linecorp.com/ja/interview/line-music-elasticsearch/)

LINE music での elasticsearch の負荷試験や、検索機能追加によって、負荷が雑談した際にどう解決したかを紹介。8000 万曲規模の検索を扱えるのは楽しそう。

[Elasticsearch Learning to Rank プラグインの使い方とポイント](https://techblog.zozo.com/entry/elasticsearch-learning-to-rank-plugin)

ZOZO での elasticsearch plugin を利用した Learning to Rank の解説記事。詳細に Pros, Cons が説明されていて、勉強になった。

[DMM の検索に機械学習を導入して、A/B テストで圧勝した考え方](https://inside.dmm.com/entry/2021/12/30/search_machinelearning)

> 理由としては、初手で複雑なことをするより、シンプルなものから始め、どの特徴が効くのか知見を溜めていく方が良いと判断したためです。

この点、めちゃくちゃ素晴らしいですね。
デジタルコンテンツで在庫の概念がないのでバッチを選んでいる点などサービス特性に沿って、わざわざ難しいことをせずに単純なデザインを常に意識している点が非常に秀逸。バッチジョブのワークフローエンジンの[tekton](https://tekton.dev/)は初めて知った。

> 僅かな効果でも驚くほどの成果に繋がります。インパクトを与えられる施策を実施できることは日本最大級のプラットフォームを扱っている DMM ならではだと思っています。

ここもまた、課題解決でいちばん大事なインパクトが大きな問題を解くべしを徹底していて、凄い。

とこの記事を見て、よし自分も検索改善頑張ろうと元気をもらえた記事でした。

[EC 検索広告枠の精度を、クエリ意図の機械学習で改善した話](https://techblog.yahoo.co.jp/entry/2022011130253953/)

気になった点としては、オフライン評価でクラウドソーシングを行った際に、モデル A・B の比較を行っているが、モデルなしの評価も行ってどれくらい結果がポジティブになるのかは見てみたかった。
会社内で運用されているクラウドソーシングがあるなんて、大規模サービスの特権ですね。
欲を言うなら、AB で定量的にどれくら改善されたのかが知りたかった...(公開しているところのほうが珍しいが)

[情報検索・検索技術 Advent Calendar 2021](https://adventar.org/calendars/6430)

勢いで作成した「情報検索・検索技術 Advent Calendar 2021」では、13 件の記事が投稿していただきました。自分も 2 件の記事を投稿したので、興味のある方は御覧ください。

Amazon の検索に興味があったので、システムサイド・ランキングロジックの解説記事を抄訳しました。

- [Amazon が e コマース検索を Lucene により、どうスケールさせているか at Berlin Buzzwords 2019](https://shunyaueta.com/posts/2021-11-26/)
- [[抄訳] Daria Sorokina さんによる、 Amazon 検索での製品のランキング付けの楽しさ at MLconf SF 2016](https://shunyaueta.com/posts/2021-12-26/)

## Machine Learning & Engineering

[On-device one-shot learning for image classifiers with Classification-by-Retrieval](https://blog.tensorflow.org/2022/01/on-device-one-shot-learning-for-image.html)

デバイス上での one-shot 学習の活用記事。デモアプリの出来が非常に高く、iPhone で事前に画像のカテゴリごとに分けたアルバム(各カテゴリは多くても 4 枚程度!?)を作成しておいて、それを読み込めばアプリ上で画像認識モデルが作成できて、動いていて驚き。

この動画を見たあとだと、誰もが認識モデルをかんたんに作成して活用する未来が見えてしまった...

[Redesigning Etsy’s Machine Learning Platform](https://codeascraft.com/2021/12/21/redesigning-etsys-machine-learning-platform/)

Etsy が内部の機械学習基盤を刷新した話。2017 年に小規模なデータサイエンスチームがロジスティック回帰のモデルを活用していた創世記の時代から、時間がたちモデルの複雑性はまし初期の基盤では、メンテンスがきつくなってきたので V2 の基盤を作成。基本方針としては内製開発はやめて OSS を積極採用の方針に。

V2 では、

- ETL: Dataflow
- Prototyping: Jupyter Notebooks
- Training: Vertex AI

と GCP サービスをフル活用した構成

面白かった点としては、Serviing では内製のサービングシステムがモデルの評価面ではやはり圧倒的に便利なので OSS 採用原則を撤回してそこだけは内製システムを採用という柔軟な意思決定が興味深かった。

V2 への刷新によって、着想からプロダクションリリースまでの時間が 5 割ほど削減されているらしく、これは大きな成果。

[Google Research: Themes from 2021 and Beyond](https://ai.googleblog.com/2022/01/google-research-themes-from-2021-and.html)

Jeff Dean が公開した Google Research から 2021 年からのテーマとこれから何を行うかの解説。

個人的に気になったのは、汎用機械学習モデルの適用結果。[MUM](https://blog.google/products/search/introducing-mum/)でも質疑応答モデルを検索に適用するなど非常に野心的な取り組みがあるが、システム的な運用や精度の保守・メンテンスなど裏側ではどう回しているのか非常に気になる。

[A decade in deep learning, and what's next](https://blog.google/technology/ai/decade-deep-learning-and-whats-next/)

20 年前に Google は機械学習利用を開始、10 年前には深層学習の適用を始めた。VP, Responsible AI and Human-Centered Technology の Marian さんと皆さんご存知の Jeff Dean が深層学習での 10 年で何が起きたか、そしてこれから何が起きるかを解説。

研究から現実世界での稼働に移行、そして Google のサービスへの機械学習適用事例を紹介。年間に 1000 本近く論文を公開して、Google AI は 10 年間では 6500 以上の特許を取得しているらしい。

また、機械学習の活用をソーシャルハッピーに繋げられるように投資していくらしい。

[The 10 most read research papers of 2021](https://www.amazon.science/latest-news/the-10-most-read-research-papers-of-2021)

Amazon Science が 2021 年に出版した論文のベスト 10 を紹介。
「Seasonal relevance in e-commerce search」では、39%のクエリがシーズナリティによって relevance が依存しており、AB テストでは 2.2%購入率が向上したらしく、想像以上にインパクトが凄くてびっくり。

「Reducing Amazon’s packaging waste using multimodal deep learning」では、深層学習を使って、2015 年から比較すると 36%のパッケージを削減して 100 万トンのパッケージの余分な排出を抑えているとのこと。ソーシャルハッピーな問題の典型でもあるし、機械学習のスケールメリットが活かせる典型的な良問だな~と感心した。

S3 のシステム論文とかも面白そうだが、ざっと読んでも
理解が難しかった。

[The top Amazon Science blog posts of 2021](https://www.amazon.science/latest-news/the-top-amazon-science-blog-posts-of-2021)

Amazon Science が 2021 年に書いた Blog 記事の Top10 の紹介。Amazon のありとあらゆる分野に機械学習の実用化を図ろうとしている姿勢が伝わってくるので、Amazon Science の記事は非常に面白い。
Learning to Rank を使って、荷物を度の玄関に置くかべきかを予測するという記事が面白そうだった。

[Meta’s AI team working on harmful Facebook posts moved to AR / VR unit ](https://fuentitech.com/metas-ai-team-working-on-harmful-facebook-posts-moved-to-ar-vr-unit-info/400543/)

Meta (旧名 Facebook) の機械学習による違反検知チームはかなりの投資がされていて、KDD2020 の keynote speaker では Alon さんが[Preserving Integrity in Online Social Media](https://dl.acm.org/doi/10.1145/3394486.3409548)という題目で、監視業務を機械学習により健全な環境を保つために何を行っているかを講演していたが、それを Meta での健全化にリソースを降っていくという Meta
への入れ込み具合が非常にわかるニュース。

自分の最初の機械学習タスクも違反検知と健全化だったので、この分野には非常に興味がある。

ここの記事経由で知った論文で面白そうなものは Blog でさっと解説記事を書いて、ニュースレターで深堀りして紹介しようかなと思います。

---

感想は、

- Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter) をつけてつぶやいていただくか
- [Google フォーム](https://forms.gle/vbjf4He8RnoKGn8u6) での投稿

をお待ちしております。

newsletter のタグを付与した記事の RSS[^newsletterrss] を作成しています。
手持ちの RSS リーダーに登録していただければ newsletter の更新時に簡単に閲覧ができます。

[^newsletterrss]: newsletter RSS: https://shunyaueta.com//tags/newsletter/index.xml
