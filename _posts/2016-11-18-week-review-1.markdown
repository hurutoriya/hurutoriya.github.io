---
layout: post
title:  "Week in Review 1 : 週報、研究や開発関連をまとめる"
date:   2016-11-18
tag: research
---

まえがき

[加藤大晴さんのウェブサイト](http://hiroharu-kato.com/note/)の進捗報告を見ていたら、良い習慣だなと思ったので真似をしてみることにした。

***
## 週報
- 最近自分で実装したパッケージを再利用しやすいように、パッケージ化を行ったりと実験の手間を減らすようにしている。自分は主にPythonやMATLABを使用しているんだけど、MATLABはお作法がよく分からなかったりするので、研究などで公開されているリポジトリを参考にして設計するのが一番良い。コールドリーディング大事。

- 論文の再現実験した際には、Githubで公開することにした。解説記事をBlogに書く。
    - Fast Normalized Cut with Linear Constraints(CVPR2009)を実装した。単純な行列の制約付き固有ベクトルを求めることはできた。(しかし、、チューニングを終えていないので、画像領域分割はまだうまく行かない 😧
        -  [hurutoriya/fast_ncut](https://github.com/hurutoriya/fast_ncut)
- 先生と毎週進捗報告を行っている。週ごとに別の〆切があったりすると以前までは報告資料の完成度にムラがあって、ロスが多い打ち合わせになってしまった時があってどうにかしたい!
    - そのために、とても役に立ったのが以下の本`できる研究者の論文精算術`。一週間のこの時間は進捗報告書を書くための時間帯にする(e.g. 毎週木曜 09:00-12:00)という予定を予め組み込み事で問題が解消された。

<a href="http://www.amazon.co.jp/exec/obidos/ASIN/4061531530/hurutori-22/ref=nosim/" name="amazletlink" target="_blank"><img src="http://ecx.images-amazon.com/images/I/51VV0bYjkpL._SL160_.jpg" alt="できる研究者の論文生産術 どうすれば「たくさん」書けるのか (KS科学一般書)" style="border: none;" /></a>

- 勉強会を開催していないので、11月中には開催したい。

後は、研究で役立つ記事があったとしても死蔵してしまうことがあるので、コメントを付けつつまとめます。

***

### News
- [Netflix at RecSys 2016 - Recap](http://techblog.netflix.com/2016/10/netflix-at-recsys-2016-recap.html)
    - RecSys2016 でNetflixが発表した資料のまとめ。
- [Clustering Key Terms, Explained](http://www.kdnuggets.com/2016/10/clustering-key-terms-explained.html)
    - クラスタリングの各種テクニックが纏められてる。
- [一瞬でラフ画を線画に！ 開発した早稲田大学にグラフィックス研究の未来について聞いてみた‐前編‐](https://ichi-up.net/2016/157)
    - 最先端の研究を行っているグループと一般の人達の境界が薄くなってきて協力し合える世界っていいですね。
- [CMU教授直伝の論文の書き方](http://yamaguchiyuto.hatenablog.com/entry/2016/01/18/154613)
    - 産総研にいる山口 祐人さんのBlog記事。有力な情報が沢山掲載されていて非常にありがたい。
- [少しでも研究に興味がある人，面白いテーマを探している人は「研究に必要なたったN個の事」とかいう記事を読まずに今すぐに"How to do good research, get it published in SIGKDD and get it cited!"を読むべき ](http://d.hatena.ne.jp/repose/20111102/1320167262)
    - 分野間の違いはあるけど、その領域で何が意味があるのかを指し示してくれるのってとてもありがたい。ネットで探すと`SIGKDD`が`CVPR`,`ICML`などに置き換わったものがたくさんある。
- [畳み込みニューラルネットワークの仕組み](http://postd.cc/how-do-convolutional-neural-networks-work/?1479446220158=1)
- [覚えるだけでPythonのコードが少し綺麗になる頻出イディオム](http://hachibeechan.hateblo.jp/entry/Python-idiom-101)
- [グーグル・ディープマインド、大量データ不要の深層学習システムを開発](https://www.technologyreview.jp/s/12759/machines-can-now-recognize-something-after-seeing-it-once/)
- [深層学習は 世界をどのように変えられるのか ](http://www.slideshare.net/pfi/ibis2016okanohara-69230358)
    - 岡野原さんのIBIS2016での発表資料。
