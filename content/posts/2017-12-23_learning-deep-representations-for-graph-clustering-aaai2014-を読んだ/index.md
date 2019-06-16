---
title: "“Learning Deep Representations for Graph Clustering (AAAI2014)” を読んだ"
author: "Shunya Ueta"
date: 2017-12-23T17:38:19.179Z
lastmod: 2019-06-16T18:16:19+09:00

description: ""

subtitle: "自己符号化器とSpectral Clusteingの関連性を示した論文"
tags:
 - Deep Learning 
 - Clustering 
 - 日本語 
 - Machine Learning 

image: "/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/1.png" 
images:
 - "/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/1.png" 
 - "/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/2.png" 
 - "/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/3.png" 
 - "/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/4.png" 
 - "/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/5.png" 


aliases:
    - "/learning-deep-representations-for-graph-clustering-aaai2014-%E3%82%92%E8%AA%AD%E3%82%93%E3%81%A0-646097b0eaf6"
---

自己符号化器とSpectral Clusteingの関連性を示した論文

*   [Paper link](http://research.microsoft.com/pubs/226627/%5BAAAI2014%5D%20DNN%20for%20Graph%20Cut.pdf)

#### Author

*   Fei Tian : [http://home.ustc.edu.cn/~tianfei/](http://home.ustc.edu.cn/~tianfei/)
*   中国科学技術大学Ph.D １年生
*   MSRAと共同研究、2014年にAAAI2本,COLING1本を1stで通してる。
*   この資料も面白い。ILSVRC2015で152層のDeep Residual Learningを提案し優勝(Error Rate : 3.57%)
*   [MSRA @ ILSVRC2015 資料](http://research.microsoft.com/en-us/um/people/kahe/ilsvrc15/ilsvrc2015_deep_residual_learning_kaiminghe.pdf)

#### Motivation (研究背景・動機)

*   Deep Learningが数多くの応用でめざましい成果をあげている。
*   音声認識
*   画像認識
*   自然言語処理
*   DLにおいて Clustering に関する適切な調査が行われてない。
*   論文の目的として、DLにおける Clusteringの調査を行う

#### 概要

*   Graph Clusteringはクラスタリングでも重要な手法の一つ
*   Graph Clusteringの応用
*   Image segmentation
*   Community Detection
*   VLSI Design
*   嬉しい点 : ベクトル空間におけるクラスタリングの問題 → データの類似度グラフ問題への変換が可能
*   自己符号化器とSpectral Clusteringの類似性
*   Spectral Clustering : グラフラプラシアンに対してEVDを行いk本の非零固有ベクトルを用いた空間に対してk-meansを行ったもの。
*   自己符号化器 : 入力データを低次元化、情報が最大限になるようにデータの次元を再構築する
*   計算量 : 対象とするグラフはn個のノードを持つ
*   EVD : ナイーブに実装するとO(n3)の計算量、最速の実装はO(n2)の計算量
*   自己符号化器 : ノードがスパースな際は計算量はO(kn)
*   スパース表現 : データが大きくなるならスパース性を有効活用したい
*   EVD : 固有ベクトルが高い確率で密になるため、スパース性が保証されない
*   自己符号化器 : スパース性を用いるのは容易

### 既存研究で未検証な事柄、何を解決・解明したいのか？

*   Graph Clusteringのための Deep Learning の活用方法と調査
*   自己符号化器とSpectral Clusteringの類似性とその比較・検証

### Method (提案手法)

*   GraphEncoder(for graph clustering.)
*   グラフラプラシアン(L=D−1S)に対してスパース自己符号化器(Sparse-AutoEncoders)を通した最終層にk-measクラスタリングを行う
*   AutoEncoderは入力層・隠れ層・出力層の3層をStacked する。
*   X(j)=D−1Sの列ベクトルを各ユニットに入力し、隠れ層の活性化関数h(j)を得て、X(j+1)=h(j)とΓ回(層の階数分)更新する。



![image](/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/1.png)



### Evaluation (検証方法・評価方法・優位性)

*   実世界のグラフデータに対してNMIによってクラスタリングの評価実験を行う。
*   データの種類
*   ワイン
*   ニュース記事
*   タンパク質構造グラフ

以下の三種で比較

*   Spectral Clustering
*   k-means
*   Sparse-AutoEncoders(Graph-Encoder)



![image](/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/2.png)





![image](/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/3.png)



次元の減少推移




![image](/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/4.png)



層を重ねる毎にNMIが向上している。




![image](/posts/2017-12-23_learning-deep-representations-for-graph-clustering-aaai2014-を読んだ/images/5.png)



### Conclusion (結論・貢献)

*   Deep Learn と Graph Clusteringの関係性、結果を調査。
*   GraphEncoderの嬉しいところ
*   隠れ層の次元は入力層の次元より低い。これは全てのエッジが必須ではないことを直感的に示す。
*   エッジの除去を行いグラフ表現を更に明確にするために、浅い層から深い層へ。
*   EVDの計算量は最速でもO(n2.367)で、グラフは密なグラフ表現。(Toeplitz Matirix)
*   GraphEncoderはO(ncd)、dは隠れ層の最大次元、cはグラフの平均次元。(例: 各ノードがk本のエッジを持つ類似度グラフの場合 c=k。ソーシャルグラフで表すと、cは友達の平均の数を示す。)
*   EVDは並列化が困難。確率的勾配降下法(SGD)はEVDと比べると並列化が容易である。

### 提案手法の限界(残された課題)

実行時間の比較が行われていないが、あくまでこの論文の価値はDLとGraph Cluseteringの関連性を示しているのが価値なのでそこは許して下さいって感じ。### Comments (疑問点・わからなかったところ・議論)

*   トップカンファレンスを年2本、2nd tier を1本1stで出せるのは、どうやればそのレベルに到達するんだ?
*   トレンドに乗った良い論文。
*   Good Writing. 内容もシンプルなので90分でサクッと気持よく読めた。論文読むより、スパース自己符号化の勉強に時間取られた。
*   Corollary2で ~ symmetrix matrix D−1S って言ってる割に行列の対称性は保証されてないので3.1全般が怪しい、辻褄があってない。
