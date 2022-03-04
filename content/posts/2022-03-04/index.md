---
title: "デスクトップのGoogle 検索の検索フォームUIがかなり変化していた"
date: 2022-03-04T00:03:08+09:00
author: Shunya Ueta
cover:
  image: "/posts/2022-03-04/images/1.png"
  caption: "Google 検索キーワード候補"
tags:
  - search
---

現在 AB テスト中なのかもしれないが、かなり変化している。

以前は QAC(Query Auto Completition) のみ、検索フォームにフォーカスがあたった時に表示していた記憶がある。
だが、現在は一度キーワードを検索して検索結果画面に遷移した後に、検索フォームにフォーカスすると

![Google 検索の検索フォームの変化](/posts/2022-03-04/images/1.png)

の画面のように、Query Suggest や Knowledge graph の結果をキーワードフォームに表示するようになった。

確かに、キーワードを再度検索する際に上記のコンポーネントを入れるのは試してみるのは良いのかもしれない。

特にデスクトップの検索ならハコもかなり余っているのでまだ有効活用できる余地はありそう。

でも、検索のユーザーインターフェースを紹介する書籍ではアンチパターンなのでどうなんだろうか。

[情報検索のためのユーザインタフェース](https://amzn.to/3pA4xvz)

> 1.1: KEEPING THE INTERFACE SIMPLE
> **https://searchuserinterfaces.com/book/sui_ch1_design.html**

![2022/03/04 時点のGoogle 検索のインターフェイス](/posts/2022-03-04/images/infoseek_vs_google.png)

> Figure 1.1: Search results listings from Infoseek in 1997 (left) and Google in 2007 (right), courtesy Jan Pedersen.
> 画像は上記から引用

と思いつつも、今の Google 検索のインターフェイスも

![Figure 1.1: Search results listings from Infoseek in 1997 (left) and Google in 2007 (right), courtesy Jan Pedersen.
](/posts/2022-03-04/images/2.png)

書籍の Google 検索と見比べてもかなりリッチになっているので、書籍が執筆された 2011 年からすると時代は変わっている感も否めない。

スクリーンショットが取られた 2007 年から 15 年以上も経過してますしね

@joho_hideo さんから面白いコメントがあったので追記しました。

> @joho_hideo 特別事例ですが「COVID-19」の検索結果はよく設計されていると思います。
> **https://twitter.com/joho_hideo/status/1499549278012055552**

確かに、これぞまさに情報検索の真髄ですね。
ダッシュボード的な情報を表示する

![COVID-19 SERP](/posts/2022-03-04/images/www.google.com_search_q=COVID-19&oq=COVID-19&aqs=chrome..69i57j0i457i512j0i512l8.2087j0j4&sourceid=chrome&ie=UTF-8.png)

[情報検索のためのユーザインタフェース](https://amzn.to/3pA4xvz) も現状の状況も踏まえた改訂版が出たら面白そう？
