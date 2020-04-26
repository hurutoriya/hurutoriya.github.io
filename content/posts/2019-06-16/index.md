---
title: "Hugo Tips"
date: 2019-06-16T23:09:18+09:00
lang: ja
tags:
  - hugo
---

- [Hugo 0.32](https://gohugo.io/about/new-in-032/)から page bundle が使用可能に
- この機能で画像ファイルを以下のファイル構成で構築できる

```bash
- hoge/
    - index.md
    - hoge.png
```

これにより、markdown とアセットファイルが同一ディレクトリ内に収まるのでアセットファイルの管理が簡単になる

- `hugo new` で特定のエディタを開くには?

```bash
hugo new posts/hoge.md --editor="code"
```

- pange bundl
- 作成時に`slug` に日付を含める

```bash
hugo new posts/$(date '+%Y')-$(date '+%m')-$(date '+%d')/index.md
```

- page をビルドして結果を確認する

```bash
hugo server
```

- 下書きも含めてビルドする

```bash
hugo server -D
```