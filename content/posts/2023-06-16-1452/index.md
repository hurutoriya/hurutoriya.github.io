---
title: "Twitter 形式でメモが残せる Obsidian Memos で「考えるな、書け」を体現できるくらい筆が進むようになった"
date: 2023-06-16T14:52:42+09:00
lang: ja
author: Shunya Ueta
tags:
  - obsidian
---

Obsidian-Memos という Obsidian のプラグインを Twittier で見かけて[^twitter]ためしてみたら、Obsidian が更に便利になったので紹介。

https://github.com/Quorafind/Obsidian-Memos

以下、こんな感じで daily journal に list or task 形式で書き出されていく

Memos の画面

![Memos in PC](/posts/2023-06-16-1452/images/Memos-pc.png)

`Daily Note` にはこんな感じで書き込まれる。

![Memos in daily note](/posts/2023-06-16-1452/images/Memos-in-daily-note.png)

これらの内容は以下のような形式で `Daily Note` にリスト or タスク形式で書き込まれていく。

```markdown
- 01:25 Memos を入れてみた、しばらく試してみる
- 01:25 書きなぐるようにメモれるのは楽かも、time stamp が横につくのも良い
- 01:28 内容的には、独自ファイルが作られるのではなく、perse して diary jornal を読み取っている? どっちにせよこれはメモを取りやすいし、diary jornal に全て集約して timestamp を付与できるのは可能性を感じる 編集したらどうなる? ^1ycr7q
```

## 気に入った点

- 実装として、Memos で投稿した内容は、Memos の投稿ごとに独立した markdown ファイルが作られるのではなく、perse して`Daily Note` を読み取って、Memos を構築している模様。これがめちゃくちゃ良い。つまるところ Memos は単なるインターフェースで投稿した内容は全て`Daily Note` に結合されて素のプレーンテキストとして管理できるし、日誌が完成されていく。なんか火星の人の Log entry みたいで気に入った。
- 書きなぐるようにメモれるのは楽だし、time stamp が横につくのも良い。Memos を使ってみると意外と今までの `Daily Note`よりも気軽に文書を掛けていることに驚いた。
  - これは Duck の作成経緯[^duck]で書かれていた内容に近いのかも知れない。チャット?というかツイッター形式のほうが Work Out Loud 的にガンガンメモとして書き残していける。インターフェースって大事なんだな。
  - つかってみて気がついたが、Memos のような Twiter 形式だと気軽に書けるが、逆に素のマークダウンだとなんかいい文章を書いてやろうとかかっこつけたがる自分がいたんだなと今更ながらに気がついた。この UI の制約によって逆に筆が進むのは非常に面白い。
    - また、改行とかしてちゃんとした文書を書こうとすると、おっとちゃんと文章を書く前にまず書きなぐれと意識ができるようになった。
- モバイルも完全に対応しているので、スマホからも気軽にタイムスタンプを付与しつつメモを残せるようになった。敷居が下がるとどんどんメモの量が増えていく傾向にある気がする。最高

  - ![Memos in Android](/posts/2023-06-16-1452/images/Memos-android.png)

- Memos の投稿は HOT KEY を設定可能なので、自分は `Cmd + Shift + Enter` で投稿できるように設定した。デフォルトだと毎回ボタンをポチらないと投稿できないので、設定したほうが気軽に投稿できます。
  - `2023-06-17 追記` おたよりでおしえていただきましたが、デフォルトだと `Cmd + Enter` で投稿できるみたいです。自分の場合、他の機能で既に割り当てているので衝突しまっていたみたいです。僕も`Shift`を毎回押すのはつかれるので、僕もこの設定にしました。ありがとうございます。

## 改善できるかもと思った点

- ~~Memos 内では、タグは Obsidian のノートのようにサジェストされないのは唯一改善をしたい点。あくまで Memos で利用されたタグのみがサジェストされる~~
  - ~~これは issue とかで提案したい。でも、設計思想としては理解できる。それ以外はこれはかなりいいプラグイン。~~
  - `2023-06-17 追記` おたよりで知りましたが、プラグイン設定内に "Use tags in vault" という設定項目があり、これを ON にすると既存のタグをすべて参照できるみたいです。便利になりました! ありがとうございます!!
- また、Obsidian の native editor ではなく独自 editor も変更できないかなと思ったが、Memos 自体が複雑な文章を書くための考えではないので、たしかに単純なことしか書けなくするのは哲学として良い。

というわけでしばらく使ってみます。今のところものすごく快適です。
感動すぎて作者の Buy Me a Cofee 宛に投げ銭をしておいた[^bmc]。

特に、モバイルからのメモ書きがめっちゃ捗るようになった。

[^bmc]: https://www.buymeacoffee.com/boninall で投げ銭できます。
[^twitter]: [vorotamoroz aka きみのぶさんは Twitter を使っています: 「これ本当に神ですごく嬉しい。 https://t\.co/yjDoTooMba」 / Twitter](https://twitter.com/vorotamoroz/status/1669315863777021954)
[^duck]: [メルカリを退職し、個人で Web アプリを作りました \- urahiroshi の日記](https://urahiroshi.hatenablog.com/entry/2023/04/25/132958)
