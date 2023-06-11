---
title: "禅の気持ちで心穏やかにブログ記事を書くためにコメント機能を廃止して、試験的におたより機能を開始してみる"
date: 2023-06-12T01:13:23+09:00
lang: ja
author: Shunya Ueta
tags:
  - blog
  - hugo
---

以前の記事で、[^comment] ブログにコメント機能を導入した経緯を書いたが、表題のとおり、心穏やかに記事を書くためにコメント欄を廃止して、お便り機能を変わりに提供することにした。

当初は、書いた記事への弱いシグナルを得るために導入したが、最近は Twiter を意図的に使うことは辞めているが各種記事を読んだ後に改めて[^zen]、そもそも個人サイトはソーシャルの世界線とは違うところで書いたほうがいいと思い始めてたので今回の行動に踏み切った。

おたより機能は、自分で実装するのはめんどくさいので各記事の下部に Google Form のリンクを設置して、お手軽に実現する。[^copy]
ちょっとした工夫点としては、Hugo の`{{ .Permalink }}` 変数を Google Form の クエリストリングにわたすことで、おたより対象の記事の URL を自動的に入力できるようにしてみた。これは便利。

今まで giscus でコメントいただいた皆様ありがとうございました。これからはおたより機能でお願いします。

[^comment]: [GitHub discussion を使ったコメントシステム giscus を導入](/posts/2022-01-19/)
[^zen]: この気持ちは、個人ブログに回帰しているかたがたの記事が非常に良く、自分も強く共感した。 [心のざわめきを無くして日記を書くということ / secon\.dev への移転 \- A Day in the Life](https://secon.dev/entry/2020/09/03/172016/), [心穏やかに暮らす \- Glide Note](https://glidenote.com/posts/2020/12/29/) , [ウェブ縄文時代の到来 \- portal shit\!](https://portalshit.net/2020/09/04/the-internet-jomon-period), [ウェブ縄文時代の到来 \- portal shit\!](https://portalshit.net/2020/09/04/the-internet-jomon-period). [個人サイトについて](https://r7kamura.com/articles/2020-09-21-personal-website)
[^copy]: おたより機能は、@secon さんのサイトのアイデアをそのままパクりました。素敵なアイデアをありがとうございます。
