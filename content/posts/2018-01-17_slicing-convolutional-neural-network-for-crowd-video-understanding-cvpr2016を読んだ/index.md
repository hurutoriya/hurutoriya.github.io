---
title: "Slicing Convolutional Neural Network for Crowd Video Understanding (CVPR2016)を読んだ"
author: "Shunya Ueta"
date: 2018-01-17T06:04:37.378Z
lastmod: 2019-06-16T18:17:49+09:00

description: ""

subtitle: "群衆解析の手法に興味があるので、サーベイの結果を放流しておきます。"
tags:
 - 日本語 
 - Computer Vision 
 - Cvpr 
 - Paper 
 - Research 

image: "/posts/2018-01-17_slicing-convolutional-neural-network-for-crowd-video-understanding-cvpr2016を読んだ/images/1.png" 
images:
 - "/posts/2018-01-17_slicing-convolutional-neural-network-for-crowd-video-understanding-cvpr2016を読んだ/images/1.png" 


aliases:
    - "/slicing-convolutional-neural-network-for-crowd-video-understanding-cvpr2016-d88a82705670"
---

群衆解析の手法に興味があるので、サーベイの結果を放流しておきます。

Jing Shao, Chen Change Loy, Kai Kang, and Xiaogang Wang, “Slicing Convolutional Neural Network for Crowd Video Understanding”, in CVPR, 2016.

[Project Page](http://www.ee.cuhk.edu.hk/~jshao/SCNN.html)



![image](/posts/2018-01-17_slicing-convolutional-neural-network-for-crowd-video-understanding-cvpr2016を読んだ/images/1.png)

Summary

### 一言説明

時系列・空間的特徴からCNNで特徴を学習、群衆の動画に対して`state-of-the-art`を達成

3個のCNNを用いて下記の３つの特徴を表現学習

*   xy- : 空間的特徴
*   xt- : x軸の時系列特徴
*   yt- : y軸の時系列特徴

### Comments

Dataset として[WWW Crowd Dataset](http://www.ee.cuhk.edu.hk/~jshao/WWWCrowdDataset.html)  
が公開されている。10,000本の群衆の動画を収集公開しているとのこと。




Demo Movie



*   紹介動画を見てみたら分かるが、群衆の動画というよりも数が増大した結果一般的な画像認識のデモ動画になっている
*   [Jing Shao](http://www.ee.cuhk.edu.hk/~jshao/)さんはCVPR2014から群衆解析のためのdescriptorを提案したりしてたんだけど、2016年からDeepな手法での群衆解析の研究をやっているのは手が早いなと
*   所属グループはISLVRC2015の物体認識タスクで優勝した香港大学のグループ
*   [Multimedia Laboratory The Chinese University of Hong Kong](http://mmlab.ie.cuhk.edu.hk/index.html)
*   データセット、実装コードを必ず公開しているのは尊敬、またそれくらいやらないとトップには通過しないんだろうな
*   CNNのアーキテクチャ毎の比較実験と考察をかなり入念に行っていた。数年後には各データのフォーマットに合わせたベストなDNNのアーキテクチャが決まってくるんじゃないだろうか
