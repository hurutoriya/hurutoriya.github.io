---
title: "クエリ分類(Query Classification) について社内の勉強会で話してきた"
date: 2021-10-09T00:42:40+09:00
lang: ja
author: Shunya Ueta
tags:
- search
- machinelearning
---

今年の10月から、新しく入社した同僚とともに、検索領域の論文や技術ブログを定期的に紹介する社内勉強会をはじめてみた。
定常的に開催されることが一番大事だよねという方針になったので、できるだけ低コストで継続できるような仕組みにした。

- 参加者は何も準備をしなくても大丈夫で、勉強会中に紹介された論文をみたり話を聞くだけで良い
- 発表者は凝った資料は必須ではなくて、極論論文を画面共有で見せながらしゃべるだけでも問題なし

当面の目標としては、来年の年末まで継続されているように気長に続けていきたい。

第一回は、発起人の一人である自分がクエリ分類について発表を行った。

[Query Understanding for Search Engines (The Information Retrieval Series, 46)](https://amzn.to/3iKG1Vp) の第二章を主にテーマとして取り上げて紹介した。

メイントピックは KDDCup2005 として開催されたクエリ分類コンペの優勝者の手法について紹介を行ったので、気になる方はスライドを公開しているので御覧ください。

<iframe src="//www.slideshare.net/slideshow/embed_code/key/5KJ09u6AURGBVq" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/shunyaueta/query-understanding-for-search-engines-chap2-query-classification" title="Query Understanding for Search Engines. Chap2 Query Classification" target="_blank">Query Understanding for Search Engines. Chap2 Query Classification</a> </strong> from <strong><a href="https://www.slideshare.net/shunyaueta" target="_blank">Shunya Ueta</a></strong> </div>

このコンペの特徴として、

- データセットが生データ特有の問題として汚い
- そしてラベルデータの規模がとても少ない

という鬼畜仕様だった。
だがコンペ参加者はそんな状態を物と物せずにありとあらゆる手段で精度向上に努めていてそれらの手法と姿勢がとても参考になった。

検索領域は本当に奥深い...