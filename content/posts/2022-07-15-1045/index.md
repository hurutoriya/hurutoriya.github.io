---
title: "Search Engineering Newsletter vol.08"
date: 2022-07-15T10:45:19+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-01-16/images/1.png"
tags:
  - newsletter
  - search
---

Search Engineering Newsletter 8 回目の配信です。

今回のイチオシは、Retty さんの検索機能をマイクロサービスとして切り出したお話と、MoT さんの勉強会資料である「Tesla におけるコンピュータビジョン技術の調査」です。

## Search

[検索サービスの構築 \- Retty Tech Blog](https://engineer.retty.me/entry/2022/06/08/173340)

Retty で検索サービスをマイクロサービスとして切り出したお話。
切り出した理由としては Elasticsearch が返すレスポンスをベースにして各サービスでそのまま使われていた。だが、各サービスがこのフォーマットに依存しているせいで気軽に Elasticsearch の更新ができなかったり、レスポンスを変えるような検索改善も行うのが難しくなっていたのを起因にマイクロサービスへと切り出した。

`NOTE:`インタフェース設計が割り切っており、お店の id のみを返し全てのデータは検索エンジンは返さないようにしているのが良い設計だなと思いました。今までは、検索エンジンに反映されるまでリードタイムが 1 日あり、古い結果が返ることもあったのところです。実際に、検索エンジンがお店の情報管理を責任を持つのは違いますしね。
また、Go で Elasticsearch の API client として、比較を行ったり、マイクロサービスの切替時にどうやって検索結果が等しく切り出せているかを検証しつつ切り出したのは面白かったです。

[Elasticsearch で個人ごとに検索結果を表示するには？　 ZOZOTOWN を支える検索パーソナライズ基盤アーキテクチャ \- ログミー Tech](https://logmi.jp/tech/articles/323463)

2020 年 6 月の記事で少し古いですが、ZOZO さんの検索結果をパーソナライズする機能をどのようにつくったかが紹介されています。

[「新しいおうち探し」のための AI アシスト検索 〜 Yahoo\!不動産の技術紹介 \- Yahoo\! JAPAN Tech Blog](https://techblog.yahoo.co.jp/entry/2022052330303047/)

不動産検索で、機械学習をどうやって活用しているかの紹介記事。
アイデアとして面白いなと思ったのは、NIMA[^nima]という画像の審美的美しさを採点するモデルを使って、不動産の外観画像のスコアリングを行っていた点が面白かった。

[Search architecture revamp](https://engineering.grab.com/search-architecture-revamp)
Grab が検索システムをどう刷新したか。

2021 年以前、Grab の検索アーキテクチャは、Elasticsearch をベースにしたテキストマッチングのみをサポートしていた。
課題点としては、

- テキストマッチングのみが検索にヒットし、検索意図や文脈が考慮されない
  - たとえば、「Bread(パン)」というクエリで検索した場合、昼ならパンを提供するカフェを探している可能性が高いが、朝なら朝ごはんにパンを食べるために検索を行っている可能性が高い。
- Grab は複数のビジネス領域をサポートしているが、各領域の結果が効果的に混ざっていない
- レガシーコードベースの影響で、改修速度が遅くなっており迅速な新機能開発ができない

刷新後の検索システムは、Multi-recall という枠組みで、検索エンジンを Elasticsearch 以外に、recall を向上させる見込みで埋め込み空間やグラフベースでの Semantic Search を追加。これにより、検索品質の改善を期待している。
(SementicSearch をどう実現しているかの詳細は全く書かれていなくて残念)

また、プラグインベースで実装することにより、柔軟なプロダクト開発を可能にしている。実現できたこととして、

- サービスチームと基盤チームでは関心事が違うので、プラグインベースで開発可能にすることで抽象化がされ、新機能開発が高速化
  - `NOTE` ここらへんは非常に共感できて、大規模なチームで一つの検索サービスを開発していくと、抽象化して上手く疎結合に開発・実験できるような設計にしておかないと、加速度的に実験速度が遅くなってしまう...
- 再利用可能なプラグインを用意することで、プラグインの再利用性をスケール可能にする。

[Grab to be fully powered by its own mapping technology by Q3 2022 \| Grab SG](https://www.grab.com/sg/press/tech-product/grab-to-be-fully-powered-by-its-own-mapping-technology-by-q3-2022/?fbclid=IwAR0KflZ0vgr0bblw4E-TwY-U1oS2I35ZKhGzLK8kvFJ0PhIq76wEKbiHohI&utm_source=pocket_mylist)
Grab が自家製の地図エンジンを作成。Grab のビジネス形態上、到着時間予測を可能にする地図技術は核となる領域だが、内製するという意思決定は凄い。
現時点で 3rd party の地図エンジンと比較して GrabMap は、1/4 のエラー率と 10 倍早い応答速度など、既に内製エンジンが優位とのこと。

[Performance \- Stack Exchange](https://stackexchange.com/performance)

Stack Exchange(StackOverflow も含む) の検索サービスの構成が公開されている。

3 ELASTICSEARCH SERVERS
RAM: 196GB • Load balanced
CPU usage 　 7 %
Peak: 20%
34 M searches /day
528 GB index size

日時で 3 億の検索と、528GB のインデックスサイズはなかなかに大規模。

[What's new in v0\.27](https://blog.meilisearch.com/whats-new-in-v0-27/)

Rust で動く検索エンジンの meilisearch が 0.27 で日本語対応に。

[Amazon の推薦システムの 20 年 \| Takuya Kitazawa](https://takuti.me/ja/note/two-decades-of-amazon-recommender/)

現在は、Amazon の推薦エンジニアとして働いてい takuti さんが 2017 年にかきあげた、「Amazon の推薦システムの 20 年」の記事を紹介した記事。
語り口も軽快で楽しく読めるのでおすすめです。

## Machine Learning & Data Science & MLOps

[SRE NEXT で「AIOps 研究録」講演を終えて \- ゆううきブログ](https://blog.yuuk.io/entry/2022/srenext)

機械学習による障害発生時の原因究明の自動化を狙っている。
MLOps と差別化するために意図的に AIOps という単語を使っている模様。

分野的には SRE 分野を機械学習で自動化したいという動機なので Todd Underwood さんの [OpML '20 \(Short\) \- Automating Operations with ML \- YouTube](https://www.youtube.com/watch?v=CCKWr6H9g08)に近いものがある。

[What are ML Sensors? « Pete Warden's blog](https://petewarden.com/2022/06/09/what-are-ml-sensors/)

TensorFlow Lite の Tech Lead を務めていた [Pate]([\(23\) Pete Warden \| LinkedIn](https://www.linkedin.com/in/petewarden/)) さんの執筆記事
組み込み機器での機械学習活用の可能性について書かれている。

まず興味深い記事として、[TinyML needs a big use case\. Or any use case](https://staceyoniot.com/tinyml-needs-a-big-use-case-or-any-use-case/) では、組み込みシステムでの機械学習アプリについての可能性が語られており、

- おそらく、組み込みの機械学習での一番の需要は wake word の検知。
  - `NOTE`:例えば、VUI(音声インタフェース)に対してと呼びかける際にトリガーとなる言葉が wake word ですね。
- 人物の数え上げと検出も需要のある事例。画像を送信する代わり、認識結果をサーバーに送れば良い。
  がこれからもっと普及すると書かれている。

この ML Sensors の記事では Google での経験から巨大な機械学習チームによって、デバイス上での機械学習プロダクトは成功しているが、実際これは他の業界では再現が難しい。中国に訪れて家電メーカーの企業に TensorFlow Lite Micro を使った組み込みでの機械学習モデルについて語っても誰も Python さえ使ったことが無い状況だった。

ここで気がついたことは、Google が行ってきたようにスマホ上で TensorFlow Lite のモデルを動かしてきたやりかたが、他の領域では通用しないことがわかった。多くの企業は[Edge Impulse](https://www.edgeimpulse.com/)のような素晴らしいツールを使って効率化できたとしてもソフトウェアの開発リソースが無い。そこで機械学習モデルを小型で安価なハードウェアモジュールとして提供することが良い解決策になるかもしれないと考え、それが [ML Sensor](https://arxiv.org/abs/2206.03266)の考えのもととなった。
また Arm が考える TrustZone [Privacy\-Preserving Inference on the Edge: Mitigating a New Threat Model \| OpenReview](https://openreview.net/forum?id=rlHeH9tx3SM) も検討していたが、センサ内で機械学習処理を行うことで、中央のマイコンと切り離されセキュリティ的に強固に設計できる可能性もある。

`NOTE:` つまり、機械学習モデルによってセンサーモジュールを抽象化して、組み込み機器で扱いやすくして提供するということですね。確かに爆発的な普及にきっかけになるかもしれない

[How to Interview a Data Scientist](https://www.slideshare.net/dtunkelang/how-to-interview-a-data-scientist)

検索業界では有名な Daniel Tunkelang さんの過去のスライド
データサイエンティストのインタービューをどのように行うべきかが書かれている。2013 年に書かれたものだがまだ色褪せていない。
特に特定知識の質問をするのではなく、候補者には Data Science を使ってこのプロダクトをどうデザインするか聞くのが一番見極められると書いてて、同意しかなかった。

[Tesla におけるコンピュータビジョン技術の調査](https://www.slideshare.net/KazuyukiMiyazawa/tesla-250957016)

Tesla のコンピュータビジョン技術をまとめた資料。時系列でどのような技術が実現されていったかを統一的にまとめてくれています。
Tesla が如何に効率的にデータを収集して、モデルに組み込むかを戦略的にやっているかを知ることができ、楽しく読み進めることができました。
日本語で読めるのありがたいですし、MoT さんの社外発信文化はとても良いですよね。

[taishi\-i/awesome\-japanese\-nlp\-resources: A curated list of resources dedicated to Python libraries, pre\-trained models, dictionaries, and corpora of NLP for Japanese](https://github.com/taishi-i/awesome-japanese-nlp-resources)

日本語の資源言語処理を行うツールを集めたリポジトリ。

[素人発想玄人実行 2\.0 ｜藤吉弘亘｜ note](https://note.com/hf149/n/ncfcde728e827)

自分は金出武雄先生の「素人発想玄人実行」という言葉が大好きで、仕事の指針にもなっている。藤吉先生がその言葉の解釈の記事を執筆されていて面白かった。

金出先生が藤吉先生に送られた「着眼大局着手小局，素人発想玄人実行」という言葉もめちゃくちゃいいですね。
「着眼大局着手小局」は、大きな局面を見据えて小さく始める、ということだと思うんですがこれも良い言葉ですね。

[A Quality Model for Machine Learning System \| Booking\.com Data Science](https://booking.ai/a-quality-model-for-machine-learning-systems-892118be9e19)
機械学習システムの品質モデルという概念を提案。
機械学習システムの質を定義可能にすることで品質要件を明確にすることができるよねというお話。
ソフトウェア工学では、品質モデルという概念が何年も前に考案されているが、そこから触発されて提案。

Utility, Economy, Robustness, Modifiability, Productionizability, Comprehensibility,Responsibility の 7 項目で定義されている。

`NOTE:`GCP, AWS, Azure が MLOps の成熟度モデルを定義していますが、機械学習システム全般を俯瞰した定性的なモデルはまた別概念で面白い。各社が定義しているモデルは面白いので今度記事にしたい。

[OpenSearch 2\.0 is now available\! · OpenSearch](https://opensearch.org/blog/releases/2022/05/opensearch-2-0-is-now-available/)

AWS が開発する Elasticsearch を基にした OSS の検索エンジン。
OpenSearch の機械学習プラグイン[^opensearch-ml] の設計思想は面白かったので簡単にメモ。

既存の大きな課題点として、機械学習の処理は計算処理的に非常に重いが、OpenSearch 内で機械学習ジョブを実行するためのリソースを追加する方法がない。なので機械学習ジョブを実行してしまうと、indexing, searching に悪影響を与えてしまうという問題があった。
なので、解決方法として、OpenSearch クラスター内部で実行可能な機械学習ライブラリを提供することにする。主要な機能は以下

- 統一されたクライアントインタフェース: 統一されたインタフェースを通じて学習と推論を実行可能
- 機械学習エンジン: Java で書かれた機械学習アルゴリズムが稼働するエンジン。
- 機械学習プラグイン: OpenSearch 内での機械学習実行の適切なリソース管理をしてくれるプラグイン

また近似近傍探索も OpenSearch1.2 では faiss を使ってサポートされていたが、Lucene [^opensearch-ann]でも近似近傍探索がサポートされたので、今後どうバランスをとっていくのだろうか。

大本の Elasticsearch とは異なる方向に進化していっているので、これからどう差別化されていくのか非常に期待している。

[One\-stop MLOps portal at LinkedIn \| LinkedIn Engineering](https://engineering.linkedin.com/blog/2022/one-stop-mlops-portal-at-linkedin)

Linkedin の内製機械学習基盤のユーザーインターフェースの役割を果たす MLOps portal の紹介。

この MLOps portal を通じて機械学習モデルの作成や比較、リリース後の精度監視なども可能になっている。

[rinna 社、日本語に特化した言語画像モデル CLIP を公開｜ rinna 株式会社のプレスリリース](https://prtimes.jp/main/html/rd/p/000000031.000070041.html)

rinna 社は今までも日本語に特化した GPT や BERT のモデルを OSS として公開してきたが、今回は日本語に特化した CLIP(言語と画像の関係を表現)を公開。

`NOTE:`基本的に英語のデータセットを翻訳にかける際に、翻訳という行為によってデータセットの質がどれくらい劣化しているかは気になりました。
2019 年に Meta が物体認識システムもデータセットによる地域的なバイアスを受けてパフォーマンスが異なっているという面白い論文[^meta] を出しましたが、大規模汎用モデルの時代になってくると、高品質な非英語のデータセットを作成するのは、ますます重要になってきますね。

## 感想など

Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter?f=live) のハッシュタグでつぶやいていただくか、[Google フォーム](https://forms.gle/xFgMwRJbeqJxNtfe9) での感想投稿をお待ちしております。
執筆の励みにさせていただきます。

## Search Engineering Newsletter の購読方法

Newsletter のみが配信される [RSS](https://shunyaueta.com/tags/newsletter/index.xml)を作成しています。
また、今までの配信記事一覧も[こちら](https://shunyaueta.com/tags/newsletter/)から閲覧できます。

[^meta]: [Does Object Recognition Work for Everyone?](https://research.facebook.com/publications/does-object-recognition-work-for-everyone/)
[^opensearch-ml]: [opensearch\-project/ml\-commons: ml\-commons provides a set of common machine learning algorithms, e\.g\. k\-means, or linear regression, to help developers build ML related features within OpenSearch\.](https://github.com/opensearch-project/ml-commons)
[^oepnsearch-ann]: [Approximate search - OpenSearch documentation](https://opensearch.org/docs/latest/search-plugins/knn/approximate-knn/)
[^nima]: [Google AI Blog: Introducing NIMA: Neural Image Assessment](https://ai.googleblog.com/2017/12/introducing-nima-neural-image-assessment.html)
