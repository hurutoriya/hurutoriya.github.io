---
title: "Search Engineering Newsletter vol.10"
date: 2022-09-08T17:22:09+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-01-16/images/1.png"
tags:
  - newsletter
  - search
---

節目となる 10 回目のニュースレター配信です。
今回のイチオシ記事は ABEJA さんの「GPT モデルへの道のり」とメルカリさんの「お手軽な検索 API 構築」記事です。

## Search

- [How we're improving search results when you use quotes - Google](https://blog.google/products/search/how-were-improving-search-results-when-you-use-quotes/)
- [Google、引用符による完全一致検索結果をフレーズを中心に表示するよう改善 \- PC Watch](https://pc.watch.impress.co.jp/docs/news/1431125.html)

ダブルクォートを使った完全一致検索を行う際に、web ページのヘッダーや URL などは検索対象外になることで、Google の Web 検索体験を改善した。

[厳格なテスト – Google 検索の仕組み](https://www.google.com/intl/ja/search/howsearchworks/how-search-works/rigorous-testing/)

Google 検索がどのようにテスト・評価を行っているか。
2021 年に、約 4000 件の変更、約 11000 件の AB テストを行っているらしく驚き。
簡単に逆算しても月間に 900 件 AB テスト???をやっていることになるのだが、どんなことをすればこんな数の AB テストを実行可能になるのだろうか...。
例えば、一つの AB テストで、セグメントと 5 分割したからこれを５回としますならわかるけど、それでも月間に 180 回の AB テストなので現実味がないですね。
Google 検索に関わるエンジニアの数が全体でどれくらいいるのか気になりますが、この成果はさすが世界最大規模の検索エンジンですね。

[お手軽な検索 API 構築 \| メルカリエンジニアリング](https://engineering.mercari.com/blog/entry/20210906-46976c788c/)

サーバーレスの検索システムってどう作るんだろうかと気になって軽く調べていた経緯で紹介します。
コンテナイメージ内に検索インデックスイメージを含めることで、サーバーレスに Apache Solr を運用した記事です。

> 利用条件に制限を少し加えて、データの更新をリアルタイムには行わない、サーバ 1 台で管理できない規模のデータを扱わない

確かにインデックスをリアルタイムに更新する理由が強くない場合などもあると思うので、実現できそうな状況は多々ありそうです。
サーバーレスに構築することで、運用コストを押さえつつ全文検索はやりたいという目的は達成できそう。Cookpad さんの[人気順検索の Solr はスケールのためにディスクを捨てた \- クックパッド開発者ブログ](https://techlife.cookpad.com/entry/2020/11/25/080000)とアプローチが似ていますね。
機械学習領域もそうですが、コンテナにデータをもたせて更新していくというアプローチは状態を持つアプリには利点がおおい運用なので、コンテナ様様です。
コンテナ内に含めずに S3 上のデータを全文検索したいケースを解説した記事が Cloud-native search engine をうたう[quickwit\-oss/quickwit:](https://github.com/quickwit-oss/quickwit) が執筆しています。
[Searching the web for < $1000 / month \| Quickwit](https://quickwit.io/blog/commoncrawl/)
知らなかったんですが、Elasticsearch も S3 上にインデックスをマウントする機能をリリースしてるんですね。
quickwit は 計算部分とストレージ部分を分離させることを目指しているらしく、どんな仕組みで行っているか、次のニュースレターでみてみます。
勉強不足なので知らなかったのですが、 Spark や Prest、Google BQ などモダンな分散処理基盤は ストレージと計算を分離しているらしい。この仕組と理由も気になるので勉強します。

[Optimizing Elasticsearch for Low Latency, Real\-Time Recommendations  \- Zillow Tech Hub](https://www.zillow.com/tech/optimizing-elasticsearch/)

不動産売買のマーケットプレイスを運営する Zillow が Elasticsearch を使って、どのようにして高速にリアルタイムな推薦を行っているかの解説。
Elasticsearch のリクエストのライフスパンの解説で、リクエストが、キュー・クエリ・フェッチの三段階でさばかれる。
Zillow の場合はフェッチ部分がボトルネックになっているので、その最適化のためにフェッチメソッドを `souce` から `doc value` に変えて最適化して約 2 割程度、レイテンシーが高速化されたのは勉強になった。また CPU の使用率も 3-5 割ほど削減されたとのこと。
また、高速化のために Elasticsearch のキャッシュの活用やバルクリクエスト、リフレッシュインターバルも紹介されており実践的で面白い。

[How Instagram suggests new content](https://engineering.fb.com/2020/12/10/web/how-instagram-suggests-new-content/)

Instagram がどのように新しいコンテンツを推薦しているかの解説記事。

[関口宏司の Lucene ブログ](http://lucene.jugem.jp/)

Lucene の Comitter でもあり PMC でもある関口さんのブログ。
最近は更新されていませんが、 Lucene についての解説記事が書かれており勉強になります。

[全社横断のレコメンド API を開発した話 \- pixiv inside](https://inside.pixiv.blog/2022/08/04/120000)

Pixiv 内部のサービスを横断して、提供可能なら推薦サービスを構築した話。
初手は Google BQ 上で推薦結果を計算して、サービス側にその結果をサービス内に同期する方法を取っていたらしく、これも良いアプローチですね。
データガバナンス的に、一つの推薦サービスでサービス A、サービス B と認可されていないデータの管理とかどうやるのかなと思っていたら、暗号化により認可を兼ねているらしく面白かった。

[多様なコンテンツをとどける、レコメンドベースの note のホームタイムラインをつくる｜ kiha ｜ note](https://note.com/kihaya/n/n4fd27a61cc02)

松竹梅のアプローチを考えた上で、Elasticsearch を使って note の推薦サービスを構築したお話。
#elasicsearch では [Significant terms aggregation \| Elasticsearch Guide \[8\.4\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-aggregations-bucket-significantterms-aggregation.html) という集計機能を使えば、特徴的なタームを集計できると知った。
最初はこの集計機能で、note の記事のキーワードを抽出を試みたが、結果的には note の記事のハッシュタグを利用して、キーワード抽出を行ったのは既存のデータを上手く活用して、コスパよく試せるアプローチで良いなと思いました。

同じ機能を プロダクトマネージャー視点から開発した紹介記事も公開されており面白かったです。
[機械学習エンジニアが PdM として推薦機能をマネージメントしたらこうなった｜ konumaru ｜ note](https://note.com/konumr/n/n46826805cbc6)
この記事で感心したのは、Sagemaker の出力結果を Google Spreadsheet に保存して、それを Figma と同期することで実際に推薦結果を出されたかのようなプロトタイプを作って検証している点です。

> Spreadsheet ではサムネが無いことによる体験の悪化に気づけなかった

ここの点とか すごく共感できるんですが、アプリレベルまで落としてからこそ気がつける体験があるので、実際のアプリに限りなく近い状態での体験の検証って大事ですね。

## Machine Learning & Data Science

[Evolution of ML Fact Store\. by Vivek Kaushal \| by Netflix Technology Blog \| Netflix TechBlog](https://netflixtechblog.com/evolution-of-ml-fact-store-5941d3231762)

Netflix での特徴量ストアの運用を通じて学んだことをまとめてくれている。5 年前から特徴量ストアが必要だと言っていたんだよから始まり、自前の OSS(EvCache, Iceberg)を駆使してどのように特徴量ストアを構築したかが書かれている。

[Do You Really Need a Feature Store? \| by Lak Lakshmanan \| Towards Data Science](https://towardsdatascience.com/do-you-really-need-a-feature-store-e59e3cc666d3)

本当に特徴量ストア って必要ですかというお話。
要約として、特徴量をサーバーサイドで生成しないといけない(つまりリアルタイムに特徴量をオンラインで生成する必要性がある)とき以外は、特徴量ストアはオーバキルだよねという良いお話。
適切な道具は適切なタイミングで使わないと真価が発揮されない。
上で紹介した Netflix のような事例は確かに有効かもしれないが、オーバキルになっている場合もあるんじゃなかろうか

> **_tldr:_** *Use a feature store if you need to inject features server-side, especially if the method of computing these features will keep improving. Otherwise, it is overkill.*

[AI Project Management Flow and Build Trap Review 不確実性の高い機械学習プロジェクトを自己組織化されたチームで健全かつ最大化されたゴールに向かうために \- Speaker Deck](https://speakerdeck.com/yurfuwa/ai-project-management-flow-and-build-trap-review)

2020 年 2 月に公開されたプロジェクトマネジメントアンチパターンが進化した資料[^dena]。組織内で統一的に機械学習のプロジェクトはこうすすめるべきという指針が出来ていたら成功確率もかなり上がりそうですね。

[Etsy Engineering \| Towards Machine Learning Observability at Etsy](https://www.etsy.com/codeascraft/towards-machine-learning-observability-at-etsy)

Etsy での機械学習システムの監視に関する記事。Etsy ではほとんどのモデルが、24 時間毎に 3 ヶ月分の学習データで再学習してデプロイされている。
つまり高頻度な再学習によりモデルのドリフトを回避している。
だが、再学習のコストは馬鹿にならないので、再学習頻度を抑える代わりに監視を行い、適切なタイミングで再学習を行うようにしたいという自然な動機。

[Google BigQuery の隠れた名機能 \| Google Cloud Blog](https://cloud.google.com/blog/ja/topics/developers-practitioners/hidden-gems-google-bigquery)

AUTO カラムやマルチステートメントトランザクションの機能は知らなかった。まだプレビューだけど、インデックス機能は、BQ にためたデータに対して制約条件を理解した上で検索したいときに大きく役立ちそうですね。

[faker\-ruby/faker: A library for generating fake data such as names, addresses, and phone numbers\.](https://github.com/faker-ruby/faker)
S
table Diffusion などで機械学習による人工的なデータ生成がキャズムを超えそうな気がしていますが、自然言語処理の分野で人工的なデータ生成ってあったけなと思い返すと、Ruby 製の Faker がありました。
README を観てると Japanese media という章があり、[ジブリ](https://github.com/faker-ruby/faker/blob/master/doc/japanese_media/studio_ghibli.md)や[ドラゴンボール](https://github.com/faker-ruby/faker/blob/master/doc/japanese_media/dragon_ball.md)に対応していて驚いた。

[Zig の TensorFlow Lite ライブラリを書いた。](https://zenn.dev/mattn/articles/af64c6a3eefad0)

様々な言語向けに TensorFlow Lite ライブラリを作っている mattn さんが、 zig 言語用の TensorFlow Lite ライブラリを作成。が、Zig のパッケージのエコシステムがまだ未発達なので画像を扱うようなタスクなどは作れないとのこと。

[機械学習の社会実装勉強会 \- connpass](https://machine-learning-workshop.connpass.com/)

2021 年 11 月から、毎月開催されている機械学習の実装に重きをおいた勉強会。
運営している [Machine Learning Casual Talks \- connpass](https://mlct.connpass.com/)を定常開催できなくなってしまっていますが、同じような目的の勉強会が活発なのは嬉しいですね。

[AlexNet 前夜 \- Speaker Deck](https://speakerdeck.com/yushiku/pre_alexnet)

牛久先生による、 AlexNet が席巻するまでの機械学習による画像認識の歴史を俯瞰的に説明してくれた資料。

[PLATEAU から街の構造を見る \- estie inside blog](https://inside.estie.co.jp/entry/2022/08/10/110801)

オープンデータを使って、東京の都市構造、具体的には道路の長さや方角を集計することで、都市の特性を可視化してみたよという記事。
学生の頃にコンピュータービジョンの論文を読み漁っていましたが、位置情報が付与された大量の画像を使って、世界の 26 個の都市構造を解析するという、面白い考えの論文[^cimave]が印象に残っています。それがきっかけで機械学習分野と都市構造など異なる分野を組合わた分析などが好きなネタになりました。

[Step\-by\-Step MLOps and Microsoft Products \- Speaker Deck](https://speakerdeck.com/shisyu_gaku/step-by-step-mlops-and-microsoft-products)
マイクロソフトによる MLOps の成熟度の定義と Azure を使ってどのように実現していくかの日本語の資料。
他の大手クラウドベンダーの GCP[^gcp]や AWS[^aws]も同じような成熟度を定義していますが、クラウドベンダー毎に成熟度を定義してくれれば、各ベンダーでどんなサービスを具体的に使えば実現できるのかわかりやすそうです。

- [ABEJA で作った大規模 GPT モデルとその道のり \- ABEJA Tech Blog](https://tech-blog.abeja.asia/entry/abeja-gpt-project-202207)
  - [abeja/gpt\-neox\-japanese\-2\.7b · Hugging Face](https://huggingface.co/abeja/gpt-neox-japanese-2.7b)
  - [abeja/gpt2\-large\-japanese · Hugging Face](https://huggingface.co/abeja/gpt2-large-japanese)
- [GPT\-neox の学習用にマルチノード並列学習環境を整えた with DeepSpeed \- ABEJA Tech Blog](https://tech-blog.abeja.asia/entry/abeja-gpt-neox-infra-202208)
- [ABEJA GPT モデルにおけるアーキテクチャの工夫 \- ABEJA Tech Blog](https://tech-blog.abeja.asia/entry/abeja-gpt-model-202208)
  ABEJA さんが取り組んだ大規模言語モデル GPT 構築に挑んだ際に得られた知見を惜しみなく公開してくれている記事。
  学習データが巨大すぎて、前処理中にディスクオーバーしたりと、このタスクでしかなかなか味わえないような結果は読み応えがありました。
  Hugging Face でモデルも公開されているのでもし興味があれば試してみるのも良さそうです。Web 上で文章生成をすぐに試せるのでそれだけでも楽しいです。

---

時間を割り切って、小刻みに定期的に書いたほうが、たまりすぎず記事も古くなりすぎず記事を消化できることに今更気がついたので、これから 2 週間毎か毎週くらいでニュースレターをかけたらよいなと思っています。

## 感想など

Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter?f=live) のハッシュタグでつぶやいていただくか、[Google フォーム](https://forms.gle/xFgMwRJbeqJxNtfe9) での感想投稿をお待ちしております。

執筆の励みにさせていただきます。

## Search Engineering Newsletter の購読方法

ニュースレターの更新が気になる方は Newsletter が配信される [RSS](https://shunyaueta.com/tags/newsletter/index.xml)も発行されているので、RSS リーダーで記事を管理したい方はご登録してみてください。
また、今までのニュースレターの一覧は[こちら](https://shunyaueta.com/tags/newsletter/)から閲覧できます。

[^dena]: [AI Project Management Anti Pattern \- Speaker Deck](https://speakerdeck.com/yurfuwa/ai-project-management-anti-pattern)
[^aws]: [MLOps foundation roadmap for enterprises with Amazon SageMaker \| AWS Machine Learning Blog](https://aws.amazon.com/jp/blogs/machine-learning/mlops-foundation-roadmap-for-enterprises-with-amazon-sagemaker/)
[^gcp]: [MLOps: Continuous delivery and automation pipelines in machine learning  \|  Cloud Architecture Center  \|  Google Cloud](https://cloud.google.com/architecture/mlops-continuous-delivery-and-automation-pipelines-in-machine-learning)
[^cimave]: [C\-IMAGE : city cognitive mapping through geo\-tagged photos](https://dspace.mit.edu/handle/1721.1/90205)
