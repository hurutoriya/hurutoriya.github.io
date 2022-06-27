---
title: "機械学習モデルの改善手法の一つ、 Human-in-the-Loop について"
date: 2022-03-22T00:16:51+09:00
lang: ja
author: Shunya Ueta
tags:
  - machinelearning
---

Human In The Loop は、機械学習のモデルのライフサイクルに人が介在することにより、機械学習モデルの改善を目指す手法。

## Human In The Loop の定義

YANS2021 で公開された馬場先生の [Human-in-the-Loop 機械学習 / Human-in-the-Loop Machine Learning](https://speakerdeck.com/yukinobaba/human-in-the-loop-machine-learning) の資料は、現状の HITL の取り組みをわかりやすく説明してくれています。

<iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/9562f6efac3948758e0c39e70c65b16c" title="Human-in-the-Loop 機械学習 / Human-in-the-Loop Machine Learning" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 560px; height: 314px;" data-ratio="1.78343949044586"></iframe>

ここでの Human In The Loop の定義が一番明瞭かなと個人的には思っており、

> Q. より良いモデルを効率的に学習するために人間をどう活用するか?

と書かれています。

Human In The Loop はちょっと意味が広めになりがちな言葉でもあるなと個人的には思っており、機械学習モデルの出力を使ってアノテーションを行う能動学習(Active Learning)の事を主に意味していることが多いが、もう少し広めの機械学習モデルのライフサイクルの中に、人間によるデータのレビューを設置すること [^1] でも使われたりする。
が、根本的には馬場先生の定義したリサーチクエスチョンに帰結しますね。

日本語の書籍だと、

- 鹿島先生、小山先生、馬場先生らの [ヒューマンコンピュテーションとクラウドソーシング](https://amzn.to/360J6NZ)
- 喜連川先生、森嶋先生らの[クラウドソーシングが不可能を可能にする: 小さな力を集めて大きな力に変える科学と方法](https://amzn.to/3qds469)

などがデータをどうやって効率的に多数の人間の手によって取得していくかの領域を扱っている書籍。

英語の書籍だと [Human-in-the-Loop Machine Learning: Active learning and annotation for human-centered AI ](https://amzn.to/3IhsAWD) がドンピシャの内容ですね。
中身は、能動学習とアノテーションの実践的知識について書かれています。

チョット前に見かけたこの資料は

[人間参加型の AI 活用 (Human-in-the-loop)](https://www.dlri.co.jp/files/ld/157704.pdf)

Human In The Loop について浅く広くまとめられていているので、Human In The Loop の概観を知りたい人には良いかも知れない。

最近だと ABEJA さんが

[ABEJA、化学プラント領域で ABEJA Platform による Human in the Loop Machine Learning を実現　〜 三菱ガス化学と協業し AI を活用したプラント内の腐食配管の外観検査システムを開発](https://abejainc.com/ja/news/article/20220310-2923)

のリリースを出しており、

> ② の AI が腐食箇所を特定

の部分が能動学習として作業員に予測結果を提示して、修正した結果を再度フィードバックして再学習するのかなと。どれくらいの速度で再学習がされるのかなと気になったり。例えば一日に何回も再学習させるのかとか、そこらへんの運用フロー考えるの楽しそう&大変そう。

どうすれば高品質なデータを効率的に収集できるかについては、実世界機械学習の永遠の課題だと思っている。
なぜならビジネス的な結果を出す前の段階として、根本的にモデルの性能を最低限だすためには、高品質なデータとある程度の規模のデータを収集しないとそもそもプロジェクトが始められないからです。

## ここで唐突に広告ですが...

答えの一つが Human In The Loop だと思うのですが、日本語圏だとあまり盛り上がって無いような気がするので、 Human In The Loop に興味のある方、`2022/03/30`に Humain In The Loop をテーマにしたオンライン勉強会を開催することにしました。

登壇者募集をしてみたら、続々と名乗りを上げて頂き非常に感謝です。

もし、興味のある方はご参加下さい

[Machine Learning Casual Talks #13 (Online) : 機械学習に関する知見をカジュアルに語る。テーマ: Human In The Loop](https://mlct.connpass.com/event/239953/)

[^1]: [Google による機械学習の実応用をテーマにした Coursera の講義は、機械学習プロジェクトに携わるなら一度は見ておいても損はない](/posts/2022-03-17/)
