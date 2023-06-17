---
title: "2023年6月時点で愛用しているObsidian のプラグイン"
date: 2023-06-17T23:35:58+09:00
lang: ja
author: Shunya Ueta
tags:
  - obsidian
---

僕自身が愛用しているのは

- https://github.com/Quorafind/Obsidian-Memos
  - [Twitter 形式でメモが残せる Obsidian Memos で 考えるな、書けを体現できるくらい筆が進むようになった](/posts/2023-06-16-1452/)
- https://github.com/vrtmrz/obsidian-tagfolder
  - Tag Folder は、ノートをどこのディレクトリに置くべきかの思考過程を完全に消し去ってくれるプラグインです。作成したノートを意味のあるようにディレクトリ構成で振り分けていくのは、Obsidian の持ち腐れだと個人的に思っています。ノートの振り分けはひたすらタグで管理しましょう。
  - #wip タグなどをつけておくと例えば、書きかけのノートの印などにもなるので便利です。以前は WIP という prefix をタイトルに付けて検索に出るようにしていましたが、タグの方が遥かに楽です。Obsidian editor 上でのタグのサジェスト体験が心地良いのもタグを有効活用できる一因ですね。
  - 自分は[\[Obsidian\] TagFolder とタグの使い方に迫る！ \(対談企画 03\)](https://pouhon.net/obsidian-tagfolder/7552/) の記事で Tag の有効な使い方について学ぶことができました。
- https://github.com/blacksmithgu/obsidian-dataview
  - Dataview は僕は最初どうやって使うんだろうかと思っていましたが、前述した Tag folder の導入で tag を記述する習慣ができました。そして Dataview Query Language で特定のタグを一覧表示するように僕は使っています。僕が一覧表示しているタグは、日々作った料理で書き溜めた #recipe や 読んだ #manga などなどを集約して一覧表示に使っています。
- https://github.com/NomarCub/obsidian-open-vscode
  - Obsidian の Editor 機能は code editor と比べると貧弱なので複雑な置換や処理などをしたい場合は VS code 上でノートを開いて処理をしています。これも Obsidian が plain text, markdown ファイルを扱っているからこそできる簡潔さですね。
- https://github.com/hadynz/obsidian-kindle-plugin
  - kindle のハイライト情報を同期して Obsidian 上のノートとして書き出せる。

また、今は使っていませんが感動したプラグインがあるのでここで紹介しておきます。

- https://github.com/mcndt/obsidian-toggl-integration
  - Toggl (時間計測アプリ) を使っていたころ、計測した時間を SQL のように書いておきそれが日々の日誌のグラフとして描画しておける。(今は session という別の時間計測アプリにうつったので残念ながら使ってはいませんが、投げ銭してしまうくらいには感動したプラグインです。Obsidian の Query Language によって特定の結果をコードブロック上に描画するという発想は素晴らしいアイデアですね。
    - ![](/posts/2023-06-17-2335/images/toggl-obsidian.png)
