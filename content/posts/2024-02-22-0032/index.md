---
title: "運用コストを低く抑えつつ全文検索機能を実現したい: SQLite3 で全文検索を実現する fts5 、ベクトル検索を実現する sqlite-vss"
date: 2024-02-22T00:33:03+09:00
lang: ja
author: Shunya Ueta
tags:
  - search
  - sqlite
  - go
---

- ドキュメント数が 1 万件に満たない状況で全文検索をしたい
- ドキュメントは頻繁に更新はされずに日時の更新で十分
  - オンラインでのインデキシングを考えなくてよいので、バッチで十分

みたいな状態でポータビリティが高く運用コストが低い状態で全文検索を実現したいなと調べていたら SQLite3 が良さそうだったというお話。

- 全文検索を実現する拡張機能: https://www.sqlite.org/fts5.html
  - fts5 から relevancy による order by が使えるようになったらしく、version 4 以前は、relevance をチューニングして改善するのは難しそうだなと思った。この拡張機能が作成された経緯としては、LIKE 検索で検索機能を提供しようとして、パフォーマンスでの問題が出たので作成されたらしい
  - [SQLite で Lindera を使った日本語全文検索 \- \*iroi\*](https://blog.chairoi.me/entry/sqlite-fts-lindera) : この記事は実際にデモが公開されていて、非常に良い記事。全く問題ない速さですね
  - Go で実現したい場合は、[Add working examples of full\-text\-search of SQLite3 by KEINOS · Pull Request \#309 · ikawaha/kagome](https://github.com/ikawaha/kagome/pull/309) の sample code が非常にわかりやすかった
    - kagome を見ていたら、PR できる機運を見つけたので２つ PR を作ったら爆速マージされていて最高でした https://github.com/ikawaha/kagome/commits?author=hurutoriya
- ベクトル検索を実現する拡張機能: https://github.com/asg017/sqlite-vss
  - faiss をもとにしたベクトル検索拡張機能

furusawa さんの書いている、いつ全文検索エンジンが必要かという基準は面白いですね。
[新規サービスの検索システム立ち上げ時に考慮すること \#サービス \- Qiita](https://qiita.com/rilmayer/items/f13c17b3f85b9bdbb302)

Cookpad さんの[人気順検索の Solr はスケールのためにディスクを捨てた \- クックパッド開発者ブログ](https://techlife.cookpad.com/entry/2020/11/25/080000)もバッチ更新で十分で割り切ってしまうという思想は今回の記事のモチベーションに近しいものがありますが、全文検索サーバーを運用したくはないのでスコープ外です。

fts は深堀りする機会がでれば、メモ代わりにどんどん公開していきます。
