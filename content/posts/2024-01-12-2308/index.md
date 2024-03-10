---
title: "検索エンジンOSS勉強会: Lucene や OpenSearch など検索エンジンOSSへの貢献を念頭にしたオンライン勉強会を立ち上げてみた"
date: 2024-01-12T23:08:34+09:00
lang: ja
author: Shunya Ueta
tags:
  - search
  - oss
  - community
  - organizer
  - 検索エンジンOSS勉強会
---

タイトルのとおりですが、検索エンジン OSS 勉強会 という Lucene や OpenSearch などの検索エンジン OSS への貢献を念頭にした勉強会を立ち上げてみました。
といっても今はまだ試運転の段階で、2 月くらいから定常開催していければなぁと思っています。

以下に勉強会の初期の草稿を書いておきます。
最新版は参加者の方と議論を行う DesignDocs を目指して Google Docs で管理しており、ちょこちょこ更新しています。
興味を持ってくれた方からの意見を以下の Google Docs でコメントを頂いて改善して言っています。また、勉強会に興味のある方は、Google Docs 内の Discord リンクからご参加ください。興味のある方なら誰でも歓迎です。

[Google Docs: 検索エンジン OSS 勉強会 ガイドライン](https://docs.google.com/document/d/13UC8xhI67qIiNZCRH8fEjRPi5fmeuivJ3-s2Ke_U0CE/edit)

初期はスパム対策を考慮して DM で Google Docs のリンクを共有していたが、嬉しいことに 10 人ほどの方から参加がしたいと X でお声がけ頂いた。
そして、毎回 DM を手動で送るのはメンドクサイのとスケールしないと気がついたので、いっそのこと公開状態でいいなと思ったので、完全公開にしてみました。

なぜ、草案をそのままブログ記事にコピペしているかというと、この記事が検索エンジンにヒットして参加者が増えたらいいなという目論見です。
X(Twitter)以外で潜在層にリーチする方法が欲しいですね。。。 今のところは、X 以外だと検索技術者勉強会の Slack でアナウンスして、数人の方が参加してくれました。

---

## このドキュメントについて

検索エンジン OSS 勉強会の方向性を決めるための草案です。決定事項ではありませんので、ガシガシ気軽にフィードバック頂けると幸いです。

著者: [hurutoriya](https://shunyaueta.com/about/)

## 勉強会概要

- Lucene や OpenSearch などの検索エンジン OSS への貢献を念頭にして、まずはコードリーディングして理解を深める。
  - 例えばマージされた PR などを理解して解説記事を書いて、発表
    - https://github.com/apache/lucene/issues?q=is%3Aissue+is%3Aclosed
    - https://github.com/opensearch-project/OpenSearch/pulls?q=is%3Apr+is%3Aclosed
    - 著者は、Apache Lucene, OpenSearch, Apache Beam などに興味がある。
- 開催場所は Discord で行う。(招待リンクは Google Docs を参照してください)
  - 専用の行動規範は作成していませんが、みんなが気持ちよく活動できるようにしてください。参考
    - https://www.ubuntulinux.jp/community/conduct
- 開催結果や議論などは極力透明性を持って公開していく。
  - OSS への間接的貢献
- コードへの理解が進んで機運があればガンガン PR を作る。
  - OSS への直接的貢献

### 開催背景

Apache Lucene, OpenSearch, Apache Beam などの OSS への貢献を今年の目標にしてみた。だが、既存のチケットを眺めても初心者がとっかかるには敷居が高い....

[I Became a Solr Committer in 4662 Days\. Here's how you can do it faster\! \- OpenSource Connections](https://opensourceconnections.com/blog/2020/07/10/i-became-a-solr-committer-in-4662-days-heres-how-you-can-do-it-faster/) という記事でどのように Solr のコミッターになったのかが説明されており参考になりました。

その一つが

> Start by learning the culture of the project. How are decisions made? What tools do people use? What do the various acronyms mean? Join the mailing lists and read every commit.

で「すべてのコミットを読め」です。
なるほどこれは目からウロコでその通りだなと思いました。

また、自分単体でやるのもいいんですが、ゆるふわな勉強会形式でやっていくとモチベーションも良い感じに継続できるかつ同志と巡り合えたらなという魂胆もあります。

結論: ゆるいけど、価値のある議論ができる場を目指していきたいなと思っています。

## 形式

- オンライン
  - 発起人の自分が育児の関係で基本的に夜間かつ外に出ることは難しいので柔軟に対応できるオンラインにしたい。
  - Slack, Discord で考えてみたが、無料枠だと Discord のほうが画面共有やボイスチャットなど機能面で有利な点が多いので Discord で試験的に行ってみる
    - Google Meet, Zoom など様々なツールを組み合わせて運用するのはメンドクサイ
    - 友人から Didscord でのオンライン勉強会は最高ですよと教えてくれたのがきっかけ https://twitter.com/tarunon/status/1745419854252003328
- 発表は持ち回り形式には、あえてしない
  - 好みがあると思いますが、こっちのほうが自分は好ましいなと思っています。理由としては順番が回ってきたが本業やプライベートの都合で結局スキップせざるを得ない、それが連続で続いていくというのはモチベーションが下がりやすい(という経験を持っています)
  - そのため発表できる人がいれば開催という形式にする。
- 発表のコスト自体を重くしすぎない
  - コストが重くなると腰が重くなり、そのままエターなります(そのまま停止)。
  - どうせ発表するなら長大なトピックにしようと考えなくても OK です。気軽に持続性を持って続けていくのが現在の史上目標です。
  - また、発表形式はスライドや Markdown など限定はしません。
