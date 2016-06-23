---
layout: post
title:  "Where To Look: Focus Regions for Visual Question Answering in CVPR2015 "
date:   2016-06-23
tag: research computervision paper DNN
---

どうも、こんにちは :raised_hand: @hurutoriya です。

Kevin J. Shih, Saurabh Singh, Derek Hoiem, “Where To Look: Focus Regions for Visual Question Answering”, in CVPR2016 [link](http://www.cv-foundation.org/openaccess/content_cvpr_2016/papers/Shih_Where_to_Look_CVPR_2016_paper.pdf)

を読んだので、軽くメモ。

ディープな論文を初めて読みました。

<iframe src="https://docs.google.com/presentation/d/1p5Wr2uOLBGFtMVJinZdMbcEFlJ-R_7UHi4OafuF6dVU/embed?start=false&loop=false&delayms=3000" frameborder="0" width="960" height="569" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>

VQA(Visual Question Answer) 画像に対する質問に対して応答するタスクに対し、その質問クエリに対して画像のどの領域に注目すべきかのモデルの学習方法について論じた論文。

## Contribution

- [VQA dataset](http://www.visualqa.org/)に対して、提案手法を適用。従来手法を全て上回った。
- 画像に対してCNNを用いて物体領域の検出を行った後にベクトル化、質問クエリは`word2vec`を用いてベクトル化を行う。
- その2つのベクトルを用いて内積計算により重み付けを行うことで、どの領域に注目すべきかを計算する。

## Comments
引用文献の訳9割が2014-2015(直近2年間)で発表された論文で、改めてこの分野の最先端を駆け抜けるのは凄まじい能力が必要になるなと思いました。
そして相変わらずCVPRの論文のネーミングセンスは良いですね。(ジャケ買いならぬジャケ読み)

単純な質問なら、人間でも瞬間的に解答可能な物が多いなと感じた。

[![https://gyazo.com/f267f4fb8a8a106f215681c03f33a73c](https://i.gyazo.com/f267f4fb8a8a106f215681c03f33a73c.png)](https://gyazo.com/f267f4fb8a8a106f215681c03f33a73c)
> Fig.1

セマンティックな疑問(Fig.1 雨は降っていますか?)の場合、人間に注目した場合は傘をさしているから雨と判断しても良いがもっと広い範囲で画像を見てみると空は快晴なので人間に注目するのは筋が悪くVQAはとても難しくチャレンジングな問題だと書かれていた。(それでも充分すごい領域に到達しているなと思うが)
