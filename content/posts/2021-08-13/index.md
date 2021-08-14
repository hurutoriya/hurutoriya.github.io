---
title: "システムの応答速度は本質的な価値提供であることを示す A/B テストの実例"
date: 2021-08-13T23:41:08+09:00
lang: ja
author: Shunya Ueta
tags:
- datascience
- abtest
---


## 内容

システム提供において、基本的に高速であればあるほど顧客は嬉しいものだが、実際のところ高速なシステムを提供して、どの程度の価値が発生するのかが気になったので、調べてみた。

### Three Challenges in Building Industrial-Scale Recommender Systems" - Keynote for ORSUM@RecSys'20

3rd Workshop on Online Recommender Systems and User Modeling でのkeynote session で発表された内容

講演者は [Sebastian Schelter](https://www.linkedin.com/in/sebastianschelter/?originalSubdomain=nl) さんという方で、アカデミックもインダストリーもどちらもバリバリにこなしている人だった。日本だとこういう経歴の人ってかなり珍しい気がするので、やはり層が厚い

ふと@hagino3000 さんのツイートが印象に残っていたので、記録のためにこちらに。1年くらい前のやり取りだけど、印象に残っていて今回この記事を書いたきっかけでもある。

> 推薦システムのレイテンシが15msと32msで差が出るかA/B Testしたって。推薦結果は同じで片方はあえて遅らせたって事だよな、はじめて聴く実験だ。15msの方がrevenueが良かったとの事。
[twitter](https://twitter.com/hagino3000/status/1309505751044354048)


公開されている動画はこちら

[Three Challenges in Building Industrial-Scale Recommender Systems" - Keynote for ORSUM@RecSys'20](https://youtu.be/IUGtGZQ0JDw?t=2314)

19,20枚目のスライド

要約すると、

![response latency](/posts/2021-08-13/images/1.png)

既存の研究では、検索エンジン上で人工的に応答速度を遅らせた際にネガティブな影響が発生した。

では、逆に応答速度を早めた場合どのような影響になるのだろうか?
とてもおもしろい事例があるので是非紹介したい、

![Some emprical evidence](/posts/2021-08-13/images/2.png)

オンプレのシステムからGoogle Cloud に移行するイベントを利用した実験を行った。マイグレーション時にサービングシステムの最適化などを行い、マイグレーション後のシステム性能向上した。この最適化により、モデルやシステム構成は全く同じだが、p90 の応答速度がオンプレのシステムでは 32ms だったものが、GCPでは15ms に向上した。
これにより生じた差異を活用して、以下のA/B テストを行った。
32ms をcontroll, 15ms をtest 群に分けてA.B テストを行ったところ、商品のオーダー、収益に関する指標が２% 向上した。

## Google による Speed Matters 実験

Sebastian さんが上記の講演で名前を出して言及はしなかったが、言及していた実験はGoogle の Speed Matters 実験だと思う。(こんな実験をわざわざするケースが他にもあったら教えてほしい)

その名の通り、速度は重要という実直なタイトルの実験である。

[Spped Matters](https://ai.googleblog.com/2009/06/speed-matters.html)

[1pのnews letter 形式でまとめられた実験結果](https://services.google.com/fh/files/blogs/google_delayexp.pdf)だが非常に面白い

実験内容としてはシンプルで、検索エンジンにリクエストを投げる際に、

1. `Pre-header`:  HTTP GET リクエストを受信後、すべてのサーバー処理を `X mx` の期間一時停止
2. `Post-header`: ヘッダー送信後サーバーの処理が完了する前に `X mx`の期間すべてのサーバー処理を一時停止
3. `Post-ads`:  広告を表示した後に `X mx`の期間のみ一すべてのサーバー処理を一時停止

各アプローチの応答時間の停止時間で、日次の検索実行を行う人数がどれくらい減少したかがまとめられている。

どれも明確なインパクトが発生しているが、 

わかりやすいものを抜き出すと、Post-headerでの時間を

- 200ms 遅らせたものが 、6週間で毎日の平均検索実行者の数が `-0.29%` 減少
- 400ms 遅らせたものが 、6週間で毎日の平均検索実行者の数が `-0.59%` 減少

![Speed matter table result](/posts/2021-08-13/images/3.png)

また、6週間の時間をかけて以下の結果が得られた。

グラフでは、 6週間 `Post-header` の時間を、`200ms`, `400ms` 遅らせた際に検索実行回数がどのように変化するかが示されている。

![Speed matter search freq result](/posts/2021-08-13/images/4.png)

検索エンジンの応答速度が遅くなることで、遅延される時間が長いものほど、その遅延の影響により、検索を行う顧客は、徐々に検索を行わなくなっていった。

`-0.5%` と聞くとそんなに大きな数字ではなく感じるが、Google 検索の規模での `-0.5%` は決して小さいものではない。

 ## 結論
 
 速さには価値がある。それをちゃんと定量的に示した人たちがいるのは偉大。
 
 こういうみんなが直感的にそうだろうと感じてはいるものの、「じゃあ実際どれくらい良いの?」という問いにたいして、実験を実行した人たち、その実験が許される環境は本当に素晴らしい。
