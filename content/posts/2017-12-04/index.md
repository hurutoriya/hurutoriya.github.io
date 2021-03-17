---
title: "Edge-Weighted Personalized PageRank: Breaking A Decade-Old Performance Barrier を読んだ"
date: 2017-12-04T13:06:15.767Z
lastmod: 2019-06-16T18:16:09+09:00
lang: ja
tags:
  - Machine Learning
  - KDD
  - Paper
---

応用数理研究者が機械学習界に進出していく研究

![image](/posts/2017-12-04/images/1.png)

youtube clip

応用数理界隈ではクラシックな解き方で PageRank が解かれているので最新の数値計算手法に置き換えることで劇的にパフォーマンスが向上して 10 年前のパフォーマンスの鎖を解き放った論文

- KDD2015 Best student paper award
- [Slide(PDF)](http://www.cs.cornell.edu/~bindel/present/2015-08-kdd-talk_kdd-aug15.pdf)
- [Poster(PDF)](http://www.cs.cornell.edu/~bindel/present/2015-08-kdd-poster_poster-kdd-pr.pdf)
  [Spectral network analysis](http://www.cs.cornell.edu/~bindel//blurbs/graphspec.html)

[wenleix/EdgePPR](https://github.com/wenleix/EdgePPR)

- Presentation Movie is uploaded in Youtube.

Author

- W. Xie
- Ph.D Candidate at Cornell University
- [http://wenleix.github.io/](http://wenleix.github.io/)
- iterative computation on big graph data
- D. Bindel
- [http://www.cs.cornell.edu/~bindel/](http://www.cs.cornell.edu/~bindel/)
- [http://www.cs.cornell.edu/~bindel/talks.html](http://www.cs.cornell.edu/~bindel/talks.html)
- He is frequently research activ like ideal young researcher.
- Nonlinear eigenvalue problem.
- Alan J. Demers
- Prof.
- Johannes Gehrke
- [http://www.cs.cornell.edu/johannes/](http://www.cs.cornell.edu/johannes/)
- Prof.
- VLDB,SIGMOD,KDD

### Motivation

- ページランクは重要な指標。遷移確率を求めるにはランダムサーファーモデル(ランダムウォーク)が必要。
- 様々な高速解法が提案されている。

### Reseatch Question

- しかし 10 年以上前、PageRank の黎明期から Personalization based の手法は問題がある。
- 一般的な PageRank の解法の説明、その後に Model Reduction をベースにした約 5 倍の性能を誇る提案手法を説明。
- 提案手法の性能によって、パフォーマンス上のボトムネックは消えた。

### Proposed Method

- PageRank
- 初期:WEBPage のランクに使用 → 現在:推薦、ソーシャルネットワーク
- Random Suffer Model
- Transition : α の確率で Random Walk(滞在ノードから無作為に遷移)
- Teleporting : 1−α Random Junmp(滞在ノードに依存せずに全てのノードを対象に無作為遷移)
- x(t+1)=αPxt+(1−α)v,where P=AD−1
- v is represents telepotation probabilitie
- xt Walker の確率分布
- サーファーが来る確率 = RandomWalk の確率\_RandomWalk による遷移確率 + RandomJump の確率\_RandomJump の遷移確率
- = α× RandomWalk による遷移確率 + (1−α)×RandomJump の遷移確率
- = α×+(1−α)×v
- x: Stationary vector(不動ベクトル、定常ベクトル、不動点定理など)
- x が定常状態になった際に、x の確率分布が PageRank を表す。
- x(t),x(t+1)が同一(残差が無い)だと仮定することで、次式の線形方程式を解くことで Pagerank を求める。
- Mx=b,where M=(I−αP),b=(1−α)v.

#### Standard PageRank

- グラフの構造(幾何性)を利用
- 多くのグラフでは、ノードやエッジに重みが存在する

#### Personalized PageRank

- PageRank を特定のユーザやクエリに合わせたランク
- Node wighted graph
- Mx(w)=(1−α)v(w),w∈ℝ𝕕
- w: 特定の個人、クエリに合わせたパラメータ
- Edge weighted graph
- M(w)x(w)=(I−α)v,w∈ℝ𝕕
- Node Weight, Edge Weight 共に Personalized PageRank は重要だが、２つの問題がある。
- Node Weight に関する論文:多い Edge Weight:少ない
- 計算コストが高い
- Edge weighted Personalized PageRank における x(w)を求める高速手法を提案
- 提案手法は計算量が準線形的。
- 予備知識
- xt+1:べき乗法
- Mx=b:ヤコビ法
- x(w)=(1−α)M−1Vw.
- v≈Vwwhere V∈ℝ𝕟×𝕕
- M−1V:O(n) 、x(w)の再構築に O(d)、PageRank を求めるには O(nd)が要求される。
- v が疎なら計算量は準線形へ。

### MODEL RESUCTION METHOD

1.  k 次元の次元の削減された空間を構築
2.  k 次元を近似するために k 個の等式が必要
3.  次元削減の問題を解く(PageRank のベクトルは一部分が重要だという仮説)

- Reduced Space Construction
- {w(j)}rj=1(ベクトルの集合)に対応する PageRank {x(j)}rj=1(ベクトルの集合)を求める。
- w は乱数によって決定する
- k 次元の空間 υ を探索する
