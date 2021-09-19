---
title: "Pandoc で特定のディレクトリ直下にある複数のWordをMarkdown形式に一括変換する"
date: 2021-09-19T23:52:45+09:00
lang: ja
author: Shunya Ueta
tags:
- pandoc
---

表題の通り、[Pandoc](https://pandoc.org/MANUAL.html) を使って、特定ディレクトリ配下にある複数の Wordファイル(`*.docx`) を Markdownファイル(`*.md`) へ一括変換したい。

## 単一Wordファイルの変換コマンド

単一の変換である場合は、@tomo-makes さんの[Wordファイル(.docx)をMarkdownへ変換する](https://gist.github.com/tomo-makes/b03e910ea7095bbe2c98de5be828dfba) を参考に実行すると良いと思います。

自分は特に困らなかったので、`despan` の処理は省いた形にしました。
また、`--extract-media` をオンにして指定しても Wordファイル内の画像を上手く抜き出せなかったです。
WordファイルからMarkdownファイルへの完全変換って難しい。まさに餅をもち米に戻す行為に近い...

```bash
pandoc -s {input}.docx --wrap=none -t gfm  -o {output}.md
```

## 複数Wordファイルの変換コマンド

ワンライナーのシェルスクリプトを組んで実行する。
実行時には、変換元のWordファイルが配置されているディレクトリで実行する。

```bash
for f in *.docx; do pandoc -s "$f" --wrap=none -t gfm -o "${f}.md"; done
```

`"${f}.md"` の部分を `"../../docs/${f}.md"` のような形で変えてやれば所定のディレクトリへ変換されたMarkdownファイル群を設置される。

## Reference

- [How can I convert a whole directory of files from Markdown to RTF?](https://pandoc.org/faqs.html#how-can-i-convert-a-whole-directory-of-files-from-markdown-to-rtf)