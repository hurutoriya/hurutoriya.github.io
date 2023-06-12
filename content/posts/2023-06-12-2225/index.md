---
title: "Google Formの入力欄を自動的に入力済みにするために、Hugoのテーマを改造して、パーマリンク変数をクエリストリングとして事前入力内容にすることで実現した"
date: 2023-06-12T22:25:38+09:00
lang: ja
author: Shunya Ueta
tags:
  - hugo
  - blog
---

[禅の気持ちで心穏やかに記事を書くためにブログのコメント機能を廃止して、おたより機能を開始してみる](/posts/2023-06-12-0113/)で述べたようにおたより機能を Google Form で実現したが、その際におたよりに該当する記事の URL を必須入力として置きたいと思ったが、これをおたよりを書いてくれる人に要求するのは相当めんどくさいと自分では思っている。

確実に自分だったら、え、めんどくさい、おたよりかくのやめようとなる

この書いてくれようとした人の離脱はなんとしても阻止したい。

調べてみたら、Google Form の事前入力機能[^preinput]というものがあり、それを使えばクエリストリングとして値を渡せば Google Form の事前入力が可能になる。

これを Hugo のテーマ上でそのページのパーマリンクを埋め込んでやればいい

やり方としては、事前入力された Google Form の URL を取得して

```diff
- 記事への感想などの<a href="https://forms.gle/g4rNMwPL799uHXQg7">おたより</a>をおまちしてます。
+ 記事への感想などの<a href="https://docs.google.com/forms/d/e/1FAIpQLScgZVDrjQiKLbQRovfs88oweCITzjtvt1PlgwL14JfWPOrpPQ/viewform?usp=pp_url&entry.838298670={{ .Permalink }}">おたより</a>をおまちしてます。
```

と書いてやればヨシ。

Hugo の`{{ .Permalink }}` 変数を Google Form の クエリストリングにわたすことで、おたより対象の記事の URL を自動的に入力できるようになりました。

Google Form の事前入力機能は知りませんでしたが、これは便利ですね。

[^preinput]: [フォームを送信する \- Google ドキュメント エディタ ヘルプ](https://support.google.com/docs/answer/2839588?hl=ja&visit_id=638221725795420512-25436235&rd=1#zippy=%2C%E5%9B%9E%E7%AD%94%E3%82%92%E4%BA%8B%E5%89%8D%E5%85%A5%E5%8A%9B%E3%81%97%E3%81%9F%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A0%E3%82%92%E9%80%81%E4%BF%A1%E3%81%99%E3%82%8B), [あらかじめ任意の値を埋め込んだアンケートフォームを量産しよう \- takeda_san’s blog](https://takeda-san.hatenablog.com/entry/2020/10/24/162454)
