---
title: "いつのまにか、Obsidian のPDFビューアーのCJK文字が文字化けする問題が解消されていた"
date: 2023-06-13T23:18:27+09:00
lang: ja
author: Shunya Ueta
tags:
  - obsidian
---

以前は、Obsidian が提供する PDF ビューアーは CJK の文字がまともに表示されず[^cjk-obsidian]、日本語表記の PDF は使い物にならなかった。
だが、この前 PDF を Obsidian にアップロードすると、いつのまにか CJK 文字が壊れずに読めるようになっていた...!

![](/posts/2023-06-13-2318/images/obsidian_cjk_pdf_viewer.png)

v1.3.0 から PDF ビューアーが刷新された[^obsidian-1-3]らしいのでその影響だろうか? これは嬉しい修正です。

[^cjk-obsidian]: https://forum.obsidian.md/search?expanded=true&q=%23bug-reports%20CJK
[^obsidian-1-3]: [Obsidian 1\.3\.0 Desktop \(Catalyst\) \- Obsidian](https://obsidian.md/changelog/2023-05-09-desktop-v1.3/)
