---
title: "Edge-Weighted Personalized PageRank: Breaking A Decade-Old Performance Barrier を読んだ"
author: "Shunya Ueta"
date: 2017-12-04T13:06:15.767Z
lastmod: 2019-06-16T18:16:09+09:00

description: ""

subtitle: "応用数理研究者が機械学習界に進出していく研究"
tags:
 - Machine Learning 
 - 日本語 
 - Kdd 
 - Paper 

image: "/posts/2017-12-04_edgeweighted-personalized-pagerank-breaking-a-decadeold-performance-barrier-を読んだ/images/1.png" 
images:
 - "/posts/2017-12-04_edgeweighted-personalized-pagerank-breaking-a-decadeold-performance-barrier-を読んだ/images/1.png" 


aliases:
    - "/kdd2015-beststudentpaper-edge-weighted-pagerank-c1ad528a3f5a"
---

応用数理研究者が機械学習界に進出していく研究




![image](/posts/2017-12-04_edgeweighted-personalized-pagerank-breaking-a-decadeold-performance-barrier-を読んだ/images/1.png)

youtube clip



応用数理界隈ではクラシックな解き方でPageRankが解かれているので最新の数値計算手法に置き換えることで劇的にパフォーマンスが向上して10年前のパフォーマンスの鎖を解き放った論文

*   KDD2015 Best student paper award
*   [Slide(PDF)](http://www.cs.cornell.edu/~bindel/present/2015-08-kdd-talk_kdd-aug15.pdf)
*   [Poster(PDF)](http://www.cs.cornell.edu/~bindel/present/2015-08-kdd-poster_poster-kdd-pr.pdf)
[Spectral network analysis](http://www.cs.cornell.edu/~bindel//blurbs/graphspec.html)

[wenleix/EdgePPR](https://github.com/wenleix/EdgePPR)


*   Presentation Movie is uploaded in Youtube.





Author

*   W. Xie
*   Ph.D Candidate at Cornell University
*   [http://wenleix.github.io/](http://wenleix.github.io/)
*   iterative computation on big graph data
*   D. Bindel
*   [http://www.cs.cornell.edu/~bindel/](http://www.cs.cornell.edu/~bindel/)
*   [http://www.cs.cornell.edu/~bindel/talks.html](http://www.cs.cornell.edu/~bindel/talks.html)
*   He is frequently research activ like ideal young researcher.
*   Nonlinear eigenvalue problem.
*   Alan J. Demers
*   Prof.
*   Johannes Gehrke
*   [http://www.cs.cornell.edu/johannes/](http://www.cs.cornell.edu/johannes/)
*   Prof.
*   VLDB,SIGMOD,KDD

### Motivation

*   ページランクは重要な指標。遷移確率を求めるにはランダムサーファーモデル(ランダムウォーク)が必要。
*   様々な高速解法が提案されている。

### Reseatch Question

*   しかし10年以上前、PageRankの黎明期から Personalization based の手法は問題がある。
*   一般的なPageRankの解法の説明、その後にModel Reductionをベースにした約5倍の性能を誇る提案手法を説明。
*   提案手法の性能によって、パフォーマンス上のボトムネックは消えた。

### Proposed Method

*   PageRank
*   初期:WEBPageのランクに使用→現在:推薦、ソーシャルネットワーク
*   Random Suffer Model
*   Transition : αの確率でRandom Walk(滞在ノードから無作為に遷移)
*   Teleporting : 1−α Random Junmp(滞在ノードに依存せずに全てのノードを対象に無作為遷移)
*   x(t+1)=αPxt+(1−α)v,where P=AD−1
*   v is represents telepotation probabilitie
*   xt Walkerの確率分布
*   サーファーが来る確率 = RandomWalkの確率_RandomWalkによる遷移確率 + RandomJumpの確率_RandomJumpの遷移確率
*   = α× RandomWalkによる遷移確率 + (1−α)×RandomJumpの遷移確率
*   = α×+(1−α)×v
*   x: Stationary vector(不動ベクトル、定常ベクトル、不動点定理など)
*   xが定常状態になった際に、xの確率分布がPageRankを表す。
*   x(t),x(t+1)が同一(残差が無い)だと仮定することで、次式の線形方程式を解くことでPagerankを求める。
*   Mx=b,where M=(I−αP),b=(1−α)v.

#### Standard PageRank

*   グラフの構造(幾何性)を利用
*   多くのグラフでは、ノードやエッジに重みが存在する

#### Personalized PageRank

*   PageRankを特定のユーザやクエリに合わせたランク
*   Node wighted graph
*   Mx(w)=(1−α)v(w),w∈ℝ𝕕
*   w: 特定の個人、クエリに合わせたパラメータ
*   Edge weighted graph
*   M(w)x(w)=(I−α)v,w∈ℝ𝕕
*   Node Weight, Edge Weight共にPersonalized PageRankは重要だが、２つの問題がある。
*   Node Weightに関する論文:多い Edge Weight:少ない
*   計算コストが高い
*   Edge weighted Personalized PageRankにおけるx(w)を求める高速手法を提案
*   提案手法は計算量が準線形的。
*   予備知識
*   xt+1:べき乗法
*   Mx=b:ヤコビ法
*   x(w)=(1−α)M−1Vw.
*   v≈Vwwhere V∈ℝ𝕟×𝕕
*   M−1V:O(n) 、x(w)の再構築にO(d)、PageRankを求めるにはO(nd)が要求される。
*   vが疎なら計算量は準線形へ。

### MODEL RESUCTION METHOD

1.  k次元の次元の削減された空間を構築
2.  k次元を近似するためにk個の等式が必要
3.  次元削減の問題を解く(PageRankのベクトルは一部分が重要だという仮説)

*   Reduced Space Construction
*   {w(j)}rj=1(ベクトルの集合)に対応するPageRank {x(j)}rj=1(ベクトルの集合)を求める。
*   wは乱数によって決定する
*   k次元の空間υを探索する
