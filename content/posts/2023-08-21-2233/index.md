---
title: "さよなら Todoist、よろしく todo.txt"
date: 2023-08-21T22:33:26+09:00
lang: ja
author: Shunya Ueta
tags:
  - tools
---

[愛用しているツールを更新 Joplin→Obsidian & TickTick → Todoist](/posts/2023-08-21-2233/) では、Todoist の有料契約に戻った話をした。

Todoist の有料契約していたのは、

- プロジェクト数の制限があったのと
- 今まで使い続けていた
- Todoist というプロダクトの事業譲渡は絶対しない。[^no-exit]
  この会社は Todist という最高のプロダクトを作っているのでお布施代わりに有料契約した。

だが、最近ふと思ったのが、Todoist は Todo アプリのプロダクトとして非常に素晴らしいが自分はその機能郡を使いこなせていないなと感じた。

改めて自分が TODO アプリに求める機能要件は洗い出してみると３つだった。

- 日付設定可能
- 優先順位付け可能
- 再帰的なタスクを設定可能
  - 毎年、毎月など定期的なタスクを設定したい

なので、Todoist が提供している素晴らしい機能である

- コメント機能
- 無制限のファイルアップロード機能
- コラボレーション機能
- Geo ベースのリマインダー
- カンバン表示機能

などなどが、自分には必須ではないことがわかった。

また可能なら利用する身としては

- OSS
  - 究極的には、アプリが死んでも自前で運用できる
  - また気に入らなければカスタマイズしたり PR を送ったりと自分も貢献できる
  - マルチプラットフォーム
    - 自分は Android, Mac を普段から使うので、各プラットフォームで使えるアプリがあれば嬉しい。
    - 以下で言及しているプレインテキストでのデータ管理は、このマルチプラットフォームでの利用を劇的に簡単に実現できる。
      - よく利用されているのが、Dropbox で特定フォルダを同期させれば、それで終わりという単純明快な方法だ。
- プレインテキストでのデータ管理
  - DB を持たず、自前でデータを同期できる。[[Obsidian]]のようにプレインテキストで同期できるなら最高。サ終してもデータは自分のものだ、他者のものではない。
  - この考えは Obsidian を使い始めてから強く持つようになった。Obsidian の CEO の Steph Ango さんが書いたブログ記事は非常に良いのでぜひ読んでほしい
  - [File over app — Steph Ango](https://stephanango.com/file-over-app)
    > *File over app* is a philosophy: if you want to create digital artifacts that last, they must be files you can control, in formats that are easy to retrieve and read. Use tools that give you this freedom.

上記の条件で探していたら、該当するアプリが 1 つあった[^tasktxt]。

[Todo\.txt: Future\-proof task tracking in a file you control](http://todotxt.org/)

また、このタスク管理のスペックは GitHub で公開されており、誰もがこのスペックに準拠した上でアプリを作って公開できる。

[todotxt/todo\.txt: ‼️ A complete primer on the whys and hows of todo\.txt\.](https://github.com/todotxt/todo.txt)

実際に、様々な開発者が todo.txt のクライアントを作っている。素晴らしい。完全に要件を満たしている。

todo.txt の開発経緯の記事を発見したが、今でもこのモチベーションは生きているの素晴らしくないですか?

> Remember the Milk や Simplenote では、アプリの読み込みや同期、接続チェックで待たされ、その間にふと別のことが気になって、本来仕事に充てるはずの時間をロスしてしまう面がありました。例えば「自分のツイートに誰か返信してくれたかも」と思ってツイッターに移動してしまう……といった具合です。その点、Todo.txt は、**Android であれ、iOS デバイスであれ、瞬時に使えます**。もちろん、コンピュータ上のテキストファイルもすぐに開けます。コマンドラインのインタフェースで、操作も楽チンです。
> 　[『Todo\.txt Touch』はシンプルなテキストベースの To\-do リストアプリ \| ライフハッカー・ジャパン](https://www.lifehacker.jp/article/120119todotxt_touchios/)

11 年以上前からこの思想があり、巡り巡って 11 年経って自分が同じような不満点を持つとは思いませんでしたが、人類考えていること一緒ですね。

また、再帰的なタスクはスペックでは定義されていないが、各種クライアントでは再帰的なタスクを実現するための方言[^recurring-task]を作っており、それを使えば再帰的な TODO を管理できる。

ちなみに自分は、Aditya Bhaskar さんという方が開発している以下の２つのアプリを利用させてもらっている。前述した再帰的なタスクをこのクライアントなら実現できるからだ。

- Android: [Todo\.txt for Android \- Google Play のアプリ](https://play.google.com/store/apps/details?id=net.c306.ttsuper&hl=ja&gl=US)
- Chrome 拡張: https://chrome.google.com/webstore/detail/todotxt-for-chrome-simple/mndijfcodpjlhgjcpcbhncjakaboedbl

余談だが、Mac のクライアントは [ransome1/sleek: todo\.txt manager for Linux, Windows and MacOS, free and open\-source \(FOSS\)](https://github.com/ransome1/sleek) という React ベースのモダンなアプリがあったので最初に使ってみたが、タスクが何故か追加されないというバグに遭遇したので使うのをやめた。今後に期待したい。

## 結論

FOSS、Plain text as DB という概念で実現された todo.txt は最高なので乗り換えた。

[愛用する時間計測アプリで Session から Toggl へと舞い戻ったのと、 Obsidian の Toggl plugin がやっぱり最高だぞというお話](/posts/2023-08-21-2233/) でも購読型のサービスをやめたが、これで年間 9000 円程度浮いたことになる。

購読型のサービスは気がつくと積み上がっているので、本当にお金を払わないと実現できないというというプロダクトにガンガン投資していきたい[^sekiyuo]。
今のところはそれが 1Password だ。

[^tasktxt]: [TaskTXT](https://tasktxt.com/) というモダンなアプリもあったが、これはマルチプラットフォームではなかったので除外しました。
[^recurring-task]: https://updatenotes.blog/todotxt-recurring-tasks/
[^sekiyuo]: 石油王になれば好きなプロダクトにガンガン投資したいのだが... しがないサラリーマンなので、厳しい世界です。BuyMeaCofee なんかの一発限りのワンショット投げ銭は躊躇なく行っているんですが...
[^no-exit]:
    とくにこの思想は痺れる。資本主義からの脱却! 一生使える タスク管理ツール
    。[Why We Don’t Have an Exit Strategy](https://blog.doist.com/no-exit-strategy/)
