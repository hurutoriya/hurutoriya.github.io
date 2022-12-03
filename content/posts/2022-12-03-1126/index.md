---
title: "Search Engineering Newsletter vol.12"
date: 2022-12-03T11:26:49+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-01-16/images/1.png"
tags:
  - newsletter
  - search
---

## Search

[情報検索・検索技術 Advent Calendar 2022 \- Adventar](https://adventar.org/calendars/7389)

2021 年に引き続き、検索技術に関するアドベントカレンダーを作成しました。12 月に入ったので、アドベントカレンダー自体始まっていますが、12/14,16 の枠がまだ空いているので興味のある方はぜひご参加ください。現時点で、21 人の方にご参加してもらっています! 感謝!!

- [日本語用オートコンプリートのための Analyzer \| @johtani の日記 3rd](https://blog.johtani.info/blog/2022/08/09/japanese-auto-completion/)
- [ローマ字入力のゆれと読み（JapaneseCompletionAnalyzer その 2） \| @johtani の日記 3rd](https://blog.johtani.info/blog/2022/08/10/jp-auto-completion-2/)
- [マルチテナンシー下での Query Auto Completion 設計・運用戦略 \- LegalOn Technologies Engineering Blog](https://tech.legalforce.co.jp/entry/2020/12/18/134454)

クエリ自動補完(Query Auto Completion) に関する記事。@johtani さんがかなり詳しく解説してくれています。
@mocobeta さんが自分で開発して、そのまま Elasticsearch に[プルリクエストを作ってマージ](https://github.com/elastic/elasticsearch/pull/81858)されているとかかっこよすぎませんか? 日本人のコミッターがいるおかげで、日本語周りの機能が拡充されるの本当にありがたいですね。

[〇〇みたいな検索作ってと言われたときに考えること](https://speakerdeck.com/ryook/thinking-before-developing-search-system-like-that-one)

検索ジャーニーから何が価値がある機能なのかを決めましょうとデータがないとなんにもできないよという非常に大事なお話。

- [ニアリアルタイムで同期される検索基盤を構築 ~AWS Glue によるデータ同期編~ \- コネヒト開発者ブログ](https://tech.connehito.com/entry/2022/08/24/184911)
- [ニアリアルタイムで同期される検索基盤 ~パイプライン構築編~ \- コネヒト開発者ブログ](https://tech.connehito.com/entry/2022/09/16/165655)

@asteriam さんによる検索エンジン内製化に関する記事シリーズ。
AWS 上で、検索基盤を構築しており、AWS の各種サービスをフル活用しており参考になります。

[グーグル、検索で国ごとに最適化　アジア主要国にチーム: 日本経済新聞](https://www.nikkei.com/article/DGKKZO64224640Q2A910C2MM8000/)

> （他国と比べて）日本での検索ワードは簡潔なことが多い

とのことですが、自然言語的に検索してもまともな検索結果が出ないのだから、検索者がそういう傾向があるわけではなく検索者がチューニングしていった結果ではと思ったり。Google 検索は、例えば BERT の適用も英語だと完全に終えているらしいですが、日本語だとどうなっているんだろうか?

[オンラインショップの商品検索改善に挑戦！KDD CUP 2022 で 9 位入賞した手法の紹介 \- ENGINEERING BLOG ドコモ開発者ブログ](https://nttdocomo-developers.jp/entry/2022/08/24/120000)

ドコモの研究者の方が、KDD2022 で開催された Amazon の検索に関するタスクで 9 位に入賞したの解放に関する解説記事。

[Pinterest Boosts Home Feed Engagement 16% With Switch to GPU Acceleration of Recommenders \| NVIDIA Blog](https://blogs.nvidia.com/blog/2022/08/04/pinterest-gpu-acceleration-recommenders/)

MAU4 億人の Pinterest が、ホームフィードに推薦モデルを利用して 16%エンゲージメントを改善した。大規模モデルで推薦を行おうとすると CPU では、コストとレイテンシーが 100 倍近くに跳ね上がるが、GPU に移管して同じコストでレイテンシーは 100 倍高速化することに成功して、大規模モデルの導入が可能になった。

GPU に移行しても、CPU のときと比較してもコストを抑制できたのは驚きました。

[Etsy Engineering \| Faster ML Experimentation at Etsy with Interleaving](https://www.etsy.com/codeascraft/faster-ml-experimentation-at-etsy-with-interleaving)

Etsy での検索の実験の際にインターリービングを導入して高速に実験を行っている。

## Machine Learning & Data Science

[Productionizing ML with workflows at Twitter](https://blog.twitter.com/engineering/en_us/topics/insights/2018/ml-workflows)

2018 年時点での Twitter の機械学習基盤に関する記事。主に AirFlow を使って各種タスクを実行している。

[Sharing learnings about our image cropping algorithm](https://blog.twitter.com/engineering/en_us/topics/insights/2021/sharing-learnings-about-our-image-cropping-algorithm)

2021 年時点での Twitter での画像クロッピングアルゴリズムが、人種間で公平に働いていないことに関する調査。

[情報学研究データリポジトリ メルカリデータセット](https://www.nii.ac.jp/dsc/idr/mercari/)

メルカリが自社のデータを研究用のデータセットとして公開。商品画像は TB くらすというなかなかのスケールです。NII を通じて企業のいろんなデータセットが[公開](https://www.nii.ac.jp/dsc/idr/datalist.html)されていますが、産学をつなげる素晴らしい仕組みだと思います。

[突然注目を集めた AI 画像生成 Midjourey を運営する社員 10 人の「零細企業」の裏側](https://www.axion.zone/aimidjourey10/)

AI 画像生成を提供する Midjourney に関する紹介記事。創業者は[Leap Motion](https://www.ultraleap.com/company/)の
創業者だったのは初めて知った。Big Tech 以外が画像生成モデルをサービスとして現実的に提供可能というのは面白い事例ですよね。

[OpenRAIL: Towards open and responsible AI licensing frameworks](https://huggingface.co/blog/open_rail)

OSS のソフトウェアと同様に、機械学習領域でも公開され責任のある機械学習開発が促進されるようなライセンス Open RAIL を Hugging Face が提案。

[Comments on U\.S\. National AI Research Resource Interim Report](https://huggingface.co/blog/us-national-ai-research-resource)

Hugging Face がホワイトハウスと全米科学財団から、国家的な人工知能ワークフォースをどう立ち上げるべきかについての回答を公開してくれている。

[Pub/Sub launches direct path to BigQuery for streaming analytics \| Google Cloud Blog](https://cloud.google.com/blog/products/data-analytics/pub-sub-launches-direct-path-to-bigquery-for-streaming-analytics)

Pub/Sub から直接 BigQuery にストリーミングで保存できるように。[zero ETL](https://techcrunch.com/2022/11/29/amazon-takes-a-step-towards-a-zero-etl-future-with-two-announcements-at-reinvent/) ともよばれている機能で、クラウドベンダーでないと実現できない旧欲的なデータ連携機能ですね。

またこの zero ETL では、BQ にデータを書き込む代金は無料になり、代金的にもお安くなるらしい。すごくない?

> Better yet, you no longer need to pay for data ingestion into BigQuery when using this new direct method. You only pay for the Pub/Sub you use. Ingestion from Pub/Sub’s BigQuery subscription into BigQuery costs $50/TiB based on read (subscribe throughput) from the subscription.

- [オンプレ ML 基盤 on Kubernetes 〜PFN、ヤフー〜 \#2 \- connpass](https://ml-kubernetes.connpass.com/event/255797/)
  - [オンプレ ML 基盤 on Kubernetes \#2 パネルディスカッション \#ml_kubernetes \| ドクセル](https://www.docswell.com/s/ydnjp/K839L5-2022-08-29-151807)
  - [ヤフーのオンプレ機械学習基盤 AIPF について \#ml_kubernetes \| ドクセル](https://www.docswell.com/s/ydnjp/Z26W1K-2022-08-29-151542)
  - [続・PFN のオンプレ ML 基盤の取り組み / オンプレ ML 基盤 on Kubernetes 〜PFN、ヤフー〜 \#2](https://www.slideshare.net/pfi/pfn-ml-ml-on-kubernetes-pfn-2)

PFN とヤフーさんが合同で開催してくれている k8s 上でのオンプレ機械学習基盤に関する勉強会の第二回目。
ヤフーさんで起きた障害で、街のネットワークが落ちたからサーバーが落ちたと書いてあり、オンプレならではの課題が語られており面白かった。
PFN さんの[第 1 回目の講演](https://tech.preferred.jp/ja/blog/ml-kubernetes-cluster-2022/)の記事はこちらで拝見できます。

- [PyTorch strengthens its governance by joining the Linux Foundation \| PyTorch](https://pytorch.org/blog/PyTorchfoundation/)
- [Welcoming PyTorch to the Linux Foundation \- Linux Foundation](https://www.linuxfoundation.org/blog/blog/welcoming-pytorch-to-the-linux-foundation)

PyTorch が Linux Foundation に参画。これから機械学習活用がますます推進されていく中で、Linux Foundation が牽引することで中立性を重視した開発をおこなっていくとのこと。

Google は TensorFlow とは切っても切れない関係なので、同様の行動は難しそうです。これから、TensorFlow と PyTorch の OSS コミュニティとしての動きは両者とも方向性がかなり異なってきそうです。
PyTorch は現時点で 65000 人に開発者が参加した OSS で歴代でも最も作成した OSS プロジェクトの一つらしく、凄まじい規模になっていますね。

> Meta から Linux Foundation へ “passing us the torch” 松明を渡す

という洒落が最後の文で書かれており、オシャレですね。

---

## 総括

今年から始めた Search Engineering Newsletter ですが、合計 12 本のニュースレターを書くことができました。
vol.10 からよほど面白くない限りは、じっくり精読をするのをやめて速度感を意識して 1 記事 5-10 分を意識して読むようにすると良いペースを保てるようになってきました。
精読に傾倒しすぎて、それが重荷になって記事を読む習慣がなくなるのは避けたいですからね。

そのおかげで 1 時間くらいで 1 ニュースレター書けるようになったので、来年は 2 週間に 1 記事くらいは書きたいですね。でないとキューに記事が入る速度に追いつかない。
現状書いているニュースレターも、現在の時間軸と比べると 4 ヶ月くらい遅れているのでこれを 2 ヶ月以内にはおさめたい。

自分が検索技術に関わっている限りは、良いインプットの習慣として継続していきたいと思っています。

### Supporter さまへの感謝

敬称略: `Yuki` さん, `@sz_dr`さん, `@k-yomo` さんらにこのニュースレターに対して、[buymeacofee](https://www.buymeacoffee.com/hurutoriya) を通じて投げ銭を贈っていただきました。
自分の書いた記事に対して投げ銭をいただくのは初めての体験で、非常に嬉しかったです。
また、Twitter 上でのハッシュタグの感想も励みになっております。

このニュースレターがおそらく今年最後になるかもしれません。
来年もよろしくおねがいします。

## 感想など

Twitter で [#searchengineeringnewsletter](https://twitter.com/hashtag/searchengineeringnewsletter?f=live) のハッシュタグでつぶやいていただくか、[Google フォーム](https://forms.gle/xFgMwRJbeqJxNtfe9) での感想投稿をお待ちしております。

執筆の励みにさせていただきます。

## Search Engineering Newsletter の購読方法

ニュースレターの更新が気になる方は Newsletter が配信される [RSS](https://shunyaueta.com/tags/newsletter/index.xml)を発行しているので、RSS リーダーで記事を管理している方はご登録お願いします。
また、今までのニュースレターの一覧は[こちら](https://shunyaueta.com/tags/newsletter/)から閲覧できます。
