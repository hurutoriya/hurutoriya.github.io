---
title: "Java の memory map を理解する"
date: 2022-08-22T13:00:43+09:00
lang: ja
author: Shunya Ueta
tags:
  - java
---

Apache Lucene のインデックスの取り扱いについて勉強していたら、 Java の memory map について言及されていたが、Jave の memory map[^mmap1] について日本語で分かりやすく解説されている記事がなかったので、勉強がてらまとめた。
メモリマップ自体の説明はこちらのサイトが非常にわかりやすかった[^mmap2]

> mmap はファイルとメモリーアドレスのマッピングを行う

つまり、ファイルをメモリ上にマップ(射影)してメモリ上でファイルを扱えるようにするということですね。
Apache Lucene の使用例だと、Lucene の検索用のインデックスファイルを MMap でメモリ上にマップして扱えるようにしていそう。

参考にしたのは上記２つの記事がわかりやすい記事だった。

Java プログラムに関連するメモリは 4 部分から構成される[^java-memory]

- Stack: メソッドが呼ばれた際に、Stack はメソッドを完了させるためのメモリ空間を提供する。この空間はパラメータやローカル変数、現在のオブジェクトへの参照などが格納されている。Frame はメモリ空間を参照し、メソッドの呼び出しをサポートする。Stack は LIFO(Last in First out)方式で動作し、呼び出し基のメソッドの Stack frame を削除するために最後の Stack frame(現在実行中のメソッド) を削除する必要がある。
- Heap: Java で作成されるオブジェクトは全て Heap で作成される。
- Static Area: プログラムの実行中に存在する値を格納するメモリを参照する。静的な変数を宣言した際に、この領域に存在する。
- Code: 実行されるコードが格納される場所。

中でも Java の Memory mapped file は、メモリから直接ファイルにアクセスするのに役立つ Java の特殊ファイル[^java-mmap]。 Java は、`java.nio` パッケージで Memory mapped file をサポートしている。
Memory mapped I/O は、ファイル システムを使用して、ユーザーから直接ファイルシステムページへの仮想メモリマッピング(virtual memory mapping)を確立する。Memory mapped file は単純に大きな配列として扱うことができ、Memory mapped file に使用されるメモリーは、Java の Heap 空間外部が利用される。

indeed のブログ[^indeed-mmap]で JDK が提供する mmap の欠点についても語られておりそれも面白い。

[Python メモリマップファイルを試す \- Emotion Explorer](https://emotionexplorer.blog.fc2.com/blog-entry-164.html) の記事で

> ファイルメモリーマッピングなんて昔からあったけれど、使ったためしがない。
> ずっとデータ構造で処理するようにしていたので特に使う機会がなく、ファイルでも SQL データベースばかりだったので、
> ビューとか使えばいらないかな。正直、私は今後も使わないかなと思う次第です。

と書かれていたが、たしかに Lucene のようにファイルに対する処理を行いたい場合が最も効果を発揮しそうですね。

[^mmap1]: [mmap \- Wikipedia](https://ja.wikipedia.org/wiki/Mmap)
[^mmap2]: [第 68 章 ファイルとメモリーのマッピング \(mmap\)](https://mkguytone.github.io/allocator-navigatable/ch68.html)
[^java-mmap]: [What is Memory\-Mapped File in Java? \- GeeksforGeeks](https://www.geeksforgeeks.org/what-is-memory-mapped-file-in-java/)
[^java-memory]: [Memory Maps / Diagrams](http://www.cs.umd.edu/~nelson/classes/resources/MemoryMapsInformation/MemoryMapsInformation.pdf)
[^indeed-mmap]: [util\-mmap でメモリマッピング \- Indeed エンジニアリング・ブログ](https://jp.engineering.indeedblog.com/blog/2015/02/util-mmap-%E3%81%A7%E3%83%A1%E3%83%A2%E3%83%AA%E3%83%9E%E3%83%83%E3%83%94%E3%83%B3%E3%82%B0/)
