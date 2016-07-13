---
layout: post
title:  "Slicing Convolutional Neural Network for Crowd Video Understanding in CVPR2016"
date:   2016-07-13
tag: research computervision paper cvpr
---

群衆解析の手法に興味があるので、サーベイの結果を放流しておきます。

Jing Shao, Chen Change Loy, Kai Kang, and Xiaogang Wang,  “Slicing Convolutional Neural Network for Crowd Video Understanding”, in CVPR, 2016.

[Project Page](http://www.ee.cuhk.edu.hk/~jshao/SCNN.html)

## 一言説明
時系列・空間的特徴からCNNで特徴を学習、群衆の動画に対して`state-of-the-art`を達成

<iframe src="https://docs.google.com/presentation/d/1Jt3-L8ANgTboXU0DoGrA3Xvdpe0j_JY7n20DU7W4TyQ/embed?start=false&loop=false&delayms=3000" frameborder="0" width="960" height="569" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>

3個のCNNを用いて下記の３つの特徴を表現学習

- xy- : 空間的特徴
- xt- : x軸の時系列特徴
- yt- : y軸の時系列特徴

## Comments
Dataset として[WWW Crowd Dataset](http://www.ee.cuhk.edu.hk/~jshao/WWWCrowdDataset.html)
が公開されている。10,000本の群衆の動画を収集公開しているとのこと。

<iframe width="560" height="315" src="https://www.youtube.com/embed/uIskaUyksHI" frameborder="0" allowfullscreen></iframe>

- 紹介動画を見てみたら分かるが、群衆の動画というよりも数が増大した結果一般的な動画になっている

- [Jing Shao](http://www.ee.cuhk.edu.hk/~jshao/)さんはCVPR2014から群衆解析のためのdescriptorを提案したりしてたんだけど、2016年からDeepな手法での群衆解析の研究をやっているのは手が早いなと
- 所属グループはISLVRC2015の物体認識タスクで優勝した香港大学のグループ
    - [Multimedia Laboratory The Chinese University of Hong Kong](http://mmlab.ie.cuhk.edu.hk/index.html)
    - データセット、実装コードを必ず公開しているのは尊敬、またそれくらいやらないとトップには通過しないんだろうな
- CNNのアーキテクチャ毎の比較実験と考察をかなり入念に行っていた。数年後には各データのフォーマットに合わせたベストなDNNのアーキテクチャが決まってくるんじゃないだろうか
