---
title: "2021年を振り返る"
date: 2021-12-29T22:42:08+09:00
lang: ja
author: Shunya Ueta
tags:
  - retrosoective
---

うなすけさんの wakatime を利用した振り返り方が面白かったので、来年は真似したいと思い導入してみた。

[サーバーサイドエンジニアとして 2021 年に使った技術と来年の目標](https://blog.unasuke.com/2021/wrap-up-my-coding/)

なので先週くらいから wakatime を使って、VSCode での利用統計をとってみることにした。

https://wakatime.com/

![wakatimeの統計情報](/posts/2021-12-29/images/1.png)

Markdown が圧倒的に多いのは現在 Markdown で執筆活動をしてるからですね。

仕事をほぼ納めてから導入して執筆しかまともにしてないからこうなってるな。。。
詳細は今はお話できないのですが、再来年くらいには形になっていることを祈る。

## 利用した技術一覧

- Language
  - `New`: Go
    - Backend 開発ではメインで使っている。今までは Python がほぼメインだったが、検索チームに異動したことで Go が必要不可欠になったので頑張って習得中。久々に新しい言語に触れるけど新鮮な気持ち。明確に型があると、エディタがガンガンサジェストしてくれて楽しい。間違ってるとすぐ知らせてくれる。Go も Python までのレベルまで引き上げて書けるようにしておきたい所存。
  - `New`: Java (code reading)
    - 主に Apache Lucene と Apache Beam の code reading をしていたのがメイン。同僚からは VSCode ではなく、IntelliJ IDEA 入れたほうがめちゃくちゃ捗るよと言われつつもまだ使いこなせていない...。Lucene, Solr, Elasticsearch のどれかに来年は contribute してみたい。
  - Python
    - Google BigQuery と組み合わせたデータ分析や可視化、Airflow で利用。あとは機械学習サービスの改修でも書いていた。なんだかんだ手に馴染んでいるのがやはり Python で、2022 年は一段階上のコードを書けるようになりたい。1/4 ほど読んで積ん読になってしまっている [Fluent Python](https://amzn.to/3HlAHS5) を読みきらないと...
  - StandardSQL
    - Google BigQuery でお世話になっている。まだまだ「え、こんな便利関数あったんだ」となる。ちょっとした前処理は BQ に投げたほうが遥かに効率が良いので、BQ→Python で何をどこまでやるかはバランス感覚がやはり大事。
- Software
  - `New`: Apache Beam
    - Java は code reading, Python は自分で入門がてら形態素解析する Beam model を書いていた。Apache Beam Go SDK が GA になったので、なにか作りたい。原著論文も勉強会で今度話したいな。ストリーミングで処理を行いたい際には、選択肢の第一候補に入るソフトウェアかつ動いている仕組みがめちゃくちゃおもしろいので、もっと深堀りして書いていきたい。
  - `New`: Apache Airflow (CloudComposer)
    - GCP の各サービスを組み合わせてゴニョゴニョしたいときにものすごく楽。なれるまではデバッグが辛かった。そんなにこなれたことやっていなかったとしても、ピタゴラスイッチ的なデバッグが必要になることが多いので、最初は辛かったけど、慣れたらめっちゃ便利。
  - `New`: Apache Lucene
    - 社内の code readning 勉強会で、近似近傍探索のロジックを眺めていた。
    - [Amazon が e コマース検索を Lucene により、どうスケールさせているか at Berlin Buzzwords 2019](/posts/2021-11-26/) の記事でも Lucene 自体の特性を表層的に理解できてスゲーッ! となれたが、コードの中身まで理解して使いこなしたい。[Lucene in Action (English Edition) 2nd edition](https://amzn.to/3EFzl2I) はぜひとも読みたい
  - `New`: Apache Solr
    - [Apache Solr 入門 ―オープンソース全文検索エンジン](https://amzn.to/3FB5lGF) を時間を見つけて読んでいるが、それに関連して書いたりしている。検索エンジンの体系だった日本語書籍の代表的な本だと思う。凄く良い本。Elasticsearch と比べて HTTP2 に対応していたりして、良い意味で競合の関係性。
  - `New`: Cloud Dataflow
    - Apache Beam のエンジン。Dataflow Prime や GPU 機能などが利用可能になったりと進化が激しいけどまだ全然使えていない。BigQuery では不可能な形態素解析やちょっと込み入った前処理をしたいときは Beam (on Dataflow)が役立つのではと思っており、興味が高まっている。手が足りていない....
  - Google BigQuery
    - Google BigQuery がないと自分の今の業務は成り立たない疑惑が... 来年もよろしくおねがいします。
  - `New`: Google BigTable
    - 特にハマりどころはなく素直に使えた。スケーラビリティが素晴らしいのでパフォーマンス面を気にすることなく使えるのは最高。
  - `New`: Elasticsearch
    - Query 書いてゴニョゴニョしてたりして、Solr, Lucene と同じく表層的に使っているだけなので使い込みたい。
  - `New`: Streamlit
    - 業務で内製アプリで GUI をさっと提供したいときにめっちゃ便利。同じような目的の Plotly Dash を 2 年ほど前に使ったけど、それと比較してもライフサイクルと UI の抽象化が素晴らしい。でもやれることは限られているので、それを割り切って使うのが吉。
- CI
  - `New`GitHub Actions
    - Blog の CI・CD で Travis から GitHub Actions に移行したけど、GitHub 内で全て完結するというのは素晴らしい。
  - CircleCI
    - CircleCI は便利なんだけど、CI のピタゴラスイッチを回すための CLI スキルが足りないなと思う面が多々あった。
- Middleware/Infrastructure
  - GCP
  - Kubernetes
    - 2020 年に比べるとお触りレベルを脱却してマニフェストを自分で書いて Pod をデプロイしたりしていた。理解が浅い点でトラップ(自業自得)に引っかかり、時間を溶かすことが多々あり反省。
  - terraform
    - 開発環境と本番環境の剥離をなくして、スムーズにデプロイするにはやはり IaC って必須だなと思えた一年。初期の手探りのときは GUI ポチポチで作りたくなるが結局急がば回れだった。
- Editor
  - VSCode
- Tool
  - toggl
    - 可能な限り作業時間を計測するようにしてみた。作業自体が計測されていると認識することで、時間を意識して作業ができる気がする。
  - Joplin (notion から移行)
    - Notion から OSS のメモアプリの [Joplin](https://joplinapp.org/) に乗り換えた。全てを自分が管理できているというのはやはり良い体験。一日の作業メモ、やること一覧も全て joplin にログとして残すようにしてみたところ、結果的に作業が捗るようになった。VSCode の拡張で、Joplin を編集できるんだけどこれも便利。

## 目標振り返り

今年決めた目標の振り返り

[2021 年の目標](/posts/2021-11-26/)

- Senior Software Engineer として確固たる実力を身につけることに集中
  - `30%`: このままの立ち位置は不味いなと思い検索エンジニアに慣れたのは非常に良かった。が、Software Enginner としての層の厚みを体感できたので 30%とした。へこたれず研鑽していきたい。
- 英語にふれることを習慣化
  - `5%`: Elsa をやったりやらなかったりで全く習慣化できていない。喋ったり書いたりしているときに、基礎ができていないことを痛感するので、知り合いから教えてもらった英語の教科書とかやはりやるべきかなと思っている。3 ヶ月とかのスパンで振り返ってないからグダグダになってしまっているので、来年はちゃんと中期的なスパンで振り替えれるようにしよう。発音矯正としては Elsa は凄く良い。自分の耳で全く sin, thin の違いがわかっていないことに絶望
- SNS を断ち自分にとって後悔の無い時間を歩む
  - `60%`: Android に[Stay Focused](https://play.google.com/store/apps/details?id=com.stayfocused)を入れて、SNS にそもそもアクセスできないようにした。このおかげで RSS, Pocket の消化がとても進んだ。来年も引き続き SNS 断ちを継続。時間が溶けてしまうので、連絡・告知手段としてのみ使うことにする。

今年はグダグダな気がしているので、来年は胸を張ってあぁ、自分頑張ったなと言える一年にしたい。
