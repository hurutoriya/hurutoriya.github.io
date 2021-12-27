---
title: "2021年05月時点で自分が実践しているMLOpsの情報収集方法"
date: 2021-05-29T22:32:58+09:00
lang: ja
author: Shunya Ueta
tags:
  - mlops
  - machinelearning
---

先日、同僚に「機械学習プロジェクトに興味があるんだけど、おすすめの資料があったら教えてほしい」と言われたので、Blog 記事に現時点でのおすすめの資料としてまとめておいたら、数年後見返したら面白そうだと思ったので記事として公開しておく。

## おすすめの資料

### プロジェクトマネジメントや考え方、思想

- [How Google does Machine Learning](https://www.coursera.org/learn/google-machine-learning)
  - これは機械学習を実応用する人たちにはぜひ見てほしいビデオ講義。前半が、機械学習プロジェクトの計画や、優先順位、よくあるアンチパターンについて GCP で機械学習について多く関わってきたエンジニアが解説してくれていて、非常に勉強になる。 [感想記事](https://shunyaueta.com/posts/2020-04-18/)
- [リーン・スタートアップ　ムダのない起業プロセスでイノベーションを生みだす](https://amzn.to/3yJru2u)
  - 顧客が求めるものを作ろう。機械学習にこだわったらまずだめなので... (詳しくは後述の Rules of ML を呼んでみよう。)
  - 関連する良いフレームワークとして @nishio さんの[機械学習キャンバス](https://www.slideshare.net/nishio/01-68382174) もおすすめです。
- [Make something people want. by Paul Graham](http://www.paulgraham.com/good.html)
  - 人によって意見が別れるところではありますが、機械学習エンジニアとして、これがなぜ機械学習で必要なのかの「なぜ」を説明できないとたいてい上手く行かない経験がある。つまるところ、必要とされるものを見つけ出して作っていこうぜということですね
- [Netflix がカスタマーを誰よりも理解するためのデータ分析プロセス、コンシューマー・サイエンスの紹介](https://qiita.com/KanNishida/items/12f9ae0cee98fd54b0bb)
  - カスタマーオブセッションの考え方を、常に心のなかに秘めつつ世の中を良くするプロダクトを作りたい

### MLOps, 機械学習エンジニアリング

- [Rules of Machine Learning](https://developers.google.com/machine-learning/guides/rules-of-ml)
  - 全員これを毎日読もう。聖書
- [仕事ではじめる機械学習 第 2 版](https://amzn.to/3yMQhCY)
  - [MLCT](https://mlct.connpass.com/) 創始者の @chezou さんが筆頭に書き上げた実践的な機械学習本。日本人で機械学習をやりたいならまずこれを買うべし。
- [AI アルゴリズムマーケティング 自動化のための機械学習/経済モデル、ベス トプラクティス、アーキテクチャ](https://amzn.to/3wNgYpj)
  - 邦訳だとべらぼうに怪しい感じになってしまっているが、内容はとんでもなく素晴らしい。マーケティングのために機械学習を適用することが多いと思うが、かなり網羅的に適用例を解説してくれている。原著の英語は無料なので、中身が気になる人は[そちら](https://algorithmic-marketing.online/)をおすすめする。無料公開偉大すぎる
- [MLOps: 機械学習における継続的デリバリーと自動化のパイプライン](https://cloud.google.com/architecture/mlops-continuous-delivery-and-automation-pipelines-in-machine-learning)
  - GCP による MLOps の解説。人によって、MLOps の定義って差異がありますが、自分はここで語られている `ML システム構築のすべてのステップで自動化とモニタリングを推進できます` こそが、 MLOps の骨子だなと思っています。クラウドサービスは、開発に関係する知識をパターン化して、資料を公開してくれるのでありがたいですね。
- [Google Cloud で機械学習を実装するためのベスト プラクティス](https://cloud.google.com/architecture/ml-on-gcp-best-practices?hl=ja)
  - この資料なんかは、GCP で機械学習を実践したい場合にはまず見ておけば困ることはなさそうですね
- 各クラウドサービスの MLOps の white paper
  - AWS, Azure は普段使わないので深く言及しませんが、同様の資料は公開されたりしています。
    - [Practitioner Guide to MLOps by GCP](https://cloud.google.com/resources/mlops-whitepaper?hl=ja)
    - [MLOps: Continuous Delivery for Machine Learning on AWS](https://d1.awsstatic.com/whitepapers/mlops-continuous-delivery-machine-learning-on-aws.pdf)
    - [Azure Best practices for MLOps - DevOps for machine learning.](https://azure.microsoft.com/en-us/resources/mlops-infographic/)

[Machine Learning Engineering for Production (MLOps)](https://www.coursera.org/specializations/machine-learning-engineering-for-production-mlops) も気になっているが、手を出せていないのでまた受講が完了したら感想を書きたい。Andrew 先生の講義はハズレはないので非常に期待している。

### 論文

- [eugeneyan/applied-ml](https://github.com/eugeneyan/applied-ml)
  - @euganeyan さんがまとめてくれている、機械学習の応用例をまとめてくれているリポジトリ。事例を探したいならまずここを見れば間違いない
- [The ML Test Score: A Rubric for ML Production Readiness and Technical Debt Reduction](https://research.google/pubs/pub46555/)
  - 機械学習システムの完成度を点数化できて、どの部分を改善していけばいいか明瞭にしてくれます。一度プロダクションにリリース後に、チームでスコアを計算してみて、次に何を改善するのか議論すると楽しいです。 [日本語での抄訳](https://shunyaueta.com/posts/2020-04-25/)

## 情報収集源

### RSS (+Twitter)

- [Amazon Science](https://www.amazon.science/)
- [Google AI](https://ai.google/)
- [TensorFlow blog](https://blog.tensorflow.org/)

なんかの RSS を登録しています。なんだかんだ RSS 便利なので最近回帰している。Twitter でしか得られない情報もあったりはしますが、特定のリストを使って監視してます。Nuzzle を愛用していたが、なくなってしまったで復活してほしい。

### Conference tutorial, workshop

### Academic

- [KDD Applied Data Science Track Papers](https://kdd.org/kdd2021/calls/view/call-for-applied-data-science-track-papers)
  - 世界最高峰の機械学習の実応用例の論文が集まる KDD の ADS track。毎年論文が公開されるのが楽しみ。RecSys や SIGIR など、自分の専門分野に合わせた論文を呼んでおくと楽しいです。[神嶌先生の ML, DM, and AI Conference Map](https://www.kamishima.net/archive/MLDMAImap.pdf)を参考にどんな国際会議があるかを調べてみるといいかもしれません。
- [ECNLP 2](https://sites.google.com/view/ecnlp/www-2020) , [SIGIR eCo](https://sigir-ecom.github.io/)
  - 近年だと E Commerce など実世界への適用を主題にしたワークショップがアカデミックな会議でも開催されていて、非常にいい流れだと思う。

少し前だと、[Reliable Machine Learning in the Wild](https://sites.google.com/site/wildml2017icml/), [Workshop on ML Systems](http://learningsys.org/nips17/acceptedpapers.html), [Reliable Machine Learning in the Wild](https://sites.google.com/site/wildml2016nips/) のワークショップも面白かった。

#### Industrial

- [MLSys](https://mlsys.org/)
  - 機械学習の実応用をテーマにして査読付き学会
- [OpML](https://www.usenix.org/conference/opml20)
  - 機械学習の実運用をテーマにした査読付き学会。MLSys よりも実践論がテーマになっている。2021 年は開催されないみたいで悲しい。2021 年は SRECON21 で[OpML Track](https://www.usenix.org/conference/srecon21/call-for-participation) が開催されていた。来年は OpML が単独カンファレンスとして復活してほしい。
- [MLconf](https://mlconf.com/)
  - 海外の機械学習実践の第一人者の人たちが自社事例を惜しげもなく公開してくれているいいカンファレンス。
- [TWIMLcon](https://twimlcon.com/)
  - TWIML podcast を主催している Sam さんが開催している、機械学習事例のカンファレンス。有料だが、Sam さんのおそろべきネットワークにより、有料にする価値は間違いなくあるカンファレンスとなっている

### Podcast

- [twiml](https://twimlai.com/)
  - ゲストがかなり豪華で、理論から実践まで幅広くトピックを取り扱っている。M.J. 先生や Alex smola 先生がゲストとして着てるのは驚くしかない。。
- [MLOps.community](https://anchor.fm/mlops/)
  - こちらは、実践的な麺をメインにした Podcast。D Sculley さんがゲストとしてきていた、[The Godfather Of MLOps](https://anchor.fm/mlops/episodes/The-Godfather-Of-MLOps--D-Scully--MLOps-Coffee-Sessions-32-eskt3q) は神回なのでおすすめ。

読んだ記事は [はてぶでまとめている](https://b.hatena.ne.jp/hurutoriya/AppliedML/)ので、興味のある方はフォローすると役立つかもしれません。Twitter のほうにもはてぶと連携して放流しているので、そちらの[フォロー](https://twitter.com/hurutoriya)も是非。
