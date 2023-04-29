---
title: "Human-in-the-Loop を題材にした機械学習の勉強会を開催した"
date: 2022-03-31T00:30:50+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-03-31/images/1.png"
  caption: "Machine Learning Casual Talks 13回目を開催"
tags:
  - machinelearning
  - event
  - organizer
  - mlct
---

先日の記事で告知した[^hitl]のですが、昨夜、「Human In The Loop」を題材にした勉強会を開催してきました。

実際に Human In The Loop を扱った MLOps の論文[^opml21] を過去に書いているくらい興味のある分野なので、この領域を盛り上げていくために開催できてよかった。

オンライン勉強会でしたので、配信動画を Youtube で公開しております。
Human In The Loop に興味のある方はぜひご覧ください。

[Machine Learning Casual Talks #13 (Online) ](https://mlct.connpass.com/event/239953/)

<iframe width="560" height="315" src="https://www.youtube.com/embed/mPByIMURM8A" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## 各発表について

各発表の説明は割愛して、一言感想を述べさせていただきます。

### Editors-in-the-loop なニュース記事要約システムの提案 by @upura

<iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/bbd8b52773294fd394739d326c75c93a" title="Editors-in-the-loop なニュース記事要約システムの提案 / Editors-in-the-loop News Article Summarization Framework" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 560px; height: 315px;" data-ratio="1.7777777777777777"></iframe>

業務成果を[国際会議のワークショップ](https://ieeexplore.ieee.org/document/9671300)に通されたの素晴らしいですね 👏 (自分も論文を出したことがありますが)、論文を書くことが目的ではない職種で論文を出すのはそもそも体力が必要なので、提出してなおかつ採択されたのは素晴らしいの一言!

### Active Learning for Auto Annotation by @tkc79

<iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/a4ff03681c664f68ab6ab0b60c7b884f" title="Active Learning for Auto Annotation" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 560px; height: 315px;" data-ratio="1.7777777777777777"></iframe>

自分たちのプロダクトで実際に能動学習の効果を検証して学びを得るというのは得難い経験ですね。尊い! 実際にやってみた上での実践的な経験を語ってくれたのが面白かったです。

### NeurIPS Data-Centric AI Workshop by @K_Ryuichirou

<iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/68b55ebbb38a40a98e23e7b6f9f9f323" title="NeurIPS Data-Centric AI Workshop" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 560px; height: 314px;" data-ratio="1.78343949044586"></iframe>

[Data Centric AI Workshop](https://datacentricai.org/) の要約を話して頂きました。
[The Godfather of MLOps である D.Sculley](https://mlops.community/watch/the-godfather-of-mlops_ZKeUIVDjgKjvMt/) さん [^4]が 「Technical Debt in ML: A Data-Centric View」の話をされていたらしいのですが、これは見なければ...!
Moneyfoward 様での業務で @K-Ryuichirou 様が作られた資料なのですが、公開を快諾して頂き、Moneyfoward 様、 @K-Ryuichirou さまありがとうございました。

## 勉強会の運営振り返り

オフラインと比べると圧倒的に楽、楽すぎる。これに尽きる。
事前の運営コストの見積もり予想がバッチリあたって何より[^2]。
代償としては、やはりオフライン懇親会とオンライン懇親会は似て非なるものということを実感できたが、運営者観点でいうとアリよりのアリではと感じた。

配信のリアルタイム視聴者は最大 98 人で、勉強会の参加ページは 258 人だったので、見込みに対して 4 割程度の方がリアルタイムに配信を視聴してくれた。

![](/posts/2022-03-31/images/2.png)

### Streamyard が神ツール。これが無料とは...

OBS で頑張って配信しなくても、[Streamyard](https://streamyard.com/) を使えば Web アプリだけでヨイカンジの配信できるなんて感動ですね。
前回の MLCT 12 回目のイベントの配信時[^3]には @chezou さんにマシンに火を吹いてもらって配信してもらっていたんですが、今回は @chezou さんがバンクーバーにいらっしゃるので代わりに Streamyard を使うことにしました。

実際に使ってみると、招待リンクで登壇者を Web 上で完結して招待可能なのがとても便利。Web アプリベースなので、Zoom などであるあるの「あれうまく接続できないですね..」が無い。Chrome のカメラやマイク設定の承認で一度再入出する必要があったが、それは 2-3m でトラブルシューティングを完了したので全く問題がなかった。

また、開催者が Streamyard 参加者の画面を配信に投影するかどうかを調整可能なのも良い。複数人の参加者の画面共有を共存して待機することができるので、事前に登壇者の画面を共有してもらうことで、司会のスライドから登壇者の画面へ滑らかに遷移が可能なのでぐだつかない。DJ(というより VJ?) のように、画面を差し替えて進行していけるのは楽しさがあった。

配信時の画面レイアウトが複数パターンあり、いろんな配信パターンに対応できる。資料と登壇者を移したり、登壇者だけでグリッド状に配信したりと良い感じに配信が行える。

音楽配信も Streamyard 付随の音楽をアイスブレイクに流せる(動画も流せる)ので、無音で気まずい空気が流れるのもこれで回避できる。

プライベートチャットで、時間のリマインドやコミュニケーションが Streamyard 内で完結できる。配信者としては Streamyard 内ですべて完結してコミュニケーションが取れるのはありがたい。登壇者へのタイムスケジュールのリマインドもここで行える。

Youtube 配信が簡単に配信できる。認証すればすべてが Streamyard 内で完了する。Youtube のコメントが Streamyard 内でできるので、簡単にアナウンスができる。当日判明したのは Youtube 側のコメントが誰もがコメントできるように開放されていなかったので、何かしらの設定が必要なのかも知れない。

以上を踏まえて、いたせりつくせりの機能となっており、Streamyard のウォーターマークが動画に入るとはいえ、無料で使わせていただいて良いのだろうかと心配になるほどいい感じの配信ができた。

### オンライン懇親会

今回の懇親会は、 gather.town で開催しました。当初は spatial.chat で開催予定でしたが無料枠の参加人数がソッと 50 人から 25 人に減っていた。ならば無料枠の参加人数が同じで自分にとって馴染みのあるツールである gather を採用することにしました。

![gather](/posts/2022-03-31/images/3.png)

参加人数は 8-9 人程度で、一つの輪になって話す感じでリアルな懇親会での偶発性がある出会いはなかなか難しいですが、10 人以下のグループで話が発生するので、オンライン懇親会の開催自体は全然ありだなと思いました。開催コストも 0 なので、やって損はなし。

個人的な理想としては、8-9 人の参加者だと 4 人グループ x 2 のような構成ができると嬉しいなと思いつつ、ここらへんの考えは人によって異なるので色々と模索していきたい。
Zoom や Google Meet のブレイクアウト機能が、矯正分割してワイワイ感を増せるのだが、懇親会に参加している人が必ずしも喋りたいというわけではない(グループに参加して話を聞くだけでも十分という人もいそう)と思うので、良い塩梅って難しい。

## 総評

久々の勉強会の主催ですが、オフラインのコスト 1/10 くらいで実現できて感動しつつ、また機運があれば開催したいなと思っております。

改めて、Twitter[^twitter] での突発的な募集にも関わらず手を上げてくださった登壇者の @upura さん、 @tkc79 さん、 @K_Ryuichiro さんありがとうございました。
また、実況や配信の監視などを行っていただいた共同運営者の @tetsuroito さん、ありがとうございました!

オンライン配信ならではの楽しさとしては、オフラインだと 100 人が参加する会場を手配したり設営するだけでも大変ですが、オンラインだと 100 人閲覧というリアルタイムな参加者だけに着目するとパソコンだけで実現できるのでそれは素晴らしいことですね。

[^hitl]: [機械学習モデルの改善手法の一つ、 Human In The Loop について](/post/2022-03-22)
[^opml21]: [MLOps の国際会議 OpML'20 に、機械学習を活用した商品監視の改善に関する論文が採択されたので登壇してきた](/posts/2020-09-06/)
[^2]: [オンライン開催前提だからこそ可能な省エネ勉強会運営 ~勉強会運営再開してみた~](/posts/2022-02-22/)
[^3]: [Machine Learning Casual Talks #12 (Online)](https://mlct.connpass.com/event/172550/)
[^4]: [D. Sculley](https://scholar.google.com/citations?user=l_O64B8AAAAJ&hl=en) さんは、`Hidden technical debt in machine learning systems` や `The ML test score: A rubric for ML production readiness and technical debt reduction` の著者。機械学習エンジニアリングや MLOps の面白い論文を出しまくっているすごい人。
[^twitter]: https://twitter.com/hurutoriya/status/1492481043747991555

    > 私生活に少しに余裕が出てきたので、 実世界の機械学習のよもやま話をする #MLCT を 2 年ぶりに再開検討中です!
    > https://mlct.connpass.com
    > Human In The Loop をテーマに開催したいんですが、話せる人がどれくらいいるか未知数なので自分話せますよという方はリプライいただけると超絶嬉しいです
