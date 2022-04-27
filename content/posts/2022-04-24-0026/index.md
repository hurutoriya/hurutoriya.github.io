---
title: "slug の作成パターンを変えて、同日に複数の記事を執筆できるようにした"
date: 2022-04-24T00:26:07+09:00
lang: ja
author: Shunya Ueta
tags:
  - blog
---

slug とは、URL 末尾の識別子のこと[^slug]で、hugo では自分だと記事を書く際に Makefile で以下のコマンドで作成していた。

```Makefile
new: ## Make new post with date as slug
	hugo new posts/$(shell date '+%Y-%m-%d')/index.md
```

いろんな考えがあるが、自分は slug の作成時に頭を全く使いたくないので、以前から`date` コマンドを使って`YYYY-MM-DD`の形式で slug を作成している。
SEO などのために、slug にタイトルを入れるパターンもあるが、記事の作成の流れとして自分は、

1. ドラフトを `hugo new` で作成。この時点でタイトルはまだ確定していない
1. 書き上げていくうちにタイトルを最終決定

なので、タイトルは slug に含めない派。

だが、従来の `date '+%Y-%m-%d'` の欠点として同日に複数の記事を作成すると衝突してしまうと問題があった。
今まではそれを避けるために、メモ帳に下書きを書いてあとからコマンドを打って記事を作成して対処していた。

が、それもめんどくさいと感じたので、

`date '+%Y-%m-%d'` → `date '+%Y-%m-%d-%H%M'`

にして、 date コマンドに時間と分数を末尾に追加するように slug 作成コマンドを変更した。

これで、同じ日に複数の記事を書けるようになった。

[^slug]: [Why ‘slug’ and not ‘permalink’](https://discourse.gohugo.io/t/why-slug-and-not-permalink/36359)
