---
title: "Pandoc を使って抽出できなかったWord内部の画像をGoogle Driveを使って抽出する"
date: 2021-09-27T00:18:26+09:00
lang: ja
author: Shunya Ueta
tags:
  - pandoc
---

[先日の記事](/posts/2021-09-19/) では、pandoc の`--extract-media` オプションをオンにしても word 内部の画像を抽出することができなかった。

だが、Google Drive を使うことで Word 内部の画像を抽出することができたのでここに記しておく。

1. 対象の Word ファイルを Google Drive にアップロードする
2. そのファイルを Google Docs で開く
3. `File → Download → Web Page (.html, zippted)` でウェブページとして zip ファイルをダウンロードする
4. zip ファイルを解凍後、その中にある`images` フォルダに Word 内部の画像が格納されている
