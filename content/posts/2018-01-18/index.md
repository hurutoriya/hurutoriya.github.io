---
title: "Where To Look: Focus Regions for Visual Question Answering (CVPR2016)を読んだ"
date: 2018-01-18T05:41:44.616Z
lastmod: 2019-06-16T18:17:50+09:00
lang: ja
tags:
  - Computer Vision
  - Paper
  - CVPR
---

Kevin J. Shih, Saurabh Singh, Derek Hoiem, “Where To Look: Focus Regions for Visual Question Answering”, in CVPR2016 [link](http://www.cv-foundation.org/openaccess/content_cvpr_2016/papers/Shih_Where_to_Look_CVPR_2016_paper.pdf)

![image](/posts/2018-01-17/images/1.png)

Summry

を読んだので、軽くメモ。

VQA(Visual Question Answer) 画像に対する質問に対して応答するタスクに対し、その質問クエリに対して画像のどの領域に注目すべきかのモデルの学習方法について論じた論文。

### Contribution

- [VQA dataset](http://www.visualqa.org/)に対して、提案手法を適用。従来手法を全て上回った。
- 画像に対して CNN を用いて物体領域の検出を行った後にベクトル化、質問クエリは`word2vec`を用いてベクトル化を行う。
- その 2 つのベクトルを用いて内積計算により重み付けを行うことで、どの領域に注目すべきかを計算する。

### Comments

引用文献の訳 9 割が 2014–2015(直近 2 年間)で発表された論文で、改めてこの分野の最先端を駆け抜けるのは凄まじい能力が必要になるなと思いました。  
そして相変わらず CVPR の論文のネーミングセンスは良いですね。(ジャケ買いならぬジャケ読み)

単純な質問なら、人間でも瞬間的に解答可能な物が多いなと感じた。

![image](/posts/2018-01-17/images/2.png)

fig. 1

セマンティックな疑問(Fig.1 雨は降っていますか?)の場合、人間に注目した場合は傘をさしているから雨と判断しても良いがもっと広い範囲で画像を見てみると空は快晴なので人間に注目するのは筋が悪く VQA はとても難しくチャレンジングな問題だと書かれていた。(それでも充分すごい領域に到達しているなと思うが)
