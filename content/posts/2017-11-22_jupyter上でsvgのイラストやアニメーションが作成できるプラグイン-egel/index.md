---
title: "Jupyter上でSVGのイラストやアニメーションが作成できるプラグイン egel"
author: "Shunya Ueta"
date: 2017-11-22T12:04:30.104Z
lastmod: 2019-06-16T18:16:05+09:00
lang: ja
tags:
  - Python
  - Jupyter Notebook
  - Presentations
  - Development

image: "/posts/2017-11-22_jupyter上でsvgのイラストやアニメーションが作成できるプラグイン-egel/images/1.gif"
images:
  - "/posts/2017-11-22_jupyter上でsvgのイラストやアニメーションが作成できるプラグイン-egel/images/1.gif"
  - "/posts/2017-11-22_jupyter上でsvgのイラストやアニメーションが作成できるプラグイン-egel/images/2.png"
  - "/posts/2017-11-22_jupyter上でsvgのイラストやアニメーションが作成できるプラグイン-egel/images/3.gif"
  - "/posts/2017-11-22_jupyter上でsvgのイラストやアニメーションが作成できるプラグイン-egel/images/4.gif"

aliases:
  - "/jupyter-egal-ae3a886266c6"
---

アイデアは面白い… けど easy drawing ではない

Jupyter 使ってると作図も Jupyter 上で完結させたいなぁ~って思うときがあるんですが、スクリプトで作図はけっこう辛いものがあります

そのため Jupyter 上でフリースタイルに作図できる機能ないかなと探してたら egal という面白そうな拡張機能があったので使ってみました

[uclmr/egal](https://github.com/uclmr/egal)

![image](/posts/2017-11-22_jupyter上でsvgのイラストやアニメーションが作成できるプラグイン-egel/images/1.gif)

egal GIF animation

以下のリポジトリから
`$pip3 install git+https://github.com/uclmr/egal.gi`

でクローンしてきて
`$jupyter nbextension install --py egal $jupyter nbextension enable --py egal`

で拡張機能を有効にして使えるようになります。

![image](/posts/2017-11-22_jupyter上でsvgのイラストやアニメーションが作成できるプラグイン-egel/images/2.png)

ブラシアイコンをクリックすると新たなセルが生成される

![image](/posts/2017-11-22_jupyter上でsvgのイラストやアニメーションが作成できるプラグイン-egel/images/3.gif)

👉 ボタンをクリックすると各オブジェクトの詳細なプロパティが調整できる

![image](/posts/2017-11-22_jupyter上でsvgのイラストやアニメーションが作成できるプラグイン-egel/images/4.gif)

フレーム毎にオブジェクトを設定してアニメーションっぽくもできる

5–6 分使ってみて感じましたが、めちゃくちゃ操作がしづらい…

やはりブラウザ上での図形作成はめちゃくちゃストレスたまるので、ローカルで keynote 使って図形作成したほうがマシな感じです。

遊んだ結果を notebook で github にアップしておきました。

残念ながら SVG が Github 上ではレンダリングされないので残念な感じになっております... ローカルにクローンしてきて egal を有効にしておくと見れます。

[hurutoriya/notebook](https://github.com/hurutoriya/notebook/blob/master/notebook/egal_example.ipynb)

### 結論

Jupyter で全てを完結させるのは難しい
