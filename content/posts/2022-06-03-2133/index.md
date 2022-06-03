---
title: "愛用しているツールを更新: Joplin→Obsidian & TickTick → Todoist"
date: 2022-06-03T21:33:01+09:00
lang: ja
author: Shunya Ueta
tags:
  - note
---

## ノートアプリを Joplin から Obsidian へ

2021-03-13 に notion から joplin に乗り換えた。 理由としては

- notion を マークダウンのメモ帳としか使わない
- DB 機能やテンプレート機能は必要としていない  
  なのでロックインされずに自分で管理できる OSS の joplin のほうが良いなと思って乗り換えました。 必要な機能は全て満たしてるので満足

と Joplin に乗り換えて大きな不満は無く使い続けていたのですが、Obsidian に乗り換えました。

きっかけは ryuzeee さんの記事[^ryuzee] なんですが、以前から存在は知っていた[Obsidian](https://obsidian.md/) をとりあえず食わず嫌いせずに触って見ようかと思い立ち、[Joplin](https://joplinapp.org/)の記事を Obsidian のフォーマットにすべて変換[^joplin-exporter]して使い始めてみたところ、とても心地よい使い心地で感動して乗り換えを決定した。

元の Joplin がそもそも Obsidian と同じローカルのプレーンテキストを扱うという思想なので移行がとても簡単でした。

乗り換えを決めた点として、

daily note プラグインと Calendar プラグインで日誌がめちゃくちゃ快適に書けるようになった。自分は日誌という形でログを残しつつ作業をしているのだが、このプラグインで毎日の日誌の記入がとても快適になった。
ぷーおんさんが書いてくれている記事[^obsidian-dairy]が、このプラグインの魅力をわかりやすく紹介されています。

またバックリンクの機能がやはり強力で、プラグインも PKM(Personal Knowledge Management) を目的に作成されたツールが多いので、それも気に入った。(ランダムノートを開いて、ノートを整備する機能はなるほど!となる便利さ)

Joplin でもバックリンクのプラグインはあり使っていたが、Obsidian のバックリンク機能は比較してとても完成度が高い。バックリンクを使った繋がりの提案や、つながりが無いノートも見つける機能があったりと書いていて楽しい。

また、自分は料理を良くするのだが、普段参照するレシピも PKM で管理することで有機的な管理ができるようになりとても楽しい。これぞ PKM という事例だなとしみじみ。

[logseq](https://logseq.com/)というアプリも気になったのだが、アウトライナーアプリで、自分は文章として作成したいので今回は Obsidian を選んだ。

一つ困った点としては、Joplin では Dropbox 経由で Mac と Android 間でノートを同期できていたのだが、Obsidian では Dropbox を使った同期ができなくなった。
だが、スマホでメモを見たくなる用途は主にレシピを見たいときだけだった。どうしても我慢できなくなったら頑張ってデバイス間同期をしてみる。

今使っている Pixel 4 XL から次は iPhone に戻る予定なのでその時は iCloud で同期すれば大丈夫になる。

ロックインも結局の所、エクスポートさえできれば大丈夫だなと楽観的な考え方に落ち着きました。Joplin も Obsidian も 10 年後存在しているかは不明だが、元になるプレーンテキストさえあれば大丈夫でしょう。

## Todo 管理アプリを TickTick から Todoist に戻した。

https://shunyaueta.com/posts/2022-03-13/

の記事で、長年愛用した Todoist から TickTick に乗り換えた話をしたが、期待していたカレンダーベースのタスク管理が全く自分の要求を満たさず[^ticktick-badpoints]、テンションが下がっていたときに Todoist から「値上げをするけど、今購読してくれたら購読継続してくれる限りは値上げ前をずっと維持するよ」[^todoist]とメールが送られたので、絶好のタイミングでの誘惑を断ち切れず Todoist に戻ることにした。

離れてみてわかる Todoist の使い心地の良さでした。

[^ryuzee]: [アジャイルコーチは Obsidian をどのように使っているか](https://www.ryuzee.com/contents/blog/14568)
[^joplin-exporter]: https://github.com/luxi78/joplin2obsidian Go で書かれた Joplin 形式のマークダウンファイルを、Obsidian 方式の Markdown に変換してくれるツール
[^obsidian-dairy]: [Calendar プラグインで Daily notes は進化する](https://pouhon.net/obsidian-calendar/5996/)
[^todoist]: [2022 Todoist pricing changes](https://todoist.com/help/articles/2022-todoist-pricing-changes)
[^ticktick-badpoints]: アプリとして全体の完成度が低く、強みであるカレンダー統合機能も作り込みが甘くてとても使いづらかった。例えばカレンダーのスケジュール招待を辞退しても、カレンダーにはその正体が表示され続ける。またそのカレンダーをデスクトップでも完了状態にすることはできなかった(モバイルアプリだと完了にできる)
