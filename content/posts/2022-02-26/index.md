---
title: "Amazon による、製品検索のためのロバストなキャッシュ手法「ROSE: Robust Caches for Amazon Product Search」"
date: 2022-02-26T21:00:57+09:00
lang: ja
draft: true
author: Shunya Ueta
cover:
  image: "/posts/2022-02-26/images/fig-1.png"
  caption: "ROSE の概要"
ShowToc: true
tags:
  - search
  - machinelearning
  - mlengineering
  - paper
---

Web 検索とデータマイニングのトップカンファレンス WSDM-2022 のワークショップで
[The First International Workshop on INTERACTIVE AND SCALABLE INFORMATION RETRIEVAL METHODS FOR ECOMMERCE (ISIR-ecom)](https://isir-ecom.github.io/) が先日開催された。

テーマは e コマース上での検索において

- 検索システムのスケーラビリティ
- どうやって適合性(Relevancy)をシステムで改善したか
- システムの改善

についてをテーマにした検索エンジニアなら垂涎もののワークショップとなっている。

同様の検索システムや実応用に注目したワークショップでは、以下のようなワークショップがある。

- [SIGIR Workshop On eCommerce](https://sigir-ecom.github.io/) 2017 年から毎年開催。累計 5 回開催
- [International Workshop on Industrial Recommendation Systems](https://irsworkshop.github.io/2021/) 2020 年から開催。累計二回

歴史としては、 SIGIR ecom が長く、これだけの期間継続開催してくれているのはありがたい限り。

機械学習系の国際会議でも手法ではなく、どう現実世界に適用したかに注目したワークショップが益々誕生しており非常に良い流れ。

ACCEPTED PAPERS は 5 本あり、

- Amazon: 2
- eBay: 1
- The Home depot: 2

と企業関係者による論文が 100%となっている。

https://github.com/ISIR-eCom/ISIR-eCom.github.io/tree/main/papers 最後の PDF 番号が 9 なので、最低でも 9 本の投稿はあった模様。

素晴らしいワークショップなので、来年も是非継続して開催してほしい。

すべての採択論文が面白そうだったが、今回は Amazon Search が公開した Chen Luo らの「ROSE: Robust Caches for Amazon Product Search」を紹介する。

## 一言で説明

クエリの書き換え(誤植を修正する)と深層学習モデルの結果のキャッシュを同時に行えるキャッシュシステム `ROSE` を提案して、応答速度と検索性能を改善。

## Citation

> ROSE: Robust Caches for Amazon Product Search, Chen Luo, Vihan Lakshman, Anshumali Shrivastava, Tianyu Cao, Sreyashi Nag, Rahul Goutam, Hanqing Lu, Yiwei Song and Bing Yin, Proceedings of the International Workshop on Interactive and Scalable Information Retrieval methods for eCommerce (ISIR-eCom), 2022.

## 概要

Amazon Search のような商品検索エンジンはしばしばキャッシュを利用する。
キャッシュによって Amazon の製品検索での顧客体験を向上させることができる。
顧客体験だけではなく、検索システムのレイテンシも大幅に向上する。

だが、検索トラフィックが増大しキャッシュサイズが大きくなりすぎると検索システム全体のパフォーマンスが劣化してしまう。
また、誤字やスペルミス、現実世界で見られる冗長な表現のクエリは不必要なキャッシュミスを引き起こし、キャッシュの効率性を低下させる。

「RObuSt cachE(ROSE)」はロックアップコストはそのままにスペルミスや誤字を許容可能なキャッシュシステムを提案。
ROSE はあらゆるクエリの意図、誤字、文法ミスに対して理論的な頑健性が保証されている。
現実世界のデータセットにより ROSE を評価して、有効性と効率は検証を行った。
ROSE はすでに Amazon の検索エンジンにデプロイされており、既存のキャッシュシステムと比較しても大きくビジネス指標を改善している。

## はじめに

検索エンジンで大事な２つのパフォーマンス指標

- 顧客化からのリクエストに対するレスポンスタイム
- 顧客の意図に適合した高品質な検索結果

現代的な製品検索エンジンでは通常、計算不可が高い機械学習モデルが多く使われている。

---

NOTE: [1, 8, 9, 13, 20, 28, 29, 31] の参考文献が、検索改善のための機械学習適用の文献リストとして有用そうだった。

- 18: relevance matching models
- 2: ranking models
- 27: query annotation models

---

レイテンシの制限とコストの考慮により、実際の製品検索エンジンでは、計算コストが高い深層学習モデルをサービングして検索トラフィック全体を処理することは禁止されている[14]。そのため、深層学習モデルの推論結果をサービングする代わりに、より実践的な解決方法として頻繁にリクエストがくるクエリに対して深層学習モデルの結果をキャッシュしておく。

従来のキャッシュは以下のようなトレードオフの問題がある

キャッシュミス率とキャッシュサイズの関係: 小さいキャッシュサイズでは、高いキャッシュミス率となる。一方で製品検索エンジンの規模で頻繁に検索されるクエリに対してキャッシュを作成したとして異常にキャッシュサイズが大きくなってしまう。また、 ”Nike shoes”, “Nike shoe”, and “Nike’s shoe” のような同じ意図のクエリだが、形態素的には異なるそれらのクエリはすべて別のキャッシュとしてキャッシュされてしまう。

また、[24] `Query rewrite for null and low search results in eCommerce. In eCOM@ SIGIR.` でも示されている通り、検索結果の品質を下げている要因の殆どが typo(誤植) である。 これらの検索品質が低いクエリは、高品質な検索結果を提供する頻繁に検索されるクエリと語彙的(Lexically) または意味的 (semantically)に似ている。

よって、もし我々が低品質な検索結果を提供する誤植のクエリを、同じ意図を持つクエリへキャッシングの仕組みにより紐付ける(map する)ことができたなら、検索品質を向上させることができる。また、レイテンシも大幅に向上させ、キャッシュサイズも大幅に抑えることができる。

![ROSE Figure 1](/posts/2022-02-26/images/fig-1.png)

Fig. 1: ROSE は検索品質と検索速度を向上させる

- キャッシュによるクエリの書き換え(query rewrite)によって検索品質の向上
- ROSE が大半の通信をカバーすることで、検索速度の向上。キャッシュヒットしないような少数派のクエリに対しては、深層学習モデルによって直接サービングを行う。

### ３つの貢献点

- 運用システム: 製品検索のクエリをキャッシュするための、ROSE を提案。定数時間と定数メモリで web 検索規模のデータのインデックスを作成してルックアップを実行可能
- 技術的革新: local-sensitive hashing, reservoir sampling, count-based k-selection など複数の強力な乱択アルゴリズム技術を組み合わせたシステムを開発。これにより、定数時間での検索を維持しながら ROSE を大規模なクエリセットにスケールアップが可能になった。
- 現実世界での効果: Amazon 検索に ROSE をデプロイしており、既存手法と比べてパフォーマンス、ビジネス指標ともに改善された。

## 周辺知識と関連する研究

### Robust Cashes

### Locality-SEnsitive Hasing

### 問題の定式化

![ROSE Figure 2](/posts/2022-02-26/images/fig-2.png)

## ROSE: ROBUST CACHE VIA RANDOMIZED HASHING

### ROSE Index Generation

![ROSE Alg 1](/posts/2022-02-26/images/alg-1.png)

### ROSE Online Retrieval

### Lexical Preserving Hashing

### Product Type Preserving Hashing

### Theoretical Analysis

## オフラインでの実験

### データセット

約 6 億の検索品質が高いクエリを Amazon 検索からサンプリングして、評価のためのキャッシュ対象にする。
ここでは、Xichuan ら[19] `A Dual Heterogeneous Graph Attention Network to Improve Long-Tail Performance for Shop Search in E-Commerce. In Proceedings of the 26th ACM SIGKDD International Conference on Knowledge Discovery & Data Mining. 3405–3415` と同じ評価の枠組みで評価を行った。

クエリの評価データセットは頻度ごとに分割された３つのバケットを用意

- `NQ`(Normal Queries): 頻度が上位 33%(1 つめの 3 分位数)のクエリ
- `HQ`(Hard queries): 頻度が上位 34%-66% (1 つめの 3 分位数)のクエリ
- `LTQ`(Long-tail queries): 頻度が上位 67%-100% (3 つめの 3 分位数)のクエリ

ランダムに上記のクエリを一ヶ月以上の検索ログから選択して収集する。３つのバケットは 1000 のクエリが存在してる。ドメインエキスパートによる判断により、ROSE の仕組みにより re-map された結果が元のクエリが書き換えられても意図が同一かどうかの 2 値(relevant or irrelevant)によって評価。

### 実験デザイン

２つの指標に対する仮設

- Robustness: どれぐらい ROSE は正確か?
- Efficnency: どれぐらい ROSE のインデキシングと検索処理は効率的か?

それらの仮設検証のために

- `R-LP` 提案手法。ROSE の lecical preserving hasing。 ハッシュテーブルの数は L=3 6 かつ、ハッシュの数は $K=3$
- `R-PT` 提案手法。ROSE の product type preserving hasing

![ROSE Figure 3](/posts/2022-02-26/images/fig-3.png)

![ROSE Table 1](/posts/2022-02-26/images/table-1.png)

## SYSTEM DEPLOYMENT IN AMAZON

### ROSE for Query Rewrite

### ROSE for Product Type Annotation

![ROSE Table 2](/posts/2022-02-26/images/table-2.png)

## 結論

クエリの書き換え(語彙的または意味的に近いものをまとめる)を行うキャッシュシステムである ROSE を提案。数億のキャッシュ候補を定数時間・定数メモリで
