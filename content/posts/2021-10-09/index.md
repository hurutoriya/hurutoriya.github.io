---
title: "クエリ分類(Query Classification) について社内の勉強会で話してきた"
date: 2021-10-09T00:42:40+09:00
lang: ja
author: Shunya Ueta
tags:
  - search
  - machinelearning
---

今年の 10 月から、新しく入社した同僚とともに、検索領域の論文や技術ブログを定期的に紹介する社内勉強会をはじめてみた。
定常的に開催されることが一番大事だよねという方針になったので、以下のような仕組みで、可能な限り低コストで継続できるような仕組みにした。

- 参加者は何も準備をしなくても大丈夫で、勉強会中に紹介された論文をみたり話を聞くだけで良い
- 発表者は凝った資料は用意するのは必須ではなく、極論論文を画面共有で見せながらしゃべるだけでも問題なし

当面の目標としては、来年の年末まで継続されているように気長に続けていきたい。

第一回は、発起人の一人である自分がクエリ分類について発表を行った。

[Query Understanding for Search Engines (The Information Retrieval Series, 46)](https://amzn.to/3iKG1Vp) の第二章を主にテーマとして取り上げて紹介した。

メイントピックは KDDCup2005 として開催されたクエリ分類コンペの優勝者の手法について紹介を行ったので、気になる方はスライドを公開しているので御覧ください。

<iframe class="speakerdeck-iframe" frameborder="0" src="https://speakerdeck.com/player/a306435c7ec843adb7591ceddeb9c7a1" title="Query Understanding for Search Engines. Chap2 Query Classification" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true" style="border: 0px; background: padding-box padding-box rgba(0, 0, 0, 0.1); margin: 0px; padding: 0px; border-radius: 6px; box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 40px; width: 560px; height: 314px;" data-ratio="1.78343949044586"></iframe>

このコンペの特徴として、

- データセットが生データ特有の問題として汚い
- そしてラベルデータの規模がとても少ない

という鬼畜仕様だった。
だがコンペ参加者はそんな状態を物と物せずにありとあらゆる手段で精度向上に努めていてそれらの手法と姿勢がとても参考になった。

Query Understanding の包括的な解説は
晋策さんが書かれた [検索体験を向上する Query Understanding とは](https://blog.recruit.co.jp/rtc/2019/12/25/query-understanding-overview/) がわかりやすいのでおすすめです。

検索領域は本当に奥深い...
