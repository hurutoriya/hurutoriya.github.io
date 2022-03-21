---
title: "実は機械学習の実応用で最も大事なのではと思っているHuman In The Loop について考える"
date: 2022-03-22T00:16:51+09:00
draft: true
lang: ja
author: Shunya Ueta
tags:
  - machinelearning
---

[人間参加型の AI 活用 (Human-in-the-loop)](https://www.dlri.co.jp/files/ld/157704.pdf)

Human In The Loop は、機械学習のモデルのライフサイクルに人が介在することにより、機械学習モデルの持続的な改善を目指す手法。

ちょっと意味が広めになりがちな言葉でもあるが、一般的には機械学習モデルの出力を使ってアノテーションを行う能動学習(Active Learning)の事を主に意味していることが多いですが、もう少し広めの意味でも使われたりする。

自分の感覚では、

- `広義`: [^1]
- `狭義`:

日本語の書籍だと

- 鹿島先生、小山先生、馬場先生らの [ヒューマンコンピュテーションとクラウドソーシング](https://amzn.to/360J6NZ)
- 喜連川先生、森嶋先生らの[クラウドソーシングが不可能を可能にする: 小さな力を集めて大きな力に変える科学と方法](https://amzn.to/3qds469)

などがデータをどうやって取得していくかの領域を扱っている書籍だと思います。

英語の書籍だと [Human-in-the-Loop Machine Learning: Active learning and annotation for human-centered AI ](https://amzn.to/3IhsAWD) がドンピシャの内容ですね。

機械学習エンジニアを始めてから、どうすれば高品質なデータを効率的に収集できるかについて考えています。なぜならビジネス的な結果を出す前に、根本的にモデルの性能をだすためには、良いデータが無いと始まらないからです。

答えの一つが Human In The Loop だと思うのですが、日本語圏だとあまり盛り上がって無いような気がするので、 Human In The Loop に興味のある方、`2022/03/30`に Humain In The Loop をテーマにしたオンライン勉強会を開催することにしました。

登壇者募集をしてみたら、続々と名乗りを上げて頂き非常に感謝です。

もし、興味のある方はご参加下さい

[Machine Learning Casual Talks #13 (Online) : 機械学習に関する知見をカジュアルに語る。テーマ: Human In The Loop](https://mlct.connpass.com/event/239953/)

[^1] : [Google による機械学習の実応用をテーマにした Coursera の講義は、機械学習プロジェクトに携わるなら一度は見ておいても損はない](/posts/2022-03-17/)
