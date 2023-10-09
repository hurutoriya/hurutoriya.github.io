---
title: "Obsidian でプラグインをビルドする"
date: 2023-10-10T00:10:20+09:00
lang: ja
author: Shunya Ueta
tags:
  - obsidian
---

今でも Obsidian Memos [^memos] を愛用している。
そしてリポジトリの README を見ていると Version 2.0 をテストできる[]とのことで、メールで連絡したところ開発者の[Boninall](https://github.com/Quorafind)さんから返信があり、無事に Obsidian Memos 2 系をテストできることになった。

その際に zip ファイルで 2 系のファイルを共有してもらったのだが、どうやって動かせばいいのか少し手間取ったので、配布されたプラグインをビルドする方法をメモしておく。

基本的には Obsidian の公式ドキュメント [^build] に従えばよい。

まずは、配布されたプラグインのソースファイルが格納されているディレクトリに、Obsidian の Valut 配下のプラグインディレクトリにコピーする

```shell
cp -r obsidian-memos-2.0.12 ../Valut/obsidian/.obsidian/plugins
```

その後、Obsidian の設定画面に移動し、Community plugin 画面でプラグイン一覧画面をリフレッシュ後に目的のプラグインが表示されていれば完了。

モバイルでの読み込みは、Deblug オプションをオンにして確認してみたが、かなり高速化されている。
一般公開される日が待ち遠しいですね

[^memos]: https://github.com/Quorafind/Obsidian-Memos Memos 2.0.x is ready for test, if you are interested in it, please contact me @Boninall via Obsidian discord OR mail: [Bonopengate@gmail.com](mailto:Bonopengate@gmail.com)
[^build]: [Build a plugin \- Developer Documentation](https://docs.obsidian.md/Plugins/Getting+started/Build+a+plugin)
