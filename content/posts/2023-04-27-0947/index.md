---
title: "Obsidian 上で画像の大きさを調整する方法"
date: 2023-04-27T09:47:18+09:00
lang: ja
author: Shunya Ueta
tags:
  - obsidian
---

Obsidian で画像を貼り付けた際に、元の画像が大きいせいで極大ドデカ画像になって小さくしたいときが多々あります。

サッと大きさの調整ができないかなと探したら、公式で提供されていた[^image]のでメモっておきます。

が...この記事を書いた後に Minerva さんで詳細な記事[^minerva]が書かれていることが発覚しましたが、まぁ自分への備忘録もあるのでこのまま公開します。

Obsidian はここらへんのちょっとした操作が、Markdown 内で完結するように公式で提供されているのは素晴らしいですね。

自分は `![[hoge]]` でノートを埋め込んで表示できるようにしているところは本当に頭がいいなと感動して使っています。
これぞ Obsidian が構造化して、モジュラー構造でノートを書ける由縁ですね。

[^image]:
    > Take the link, add ‘|’ sign towards the end and write a number.
    > Eg. : `![[image.jpg]] to ![[image.jpg|300]]` > https://forum.obsidian.md/t/resize-image/6517/8

[^minerva]: [画像サイズを指定したい \- Minerva](https://minerva.mamansoft.net/%F0%9F%93%97Obsidian%E9%80%86%E5%BC%95%E3%81%8D%E3%83%AC%E3%82%B7%E3%83%94/%F0%9F%93%97%E7%94%BB%E5%83%8F%E3%82%B5%E3%82%A4%E3%82%BA%E3%82%92%E6%8C%87%E5%AE%9A%E3%81%97%E3%81%9F%E3%81%84)
