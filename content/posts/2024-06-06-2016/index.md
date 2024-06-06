---
title: "Python x SQLite3 x sqlite-vec で近似近傍探索をやろうと思ったが..."
date: 2024-06-06T20:16:45+09:00
lang: ja
author: Shunya Ueta
tags:
- search
- sqlite
- 検索エンジンOSS勉強会
- python
---

[全文検索エンジン Bleve で日本語形態素解析をおこなう](https://zenn.dev/ikawaha/articles/20240324-5f5a051ee203c7) で bleze x kagome が気になってやろうとしたが、どうせなら一捻りしたいなと思い、Goの全文検索ライブラリである blevesearch の最新リリースを眺めていると

https://github.com/blevesearch/bleve/releases/tag/v2.4.0

`v0.2.4` からvector serach が可能に backend は faiss。
テンションが上ったので、最初は、kagome x blevesearch x ANN の構成で vector indexing, query のベクトル化もGo 言語かつ検索サーバーを運用しないで完結する構成による近似近傍探索をやろうと思っていた。。。が、文章をベクトル化するお手軽な方法(Python だとが Go で見つけられなかった。

同じモチベーションらしきGoライブラリ

- https://github.com/knights-analytics/hugot Go で書かれた Hugging face transformer pipeline
- https://github.com/hupe1980/go-huggingface Go で書かれたHugging face の推論クライアント


なので、GoにこだわらずにPythonでやってみようと思い模索してみた。

[運用コストを低く抑えつつ全文検索機能を実現したい- SQLite3 で全文検索を実現する fts5 、ベクトル検索を実現する sqlite-vss](/posts/2024-02-22-0032/) でも書いたが、全文検索機能の運用は辛いことが多い。なので、

- 検索対象のデータは頻繁に更新しなくても問題ない
	- ストリーミングでの更新(online indexing)はせずに、バッチ処理で完了
- ドキュメント対象は大規模ではない
	- 状況にもよるが10万件以下が目安ではなかろうか

上記の条件では専用の全文検索サーバーを運用することなく実現できそうなアプローチがいろいろある。

実例では、APIサービスケンオールのアーキテクチャの内容がドンピシャだ
- [対外発表資料 \- DjangoCongress JP 2022 \- Google スライド](https://docs.google.com/presentation/d/1nLQS8-U36eNa2uRTj1fONtmI5HaItFJcIrw90ixmo_8/edit#slide=id.g1872e3e8b25_0_7)
	- ![](/posts/2024-06-06-2016/images/sqlite3.png)
	- ![](/posts/2024-06-06-2016/images/tantivy.png)
- [\[DjangoCongress JP 2022\] APIサービス「ケンオール」のアーキテクチャ \- YouTube](https://www.youtube.com/watch?v=0PB7_UKD-RM)

当時この取り組みを見たときに、なるほど! 検索でもOnline indexing が不要な状況もあるよな、頭いい!! と感動して Twitter で yomo さんと議論した思い出があります。

どうやら以前注目した [asg017/sqlite\-vss: A SQLite extension for efficient vector search, based on Faiss\!](https://github.com/asg017/sqlite-vss) のパッケージは後述で説明しますが問題を抱えていたらしく、それを解決するために同じ開発者によって [asg017/sqlite\-vec: Work\-in\-progress vector search SQLite extension that runs anywhere\.](https://github.com/asg017/sqlite-vec) が後継が作られたとのこと。

あと `sqlite-vec` からは WASMでも動くらしいので web サイト上で demo が動いていてすごい

[I'm writing a new vector search SQLite Extension \| Alex Garcia's Blog](https://alexgarcia.xyz/blog/2024/building-new-vector-search-sqlite/index.html)


主要な改善点としては、
- C++で書かれていたvss をCで書き直す
	- Mac, Linux だけだったのが、Linux, Mac, Windows とすべてのプラットフォームで省メモリで動く
- faiss に依存していた近似近傍探索機能をスクラッチで実装している

問題点は翻訳したものを載せると下記

```
> Though initially, `sqlite-vec` will only support exhaustive full-scan vector search. There will be no "approximate nearest neighbors" (ANN) options. But I hope to add IVF + HNSW in the future!

sqlite-vssの開発と採用には、次のような多くの障害がありました。
Linux + MacOSマシンでのみ機能しました（Windows、WASM、モバイルデバイスなどはなし）  
- すべてのベクトルをメモリ内に格納  
- トランザクション関連のさまざまなバグと問題  
- コンパイルが非常に難しく、時間がかかる  
- 一般的なベクトル演算がない（スカラー/バイナリ量子化）  
これらはほとんどすべて、sqlite-vssがFaissに依存していたためです。 多くの時間とエネルギーがあれば、これらの問題のいくつかは解決できるかもしれませんが、その多くはFaissによってブロックされます。 translate by gemini1.5 Pro
```

だが、現状フルスキャンでの近傍探索であり、近似近傍探索ではない。
なん。。。だと。。。
将来的には近似近傍探索をサポートしたいらしいが、ドキュメント総数によってはそもそもフルスキャンしても問題ない規模が大半だろうし、 SQLite 内で完結して近傍探索できるだけでも嬉しいというケースはあるっちゃありそうではある? 
ラズパイとか?ドキュメント全部メモリに載せても問題ない規模などかな?

[Vector search in 7 different programming languages using SQL \| Alex Garcia's Blog](https://alexgarcia.xyz/blog/2024/sql-vector-search-languages/index.html) で書かれていたサンプルコードを基に、手元のデータを対象にして実際にコードを書こうと思ってたんだが、ANNではなく、NNなら手を動かす意義もなさそうなので、ここで完!!