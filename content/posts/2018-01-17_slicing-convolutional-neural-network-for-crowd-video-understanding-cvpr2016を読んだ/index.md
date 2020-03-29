---
title: "Slicing Convolutional Neural Network for Crowd Video Understanding (CVPR2016)を読んだ"
date: 2018-01-17T06:04:37.378Z
lastmod: 2019-06-16T18:17:49+09:00
lang: ja
tags:
  - Computer Vision
  - CVPR
  - Paper
---

群衆解析の手法に興味があるので、サーベイの結果を放流しておきます。

Jing Shao, Chen Change Loy, Kai Kang, and Xiaogang Wang, “Slicing Convolutional Neural Network for Crowd Video Understanding”, in CVPR, 2016.

[Project Page](http://www.ee.cuhk.edu.hk/~jshao/SCNN.html)

![image](/posts/2018-01-17_slicing-convolutional-neural-network-for-crowd-video-understanding-cvpr2016を読んだ/images/1.png)

Summary

### 一言説明

時系列・空間的特徴から CNN で特徴を学習、群衆の動画に対して`state-of-the-art`を達成

3 個の CNN を用いて下記の３つの特徴を表現学習

- xy- : 空間的特徴
- xt- : x 軸の時系列特徴
- yt- : y 軸の時系列特徴

### Comments

Dataset として[WWW Crowd Dataset](http://www.ee.cuhk.edu.hk/~jshao/WWWCrowdDataset.html)  
が公開されている。10,000 本の群衆の動画を収集公開しているとのこと。

Demo Movie

- 紹介動画を見てみたら分かるが、群衆の動画というよりも数が増大した結果一般的な画像認識のデモ動画になっている
- [Jing Shao](http://www.ee.cuhk.edu.hk/~jshao/)さんは CVPR2014 から群衆解析のための descriptor を提案したりしてたんだけど、2016 年から Deep な手法での群衆解析の研究をやっているのは手が早いなと
- 所属グループは ISLVRC2015 の物体認識タスクで優勝した香港大学のグループ
- [Multimedia Laboratory The Chinese University of Hong Kong](http://mmlab.ie.cuhk.edu.hk/index.html)
- データセット、実装コードを必ず公開しているのは尊敬、またそれくらいやらないとトップには通過しないんだろうな
- CNN のアーキテクチャ毎の比較実験と考察をかなり入念に行っていた。数年後には各データのフォーマットに合わせたベストな DNN のアーキテクチャが決まってくるんじゃないだろうか
