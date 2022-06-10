---
title: "Search Engineering Newsletter vol.07"
date: 2022-06-10T11:35:48+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-01-16/images/1.png"
tags:
  - newsletter
  - search
---

Search Engineering Newsletter 7 回目の配信です。
今回のイチオシは、Andre Ng 先生の対談記事「Unbiggen AI」です。

## Search

[Go beyond the search box: Introducing multisearch](https://blog.google/products/search/multisearch/)

Google が導入する、画像検索 → 自然言語による検索の二段階検索である multisaerch。

Google IO 2022 で、強調されていたのは Google Lens と組み合わせて multisaerch をできるようにしたいと提案されていて、なるほど! 確かに日常的に Google Lens を装着するようになれば multisearch の利用状況はものすごく自然だなと思った。
妄想だが、Google Lens がスタンドアロンで動くように機械学習モデルとかは乗せる必要は極論必要なくて、Google Pixel 上に搭載された機械学習モデルで処理を実行、その結果を視覚には Google Lens 、聴覚には Google Pixel Buds という組み合わせもありそうだなと思いを馳せた。

<iframe width="560" height="315" src="https://www.youtube.com/embed/lj0bFX9HXeE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[How our Quality Raters make Search results better \- Google Search Help](https://support.google.com/websearch/answer/9281931?hl=en&utm_source=pocket_mylist)

Google が公開している、検索品質の評価者が検索結果をどのようにかいぜんしているか。仕事でも検索品質の評価ガイドラインを先日書いていたが、かなり参考にさせてもらった。こういう質の高い文章を書けるようになっていきたい。
利用者にこういうことをするといいよとメッセージとして啓蒙する役割もあるのかもしれない。

[Our Search Liaison on 25 years of keeping up with search](https://blog.google/products/search/danny-25-years-of-search/)
25 年間検索業界に関わってきた Google 検索の広報担当者である Danny さんのインタビュー記事。良い感じに Google 検索の改善の歴史がまとまっているので、良い記事をたくさん見つけることができた。

[More helpful product reviews on Search](https://blog.google/products/search/more-helpful-product-reviews/)

Google 検索が商品レビューの改善を行った。データを更に構造化したり、画像を表示するようになったらしい。

[Google Cloud が Optimization AI をリリース: お客様のルート計画を容易にする Cloud Fleet Routing API](https://cloud.google.com/blog/ja/products/ai-machine-learning/google-cloud-optimization-ai-cloud-fleet-routing-api)

GCP が [Optimization AI](https://cloud.google.com/optimization)をリリース。大規模な最適化問題を API 経由で解決することが可能になる。配送ルートの最適化を行ったり、ワンクリックで Google Map と連携させることの可能らしい。
Chompy さんも過去に配送ルートの最適化に関する記事 [^chompy] が面白かったが、デリバリー関係の企業にすごく刺さりそうな API ですね。

[人手による確認を組み込んだ機械学習パイプラインの実現 \| メルカリエンジニアリング](https://engineering.mercari.com/blog/entry/20220428-06da50715c/)

メルペイによる、機械学習モデルの品質を維持するために人による検査を組み込む工夫を紹介した記事。

> 本来、できることならすべての処理を完全自動化し、人が作業するときの作業ミスのリスクを排除することで高効率な機械学習処理運用を実現したいところですが、品質を担保するために、モデル更新 ⇒ 推論処理 の間、 推論処理結果 ⇒ サービスへのリリース の間で次のステップに移ってもよいか関連データを人が確認する作業をしてから進めています。

与信関係だからこそ QA は最も重要なのでこの意思決定は非常に良いですね。

[検索アルゴリズム改善における機械学習の活用　〜MLOps について〜 \- ぐるなびをちょっと良くするエンジニアブログ](https://developers.gnavi.co.jp/entry/ml-ops/)

ぐるなびでの機械学習でのランキング調整の実験速度を加速させるためにどのように MLOps を行ってきたかの変遷。GCP が提唱する MLOps レベル[^gcp]にそって説明されている。AI Platform Pipeline から Vertex AI Pipelines (サーバーレス)に移行した結果、24 時間稼働から 1-2 時間程度の稼働に変わりコストが 9 割近くカットされたというお話がすごかった。

[検索エンジンの More\-Like\-This クエリとグラフアルゴリズムによる類似記事集約 \- Stockmark Tech Blog](https://tech.stockmark.co.jp/blog/similar_articles_ja/)

類似記事の基準には埋め込みモデルを使って計算はせずに、Elasicsearch の More Like This クエリによって類似記事を取得して、それらをまとめた実験例

## Machine Learning & Data Science

[Multi-language Dataflow pipelines enabled by new, faster architecture](https://cloud.google.com/blog/products/data-analytics/multi-language-sdks-for-building-cloud-pipelines)

Dataflow で、多言語間での処理を橋渡しできる処理が限定的だが可能になったとのこと。例では、Python の処理内で、Java SDK を利用する例が紹介されている。これが発展すれば、基本的な処理は Java で、機械学習部分は Python でということも可能になる未来が見えた。(管理大変そうだが...)

[Andrew Ng: Unbiggen AI \- IEEE Spectrum](https://spectrum.ieee.org/andrew-ng-data-centric-ai)

Andrew Ng 先生のインタビュー記事。
面白かった質疑をメモとして書いておきます。

巨大モデルのその先は?

Ng: 自然言語と比べて、圧縮されてなお動画データは巨大なため、動画にも対応できるか? だが、対象的に小規模なデータから問題を解決したいニーズもあるのが課題。また、巨大モデルでまず先行して NLP 分野が盛り上がったのは、スケーラビリティの問題で、言語データはデータ量は他領域と比べて小さかったからこそ、巨大モデルを構築できたと考えている。
解決方法としては、半導体メーカーが 10 倍の処理能力を提供してくれれば、動画を扱える巨大モデルを構築することができると確信している。

だが、 そうは言っても、過去 10 年間に起こったこ多くの事例は、非常に大規模なデータセットを持つ消費者向け企業で深層学習が使われたことで、機械学習のそのパラダイムは、消費者向けソフトウェアに多くの経済的価値をもたらしましたが、その規模の取り組みは、大規模なデータセットを持たない他の業界では機能しないことがわかった。

与太話として面白かったのは、Google Brain を立ち上げた際に、大規模ニューラルネットワークを構築するために、Google 内部のインフラストラクチャを使って構築しようとした際に、偉い人に「インフラのスケールアップで解決するのではなく、モデルのアーキテクチャに目を向けたほうが良い」と水をさされたり、Ng 先生が初めて NeurIPS で CUDA を扱うワークショップを開催した際に、機械学習業界の熟練者が「CUDA は複雑なプログラミングモデルだから、普及しないんじゃないのか? 」とアドバイスしてきたが、今は二つとも主流になっているのが、先見の明がすごかった。

[How we kept information on Maps reliable in 2021](https://blog.google/products/maps/how-we-kept-maps-reliable-2021/)

2021 年の段階で、Google Map 上での情報をどのように信頼性を保っているか。
COVID-19 の影響で、Google Map の必要性が更にたかまりそれに伴って扱う情報も信頼性を上げるかが急務になったとのこと。

700 万枚の Google Map のビジネスプロフィールを機械学習により削除、悪意のある 1200 万件以上のビジネスプロフィール作成依頼に対応し、機械学習により 100 万以上の詐欺行為を行うアカウントを無効化した。

9500 万枚の規約違反のレビューを削除したり、最終的に 1.9 億の画像を削除し、500 万件の低品質な動画(ぼやけてたり、規約違反なもの)を削除。

規模がすごすぎる。さすが MAU が 10 億超えのサービスは違いますね。

[BigQuery Remote Functions \(Preview\) をデータパイプラインに組み込んでみました](https://lab.mo-t.com/blog/bq-remote-functions)'

Preview ですが、BigQuery で Cloud Function を呼び出せる Remote Funcitons 機能の紹介記事。BigQuery 内では完結できないような処理を Apache Beam とかではなく、Cloud Function を使って処理を行えるのはお手軽で良さそうです。
BigQuery は UDF で JavaScript などで処理もできますが、Python で形態素解析とかちょっとしたことをできたら夢が広がりますね。

値段帯が気になったので調べてみたところ

| 呼び出し回数（1 か月あたり） | 料金（100 万回あたり） |
| ---------------------------- | ---------------------- |
| 最初の 200 万回              | 無料                   |
| 200 万回を超えた分:          | $0.40                  |

と書いており、個人用途としては、毎月 200 万回まで無料というのは素晴らしいが、数億規模の行数を RemoteFunction で行うと、即死しそうな気がしたが、どうなんだろうか...?

[Machine Learning at Wolt: Our journey towards MLOps \- Wolt Blog](https://blog.wolt.com/engineering/2022/04/20/machine-learning-at-wolt-our-journey-towards-mlops/)

DoorDash に買収された フードデリバリーサービスの Wolt の MLOps 事例。
主に、ロジスティクス周りで機械学習を活用しており、配送時間予測などが最たる事例。
データサイエンティストによる機械学習モデルのデプロイ方法が集約・管理されておらず、中央集権的にサービス提供ができていなかったので機械学習基盤を刷新した。

リアルタイムでのフレームワークとして[Seldon-Core](https://github.com/SeldonIO/seldon-core) を利用。採用理由としては OSS なので、自分たちが欲しい機能をコントリビュートの形式で提案できるところや、[V2 Data Plane inference API](https://kserve.github.io/website/modelserving/inference_api/) により、様々な機械学習・深層学習フレームワーク似依存しない API として提供できるのが利点とのこと。

`NOTE`: `V2 Data Plane inference API` は、調べてみると KServe が提案する、特定の機械学習・深層学習フレームワークに依存しない推論・予測を提案しているプロトコルで、GYYP, gRPC 形式で、モデルのメタデータやヘルスチェック、推論をどのように行うかが提案されている。NVIDIA Triton Inference Server[^nvidia], TensofFlow Serving , ONNX Runtime Server が準拠している。
余談) [KServe ](https://www.kubeflow.org/docs/external-add-ons/kserve/kserve/)は、k8s を基盤とした OSS の機械学習基盤である KubeFlow のサービング部分を担当していた KFServing が Kserve という名前に変更された。
k8s ベースで、seldon の Deployment のマニフェストを作れば、REST& gRPC のサービスがデプロイされるようにしており、かなり抽象化されている。

面白かったのは、Wolt は内部のアルゴリズムを詳細ではないがどのように動いているかを透明性を目的に公開するページ[^wolt]があり、透明性の動きとして面白かった。

## 感想など

Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter?f=live) のハッシュタグでつぶやいていただくか、
[Google フォーム](https://forms.gle/xFgMwRJbeqJxNtfe9) での感想投稿をお待ちしております。

執筆の励みにさせていただきます。

## Search Engineering Newsletter の購読方法

配信記事が蓄積される [RSS](https://shunyaueta.com/tags/newsletter/index.xml)を作成しています。

また、今までの配信記事一覧も[こちら](https://shunyaueta.com/tags/newsletter/)から閲覧できます。

## 余談

前回の newsletter をきっかけに、szdr さんから[投げ銭](https://www.buymeacoffee.com/hurutoriya/c/3349194)をいただきました! ありがとうございます!
[良い書籍](https://www.lambdanote.com/blogs/news/ir-system)を世に出していただいたので、本来なら僕から贈りたいところですが...

[^wolt]: [Transparency at Wolt](https://explore.wolt.com/en/hun/transparency)
[^google]: [searchqualityevaluatorguidelines](https://static.googleusercontent.com/media/guidelines.raterhub.com/ja//searchqualityevaluatorguidelines.pdf)
[^nvidia]: [GPU に推論を Triton Inference Server でかんたんデプロイ](https://medium.com/nvidiajapan/gpu-for-inference-easy-deploy-by-triton-inference-server-fd2980514af2)
[^gcp]: https://cloud.google.com/architecture/mlops-continuous-delivery-and-automation-pipelines-in-machine-learning
[^chompy]: [ Chompy を支えるアルゴリズムに迫る](https://note.com/chompy/n/nb833abe6cebe) 過去に詳細な技術記事があったが、削除されてしまったみたいですね。残念
