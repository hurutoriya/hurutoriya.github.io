---
title: "MLOps の国際会議 OpML'20 に論文が採択されたので登壇してきた"
date: 2020-09-06T23:31:03+09:00
author: Shunya Ueta
lang: ja
tags:
- mlops
- machinelearning
- event
---

MLOpsの査読付き国際会議 [2020 USENIX Conference on Operational Machine Learning](https://www.usenix.org/conference/opml20) (略称 OpML'20)に論文が採択されたので、登壇してきた。

Podcastでも紹介しました

[#1 MLOps の国際会議 OpML20 について at just4fun.fm](https://anchor.fm/hurutoriya/episodes/1-MLOps--OpML20-ek0nr3/a-a58em8)

## MLOpsの査読付き国際会議とOpMLの立ち位置

機械学習エンジニアリング・MLOpsの領域の会議でも一番有名なものとして2018年に発足した[MLSys](https://mlsys.org/)があります。(ちなみに最初はSysMLという名前でした)
このカンファレンスの傾向としては、アカデミアの研究者主体の発足経緯からアカデミアからインダストリーへの橋渡し的立ち位置となっています。具体的には、発表者はアカデミアの方が大半でハードウェアから、モデルのOSS公開など幅広く機械学習エンジニアリング・MLOpsの周辺トピックをカバーしています。

OpMLはその一年後に、MLOpsを軸にした[USENIX](https://www.usenix.org/)が母体の会議として誕生しました。
USENIXはSRECON、OSDIなどを開催している団体です。学会的なスタイルに則り、先端的な計算機システムの成果を論文として公開されています。MLSysと対称的にこちらはインダストリーからアカデミアへの橋渡し的立ち位置となっています。発表内容は企業での発表者が多く、実際の運用で得られた各企業のMLOpsのベストプラクティスなどがメインで話されています。
個人的にはOpMLのほうが、MLOpsのど真ん中を主体に置いているのでMLSysよりも盛り上がってほしいなと思っています。

OpML'19がどのような様子だったかは、以下の記事がわかりやすいです。

- [OpML ‘19参加レポート](https://medium.com/nttlabs/opml19-75e85c3384f7)
- [The first conference of Operational Machine Learning: OpML ‘19](https://blog.chezo.uno/the-first-conference-of-operational-machine-learning-opml-19-308baad36108?gi=33c290c07226)

自分自身、機械学習エンジニアリングやMLOps周りのカンファレンス情報などを追いかけていますが、この分野で査読付きかつ論文として残せる形式の国際会議は主に上記の２つの認識です。

KDDやCOLING、NAACLなどの国際会議でもインダストリートラックが常設されるようになって久しいですが、最近ではインダストリートラックだけではなく、積極的に実応用前提のワークショップ([ECNLP at ACL2020](https://sites.google.com/view/ecnlp/acl-2020), [IRS2020 at KDD2020](https://irsworkshop.github.io/2020/index.html)など)が開催されており機械学習の理論と実応用の融合が進んでいます。

## OpML'20への投稿と採択で得られたもの

OpML'20では下記２つの発表枠があり、投稿者がどちらかを選んで発表を行います。

- 査読付きで20mの口頭発表
- 2ページの査読付き論文+20mの口頭発表

OpML20で[推奨されるトピック](https://www.usenix.org/conference/opml20/call-for-participation)でも、自分たちが持っているネタで

> New model introduction into production (e.g., staging, A/B test)

においてNoveltyがあると考えて、ここからストーリーを組み立てていきました。

スケジュール感として投稿締切が2020/02/25で、その1ヶ月前の1月末から毎日1時間、Google Calendarで時間を抑えて同僚と集中的に論文の執筆を行いました。
最初にガッと3ページほど書いて、その後洗練させて2ページに圧縮して投稿しました。
あらめて添削や執筆をともに行ってくれた同僚たちに感謝します。

そして投稿の1ヶ月後に通知メールが来て採択を知りました。
添削を何度も繰り返して時間が迫るなかなんとか投稿できたという状態で、とりあえず投稿できて良かったなと感じていた最中だったので、採択通知が来て本当におどきました。

査読システムの良い点として、自分たちの投稿内容がその会議で発表足り得るものかがレビュアーからレビューされることです。
自分自身機械学習エンジニアとして働いていますが、その成果が査読を通して同じ分野で働いているエキスパートの第三者に認められたという事実が自分の仕事への自信に繋がりました。

その後Reviwerの方に指摘された点を意識しつつ修正を行って、Camera Readyを無事に提出しました。
また今回は急遽オンライン開催へと変更されたので、動画投稿も必須になり初めての収録もなかなか難産でしたが無事提出することができました。

### OpML'20で採択された論文

採択された内容は以下のページにまとまっているので、もしご興味があればご覧ください。
内容を簡単にまとめると、

- C2Cでの投稿内容監視で機械学習を導入
- Human In The Loopと組み合わせたバックテストにより、リリース時の機械学習モデルの劣化を事前防止
- 不均衡なデータ分布を考慮したモデルリリース後の新たなA/B テスト手法の考案による、意思決定の高速化

です。

[![Auto Content Moderation in C2C e-Commerce](/posts/2020-09-06/images/1.png)]((https://www.usenix.org/conference/opml20/presentation/ueta))

[Auto Content Moderation in C2C e-Commerce](https://www.usenix.org/conference/opml20/presentation/ueta)

[講演動画-Youtube](https://youtu.be/_rvEcH_zyt4)

当日はオンライン開催で、発表内容は事前にYouTubeで公開され、その後Slack上でリアルタイムに発表者に質問ができる Ask Me Anything (AMA)セッションが開催されました。
また、今回はオンライン開催になった影響で参加費は無料となりました。
AMAセッションでChairの方がファシリテーターとなり、予想以上に活発な議論が生み出され驚きました。

オンライン開催になり、発表内容はすべてYouTubeで公開され、アメリカへの渡航の必要がなくなり気軽に参加できるのは非常に良い流れだと思いました。

一方で、日本からの参加だと深夜01:00-02:30の参加だったのでその点のみ非常に辛かったです。
懇親会などの偶発性を持った出会いなどはオンラインだとやはり、難しく感じました。

## 面白かった OpML'20 の発表まとめ

OpML'20の発表一覧はこちらから確認できます。

- [OpML'20 Conference Program](https://www.usenix.org/conference/opml20/conference-program)

ここから面白かった発表を抜粋して紹介させていただきます。

_[Twitterでもまとめていた](https://twitter.com/i/events/1292673505356476417?s=20)のですが、記録のために分散させておきたいのでこちらでも記載しておきます_

### Runway - Model Lifecycle Management at Netflix

- https://www.usenix.org/conference/opml20/presentation/cepoi


![Runway](/posts/2020-09-06/images/2.png)

RunwayというNetflixでのモデルのライフサイクルマネジメントツールの紹介
NetFlixで実際にあった課題

- モデルを誰が作ったか、現在どんなモデルがあるのか、特徴量、変換、データはどんなものが使われているか
- モデルのリリース、検証、モニタリングやアラートが標準化されていない
- 計算機資源の無駄遣いなど

上記の課題を解決するためにRunwayが作成された。

- Runwayは現状A/Bテストやカナリーテストは提供できていない
- integration 周りは Jenkinsを使って実現している

k8s を明示的に言及していないってことは多分使っていなさそうではある。
計画段階だが、Netflixで開発している機械学習のワークフローエンジン[METAFLOW](https://metaflow.org/)とRunwayのインテグレーションも視野に入れてるらしい。

一つの会社でこんだけ機械学習社内ツールが乱立してるのは競争力が非常に高いと感じた

データリネージなどの[質問もされている](https://usenix-opml.slack.com/archives/C017CGC75PF/p1596040793061000)

ガバナンスまわりを考えると、大企業だとデータリネージの必要性も最近わかるようになってきた。

### More Data Science, Less Engineering: A Netflix Original

- https://www.usenix.org/conference/opml20/presentation/goyal
 
![MetaFlow](/posts/2020-09-06/images/3.png)

MLOPs NYCで公開されたMetaFlowの話。
スライドでのData Scientistの苦悩を描いたイラストが秀逸で面白かったです。

METAFLOWのData Scientstのスキルを最大限に活かす思想は非常に共感できるので、どんどん発展してほしいです。

最近ではRにも対応して驚きましたが、METAFLOWの思想である`More Data Science, Less Engineering: A Netflix Original`に基づいていて非常に的確な対応ですね・

### inside NVIDIA’s AI Infrastructure for Self-driving Cars

- https://www.usenix.org/conference/opml20/presentation/farabet

![NVIDIA SELF DRIVING](/posts/2020-09-06/images/5.png)

- 自動運転のためにデータの収集からモデルのデプロイ・シミュレーションまで一気通貫で開発
- 実世界でのGround Truthを考える
  - 多種多様なデータ(LIDAR, Sensor, GPS. etc.)
  - 100種類以上の外的なシグナルの活用

![NVIDIA SELF DRIVING](/posts/2020-09-06/images/6.png)

スケールするデプロイのための、データの生成から、モデルの学習→モデルの監査からシミュレーション・ハードウェアでのshadow patch を終えて、Prodにデプロイする流れ

![NVIDIA SELF DRIVING](/posts/2020-09-06/images/7.png)

### Automating Operations with ML

- https://www.usenix.org/conference/opml20/presentation/underwood

- オペレーションでの機械学習活用についてGoogle によるセッション
- ほとんどの場合、機械学習の維持コストのほうが実際のインパクトより高い
- 単純なヒューリスティックは柔軟性に欠けるが機械学習と同等に役に立つ

発表者のToddさんは他にもSRECON2019に
All of Our ML Ideas Are Bad (and We Should Feel Bad)
となかなか刺激的なタイトルで、SREの分野で機械学習の実応用はなかなかうまくいなかったぜと共有している...

### How ML Breaks: A Decade of Outages for One Large ML Pipeline

- https://www.usenix.org/conference/opml20/presentation/papasian

![Google ML Breaks](/posts/2020-09-06/images/8.png)

日本語に訳すと、
機械学習システムの壊れ方:15年以上経過したMLパイプラインがどのようにしてぶっ壊れてきたか

モデルの前提として

- 15年以上まえから開発された機械学習パイプライン
- 10年以上前からポストモーメンタムが行われている
- 定期的に1時間かけてモデルを新規データで学習
- 新モデルは学習後即、CDされる

![Google ML Breaks](/posts/2020-09-06/images/9.png)

- 失敗の要因を19種類にまとめた。オーケストレーションの失敗、CPU不足などなど

![Google ML Breaks](/posts/2020-09-06/images/10.png)

***

個人的には

- NVIDIAの inside NVIDIA’s AI Infrastructure for Self-driving Cars
- Googleの How ML Breaks: A Decade of Outages for One Large ML Pipeline

が骨太で非常に面白い発表でした

MLOpsという言葉が誕生して久しいですが、機械学習システムの開発と運用に置いて、何をやるべきなのかが構造化されてきています。

書籍では、日本語で読める良書として、[仕事ではじめる機械学習](https://amzn.to/331unNb)
や最近では、Googlerの方がオライリーで出版予定の[Machine Learning Design Patterns](https://www.oreilly.com/library/view/machine-learning-design/9781098115777/)
など非常に充実しています。

これからも、機械学習と現実世界の橋渡しとしてこの領域はどんどん掘り進められていくと思います。

MLOpsはデータの活用を前提にしたシステム開発というとてもエキサイティングです。

もしOpMLの発表が面白いと感じた方は、来年のOpML21の口頭発表にも申し込んでみてはいかがでしょうか?
