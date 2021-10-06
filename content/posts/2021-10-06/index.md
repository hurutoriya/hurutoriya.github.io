---
title: "Hugo で記事の更新日をgitと連携して自動的に取得して表示させる"
date: 2021-10-06T20:38:58+09:00
lang: ja
author: Shunya Ueta
tags:
- hugo
---

最近昔書いていた技術記事の情報が古くなりすぎて不正確なこともあったので、書き直すときがあったのだが、そのときに自動的に最終更新日を記事に表記できないか探していたら、実現方法があったのでメモしておきます。

やっていることは
[Last Modified Date with Hugo](https://www.andrewjstevens.com/posts/2021/03/last-modified-date-with-hugo/)
の記事をと完全に一緒だが、日本語での情報が無かったので備忘録がてら記録を残す。


Hugo は各ページに関する情報を[Front Matter Variables](https://gohugo.io/content-management/front-matter/#front-matter-variables) という仕組みでMarkdown上に定義します。
主にYAML形式で記述されていることが多いです。

`lastmod` という変数が更新日を表す変数であり、この変数に対して更新日の情報を与えてやれば記事の最終更新日を表現することができる。

Front Matter に `lastmod: "2021-03-31" の形式で与えておけば、以下の形式で記事作成日と最終更新日を表記できる。

```html
{{ $date := .Date.Format "02.01.2006" }}
{{ $lastmod := .Lastmod.Format "02.01.2006" }}

<p>Published on: {{ $date }}</p>
<p>Edited on: {{ $lastmod }}</p>
````

だが、毎回記事を編集するたびに lastmod 変数を追記するのは面倒なので自動化できるなら自動化したい。

`config.yaml` で、以下の設定を行う。

```yaml
enableGitInfo: true
```

`enableGitInfo`を `true`にすることで、各ページに対して[Git情報を更新日として付与](https://gohugo.io/getting-started/configuration/#enablegitinfo)してくれる。

最後に`config.yaml` で以下の設定を行えば、 Front Matter の `lastmod` 変数に対して、 Front Matter で定義されている`lastmod`、もしその情報がなければ各ページの `git`の最終コミット日を返すという設定がされる。


```yaml
frontmatter:
  lastmod:
    - :lastmod
    - :git
```

参考になると思うので、当ブログでの実際の変更点は[こちら](https://github.com/hurutoriya/hurutoriya.github.io/commit/cc2f2916fe87dcad4f300109edc8606700899c72)

テンプレートを上書きするように、`./layout`配下のページを編集した。
hugoの記事でたまに見かけるのがテーマを直接編集している人がいるが、それは筋が良くないやり方なんです。
なぜかというと、hugoの設計はよくできているので、`./layout` 配下に`theme`と同じ構成でファイルを設置すればそちらを上書きする形で参照してサイトを構成してくれるので、元のテーマは何も変更をせずにアップデートが用意になる。
また、拡張性と柔軟性が高まる良い仕組みで、個々人ごとにテーマの編集がしたい必要性に対してよく考え込まれているなと思った。

## Reference

- [Last Modified Date with Hugo](https://www.andrewjstevens.com/posts/2021/03/last-modified-date-with-hugo/)