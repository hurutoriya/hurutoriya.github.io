---
title: "Search Engineering Newsletter vol.03"
date: 2022-03-28T22:17:33+09:00
lang: ja
cover:
  image: "/posts/2022-01-16/images/1.png"
author: Shunya Ueta
tags:
  - newsletter
  - search
---

3 回目のニュースレター配信です。

## 前回配信した中での人気記事 Top3

メール配信で最もアクセスされた記事を紹介します。

1. [Amazon が e コマース検索を Lucene により、どうスケールさせているか at Berlin Buzzwords 2019](https://shunyaueta.com/posts/2021-11-26/) 6 clicks
1. [390 億から 820 億パラメータへ｜ LINE の巨大言語モデル HyperCLOVA 開発の裏側](https://ainow.ai/2022/01/31/262132/) 5 clicks
1. [メルカリの検索基盤の変遷について](https://engineering.mercari.com/blog/entry/20220207-776318b784/) 5 clicks

## Articles

### Search

[Amazon の製品検索で使われるロバストなキャッシュ手法の論文「ROSE: Robust Caches for Amazon Product Search」](https://shunyaueta.com/posts/2022-03-03/)

Amazon 検索で使用されているロバストなキャッシュの仕組みについて紹介した Blog 記事を書きました。
キャッシュ機構の中で、クエリ書き換えと深層学習モデルの推論結果のキャッシュを同時に実行している点が技術的にとても面白い点です。

[検索一筋 10 年のエンジニアが語る、1,800 万点の商品検索パーソナライズ化への挑戦- モノタロウ](https://note.com/monotaro_note/n/n96d5874d3190)

モノタロウさんの検索機能はとてもおもしろいんですが、その開発裏が書かれている記事。
例えばですが、[工具の通販モノタロウ 測定・測量用品 測定用品 厚さ測定](https://www.monotaro.com/s/c-80528/)とかを見てるとわかるんですが、各商品に付随する商品のファセットの種類が鬼のように細かくてどう管理しているのか非常に気になりますね。

> 例えば、キーワード入力の少しの違いでユーザーが必要としている商品が違ってくることもあり、全文検索機能だけでは計算ができない部分を外側から調整する仕組みなども構築してきました。わかりやすい例をあげると、「3m テープ」と検索された場合は、ブランドの 3M（スリーエム）社製のテープを求めているお客様が多く、「テープ 3m」と検索された場合は 3 メートルのテープを求めているお客様が多いなどを判定して検索結果を出し分けています。

良い話ですね。確かに bi-gram としては一緒でも、Query intent は全く違いそう。

> これまで検索システム構成では検索エンジンの AB テストは実施しづらかったのですが、Elasticsearch 導入後には実施できるようになります。

Solr から Elasticsearch に乗り換え成功した後は、ぜひ技術ブログなどでその裏話を公開してほしい...

[【身近な OMO】商品が見つからないを解決「カインズホームアプリ」から学ぶ、大型ホームセンターでの新しいお買い物体験](https://iridge.jp/blog/202010/28137/)

凄いなと思ったのが、カインズのアプリで商品を検索した際にお気に入り店舗で、その商品の在庫数と配置されている場所を表示してくれること。これは良い検索の形だなと思った。実際店員さんに聞く前に自分で調べられるのは気楽そうだし、効率化につながると思う。在庫の数とか POS レジが DB と連携してると思うと面白い。

[Autosuggestion services in web search](https://medium.com/data-science-at-microsoft/autosuggestion-services-in-web-search-9d4f71c662c6)

MicroSoft Data Science のブログ記事。存在を初めて知ったけど高品質な記事が多くて嬉しい。
QAC の今までの歴史を振り返ってくれてたり、何が技術トレンドを抑えつつ、何が重要な課題なのかをまとめてくれている。技術記事というより論文のようにまとめてくれているので、俯瞰的な周辺知識が身についた。

Amazon が[QAC の特許](https://patents.google.com/patent/US6564213B1/en)を取ってたり、[Google Suggest](https://googleblog.blogspot.com/2008/08/at-loss-for-words.html)のコードネームも初めて知った。

[Elastic 8.0 ― 新時代のスピード、スケール、関連性、シンプルさ](https://www.elastic.co/jp/blog/whats-new-elastic-8-0-0?storm=nav-products-new)

目玉機能としては Liucene 9 からサポートされた近似近傍探索(ANN)機能が Elasticsearch にも搭載された。Elasticsearch 内部で直接 PyTorch の機械学習モデルが動くようになったらしくそれも大きな変化。
記事内容と全く関係ないんですが、Elastic 社の Blog、英語を選択しても強制的に日本語環境にリダイレクトされるの改善してほしい。

[Introduction to modern natural language processing with PyTorch in Elasticsearch](https://www.elastic.co/jp/blog/introduction-to-nlp-with-pytorch-models)

Elasticsearch 内部で PyTorch モデルがどう動くかの解説記事。[eland](https://eland.readthedocs.io/en/v8.0.0/)という Elasticsearch をバックエンドにして Dataframe と機械学習モデルを動かせる Python ライブラリを使うことで実現している。例えば Dataframe による処理を行う場合

https://eland.readthedocs.io/en/v8.0.0/examples/demo_notebook.html#Compare-Eland-DataFrame-vs-pandas-DataFrame

```python
ed_flights = ed.DataFrame('http://localhost:9200', 'flights')
```

と `flights` インデックスから、指定した ES のエンドポイントを通して Dataframe を作成する。
実環境でどれくらいのパフォーマンスが出るのかはわからないけど、ES 内部で完結するのは大きな夢がある。[vespa](https://vespa.ai/) とまた違う結合方法だけど、両者ともに競い合ってほしい。

[8.0 からの kNN はどう変わったのか / How kNN search changed in the Elasticsearch 8.0](https://speakerdeck.com/pakio/how-knn-search-changed-in-the-elasticsearch-8-dot-0)

@pakio さんによる Elasticsearch 8 から導入された ANN 機能の解説。実際に動かしてみて、ベンチマークを取って速度や検索性能などを比較してくれている。

[Apache Lucene™ 9.1.0 available](https://lucene.apache.org/core/corenews.html#apache-lucenetm-910-available)

Lucene 9.1.0 が利用可能に。注目する新機能は、近傍探索でフィルタリング機能が導入されたところが気になる。最適化の欄で N%早くなりましたが毎回のアップデートで連発していてすごすぎると毎回感動している。

[Milvus 2.0 - A Glimpse at New Features](https://milvus.io/blog/2022-1-27-milvus-2-0-a-glimpse-at-new-features.md)

ベクトル検索 DB Milvus のメジャーアップデートのアナウンス。[Milvus Architecture Overview](https://milvus.io/docs/architecture_overview.md)の記事が Milvus の設計を把握できる。Faiss や Annpy, HNSW などの近似近傍探索パッケージはあるけども、Milvus は近似近傍探索を行う際に、データシャーディングやストリーミングでのベクトル挿入など本本運用で嬉しい機能を揃えた近似近傍探索データベースらしい。

[meilisearch](https://www.meilisearch.com/)

Rust で書かれた OSS の検索エンジン。REST API でホスト可能で、速度と Typo への頑強性、同義語など検索エンジン提供時に直面する課題を簡単に解決可能らしい。

[jina-ai/jina](https://github.com/jina-ai/jina)

マルチモーダルな検索を容易に実現可能な Nerral Search フレームワーク Jina。
今年の 2 月に [v3](https://github.com/jina-ai/jina/releases/tag/v3.0.0) がリリースされた。元 Tencent AI の Lead Engineer の [Dr. Han Xiao](https://www.linkedin.com/in/hxiao87/) さんが立ち上げた会社が開発している。名前自体は Han さんの Blog で知っていたけれど OSS で開発されていたのは知らなかった。

[Google と Microsoft が大量のスパム広告を DuckDuckGo などの小規模検索エンジンに表示させていることが判明](https://gigazine.net/news/20220222-google-microsoft-search-engine/)

すごく断定的な記事になっているけど、広告に対して作為的な操作を感じますね。時々判明するけど水面下では、競合潰しのために仁義なき戦いが裏で勃発しているのだろうか。

[How AI powers great search results](https://blog.google/products/search/how-ai-powers-great-search-results)

Google による機械学習をどうやって検索結果に活用しているかの解説記事。

2015 年に RankBrain という深層学習システムが Google の検索システムにデプロイされた。
このシステムをデプロイすることで、検索での単語がどのように現実世界の概念に関係しているか幅広く理解するきっかけになった。
例えば、「what’s the title of the consumer at the highest level of a food chain(食物連鎖の最高レベルでの消費者の称号は何ですか)」
と検索すると、Rank brain は、多数のページからそれらの単語を学習することで、食物連鎖の概念は人間の消費者ではなく動物の事を指していることを学ぶ。それらの学習結果からこの検索キーワードは「頂点捕食者」について期待していることを RankBrain は理解する。

2018 年には、[Neural matching](https://www.blog.google/products/search/improving-search-next-20-years/) を Google 検索に導入。Neural mathcing は、クエリとドキュメントの曖昧な表現を理解し、クエリがそのドキュメントにどれくらいマッチしているかを計算している。
例えば、「insights how to manage a green(緑色の管理方法の洞察)」と検索したとする。もし友達がこのキーワードであなたに質問をしてきたら、あなたは困惑するでしょう(意味がわからないので)。だが、Neural matching によって、そのクエリが意味することを理解して検索結果を提示する。

2019 年には、BERT をリリースすることで自然言語理解への大きな一歩となった。
例として。「can you get medicine for someone pharmacy(あなたはほか誰かのために薬局で薬を手に入れることができますか？)」と検索すると、BERT はあなたが他のだれかのために薬を手に入れようとしていることを理解します。BERT 以前は主に処方箋の記入方法に関する結果を表示しており、質問文に対する理解ができていなかった。
現在、BERT はほぼすべての英語のクエリで重要な役割を担っている。なぜなら BERT のシステムは、ランキングと検索の２つの重要なタスクで優れた結果をだすからだ。注意点としては BERT は重要な役割のコンポーネントではありますが、BERT 単体で機能することはない。

そして、2021 年 5 月に最新の機械学習マイルストーンである Multitask Unified Model(MUM) を紹介。BERT よりも 1000 倍協力(この表現が既にイカれている感じがして良いですね..w)なモデルで、75 言語をまたがり、複数タスクを一度に理解するモデル(らしい)。検索を質疑応答的に処理できる。。。らしい?

MUM は COVID-19 のワクチンの検索結果改善で既に使われていたり、Google Lens でのテキストや画像を組み合わせた検索で使われているらしい。

また、MUM を導入する際には、[Responsibly applying AI models to Search](https://blog.google/products/search/responsibly-applying-ai-models-search/)の考えに沿って導入するとのこと。この考えは面白そうなので、Blog でメモを書いてみたい。

### Data Science & Machine Learning

[機械学習モデルの改善手法の一つ、 Human In The Loop について](https://shunyaueta.com/posts/2022-03-22/)

Human In The Loop と呼ばれる、機械学習モデルの改善手法の一つについて Blog 記事を書いたので、興味のある方は御覧ください。高品質なデータを効率的に収集するというのは、機械学習の実践において未来永劫のテーマだと思う。

[Google による機械学習の実応用をテーマにした Coursera の講義は、機械学習プロジェクトに携わるなら一度は見ておいても損はない](https://shunyaueta.com/posts/2022-03-17/)

機械学習プロジェクトに携わるなら、エンジニア以外でも是非見てほしい講義について Blog 記事を書きました。

[Google が公開している、より良いデータ分析のためのガイドブック「Good Data Analysis」で、データ分析の要所が簡潔にまとめられていて感動した](https://shunyaueta.com/posts/2022-03-08/)

データ分析を行う中で大事な考えについて Google が公開してくれていたので、感動した部分を記事に書きました。

[Reliable Machine Learning](https://www.oreilly.com/library/view/reliable-machine-learning/9781098106218/)

SRE の考えを機械学習の運用に適用した MLSRE の書籍が発刊予定。Google で機械学習システムの SRE として先陣を切って経験を積んでいる方々が執筆予定なので非常に

目次の

- General Reliability Principles
  - Most failures will not be ML failures
  - Models will be retrained
  - Models will have multiple versions (at the same time!)
  - Good models will become bad
  - Data will be unavailable
  - Models should be improvable
  - Features will be added and changed
  - Models can train too fast
  - Resource Utilization Matters
  - Utilization != Efficiency
  - Outages include recovery

とかだけでも面白さが伝わってきますね。「Most failures will not be ML failures」は OpML20 に参加した時に Todd さんが講演していた内容。

OpML20 での公園メモをブログに残しているので気になる方はこちら → [MLOps の国際会議 OpML'20 に論文が採択されたので登壇してきた](https://shunyaueta.com/posts/2020-09-06/#how-ml-breaks-a-decade-of-outages-for-one-large-ml-pipeline)

[【TURING】End-to-End で限定コースをぐるぐる走る機械学習モデルを作って実際に車を動かした話【自動運転】](https://zenn.dev/turing/articles/budapest_tech_blog)

車を改造して、データの取得とハンドルの操作をできるようにしたり、Web カメラが熱によって壊れるので毎回取り外しをしていたらハンドル角の学習データにズレが発生したなど非常に現場を感じ取れる良い記事。。Web カメラの取り外しによるズレ自体は許容してモデル側でそのズレを吸収したのもおもしろい。

[Lupus - A Monitoring System for Accelerating MLOps](https://speakerdeck.com/line_devday2021/lupus-a-monitoring-system-for-accelerating-mlops)

LINE で開発している内製のモニタリングシステムのお話。LINE 内では 100 超の機械学習サービスを運用しているらしく、たしかにその規模なら内製でモニタリングシステムを作る価値はあるだろうなと思った。プラットフォームから透過的に提供される機能としてもモニタリング機能ってありがたい気がするし、スケールしそう。

[Improvement in Information Reception Experience of LINE Official Account of LINE Pay by Data Science](https://speakerdeck.com/line_devday2021/improvement-in-information-reception-experience-of-line-official-account-of-line-pay-by-data-science)

LINE PAY の公式アカウントから送られるメッセージの改善を Data Science で改善したお話。15P 目の価値あるメッセージと価値がないメッセージの振り分けを見てると

- CTR が高く、ブロックもされない: クーポン、新機能
- CTR が低く、ブロックもされる: LINE PAY ではない、LINE の金融サービスの情報

とド直球な内容公開になっており面白かった。データとしてこれを出すのは簡単だと思うけど、内部で他のサービスへの通知メッセージ送らないように統制するのが一番大変そう。

[“ひとり開発”の AI で 1 日数千万件の広告審査を効率化　「AI は詳しくない」ヤフー社員が実現できたワケ](https://www.itmedia.co.jp/news/articles/2201/13/news113.html)

これぞ、真の AI の民主化という記事。

> 機械学習やデータ分析の専門家だけでなく、広告審査の担当者も AI モデルの調整に携われるメリットもあった。ヤフーは今も継続的に AI モデルをアップデートしており、広告審査の企画担当者が自分で Big Query や Cloud AutoML を直接触って AI をチューニングすることもあるという。

実際に専門知識を一番持っている広告審査の人が Coud AutoML を触ってチューニングしているなんて素晴らしい話ですね。良い未来が期待できる記事だった。

[Streamlit and Snowflake: better together](https://blog.streamlit.io/snowflake-to-acquire-streamlit/)

データレイクを提供する Snowflake が Python script だけで Web アプリを簡単に作成可能な streamlit を買収。記念に雪が舞い落ちる st.snow()のみをサポートした Streamlit 1.7.0 をリリースしたのは粋ですねぇ。

[nbQA](https://github.com/nbQA-dev/nbQA)

Juipyter Notebook に対して CLI で、Python で一般的に使われる人気の Linter や Formatter を適用できるツール。CI とかに組み込んでおけば何も考えずとも Notebook の質が最低限は確保されそう。

[Apache Beam 2.37.0](https://beam.apache.org/blog/beam-2.37.0/)

Apache Beam で 最新の Java LTS である Java 17 をサポート。
Beam での Cross Language Transforms 周りの機能も気になるので試してみたい。

[MLOps のこれまでとこれから](https://speakerdeck.com/icoxfog417/mlopsfalsekoremadetokorekara)

[ML Study #2「MLOps のこれまでとこれから」](https://forkwell.connpass.com/event/237213/)の講演資料。俯瞰的に MLOps についてどう取り組んでいくべきかについて語られている。
確かに、企業で MLOps を開始したい際に、ワークショップなどの開催も同時に行えるのは AWS ならではの強みだなと思った。
@icoxfog417 さんが AWS の DevRel へ転向されたのは驚きましたが、機械学習活用の普及を応援しています。

## 感想

Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter?f=live) をつけてつぶやいていただくか、
[Google フォーム](https://forms.gle/xFgMwRJbeqJxNtfe9) での感想投稿をお待ちしております。

newsletter のタグを付与した記事の RSS[^newsletterrss] を作成しています。
手持ちの RSS リーダーに登録していただければ newsletter の更新を把握することができます。

[^newsletterrss]: newsletter RSS: https://shunyaueta.com//tags/newsletter/index.xml
