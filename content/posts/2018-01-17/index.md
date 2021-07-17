---
title: "Data-driven Crowd Analysis in Videos (ICCV2011)を読んだ"
date: 2018-01-17T05:55:41.861Z
lastmod: 2019-06-16T18:17:47+09:00
lang: ja
tags:
  - computervision
  - paper
---

Data-driven Crowd Analysis in Videos (ICCV2011)を読んだ

Mikel Rodriguez, Josef Sivic, Ivan Laptev, Jean-Yves Audibert, “Data-driven Crowd Analysis in Videos”, in ICCV2011.  
[Project Page](http://www.di.ens.fr/willow/research/datadriven/)

を読んだので、メモです。

![image](/posts/2018-01-17/images/1.png)

Summary

### tl;dr

- 高密度な群集内の個人を追跡を転移学習によって精度を向上させる手法

### Contribution

- 追跡の精度を転移学習によって向上させた
- 転移学習を行うためのデータセットとそのフレームワークを考案

論文内では、転移学習の例として`マラソンA`の群集を対象に追跡する際に、以下の流れで転移学習を行う。

1.  大域的な群衆状況のマッチング : 同じようなシーンを探索(この場合 DB 内にあるマラソン動画)
2.  局所的な群衆状況のマッチング : `1`でマッチした動画においてオプティカルフローが類似するパッチを探索して転移学習

また、Rare Events(デモの最中に群集を横断するカメラマンなど、群衆の流れに対して同調しない動きを行う人物)に対しても実験を行い評価。

### Comments

転移学習は自分のイメージだと、自然言語処理のイメージ(一般的な文書を学習したモデルを法律文書に対して適用するなど)しかなかったので新鮮な気持ちで読めた。  
動画なら転移学習を行ったとしても、直感的に良い特徴を学べそうなので、良い仮説を立てている論文でした。

最後に示されてる個人追跡における平均誤検出の単位が`pixel`だが、Ground-Truth と提案手法の追跡軌跡の重複度具合を見てると誤検出が更に高そうに見えるけどどうなんでしょうか？  
(テストデータのみ学習が 58.82、転移学習を行った提案手法だと 46.88[pixel]になっていてもっと相対的な差が出てくるはず?)
