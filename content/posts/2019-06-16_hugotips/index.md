---
title: "Hugo Tips"
date: 2019-06-16T23:09:18+09:00
lang: ja
tags:
- hugo
---

Hugo 0.32から page bundleが使用可能に。この機能で画像ファイルを以下のファイル構成で構築できる
これにより、markdownとアセットファイルが同一ディレクトリ内に収まるのでアセットファイルの管理が用意になる。

> https://gohugo.io/about/new-in-032/

```bash
- hoge/
    - index.md
    - hoge.png
```

- `hugo new` で特定のエディタを開く

```bash
hugo new posts/hoge.md --editor="code"
```

- pange bundl作成時にディレクトリ名に日付を含める

```bash
hugo new posts/$(date '+%Y')-$(date '+%m')-$(date '+%d')_mlct10/index.md
```
