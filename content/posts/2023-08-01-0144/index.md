---
title: "時間計測において、やはりToggl は最高で、なおかつObsidian の Toggl plugin がやっぱり最高だぞというお話"
date: 2023-08-01T01:44:01+09:00
lang: ja
author: Shunya Ueta
tags:
  - obsidian
  - tools
---

最近は作業メモを Obsidian Memos で取るようにした。[^memos]
その、副次的な影響で作業メモを取りながら、working out loud 的に作業がはかどるようになり集中力がました。

Session を導入した経緯としては、時間計測が目的というよりかは集中力を上げて作業をこなしたいというのが主目的だった[^session]が、Memos の導入によって Session を使わなくてもゾーンに入って集中できるようになったと感じている。
実際に Memos を使い始めてから Session を使う頻度が減ってきているので、ツールの断捨離という形で、Session を使うのをやめて古巣の Toggl に舞い戻ることにした。

[2023 年 6 月時点で愛用している Obsidian のプラグイン](/posts/2023-06-17-2335/) でも紹介したが、Toggl に戻ったことで Obsidian の Toggl プラグインが活用できるようになった。

[GitHub - mcndt/obsidian-toggl-integration: A Toggl integration plugin for the popular knowledge base application Obsidian.](https://github.com/mcndt/obsidian-toggl-integration)

このプラグインが最高にクールで秀逸なのが、Toggl の時間計測の結果を code block 内に Query Languge として記述すると集計して可視化できるところだ。
自分は、この機能とアイデアに惚れ込んで、作者に速攻投げ銭を送ったという過去がある。みんなも感動したら気軽に投げ銭送りましょう!
[mcndt is creating Obsidian plugins to help you be productive](https://www.buymeacoffee.com/mcndt)

この code block で toggl の結果を可視化する方法については公式ドキュメント[^toggle-obsidian]が詳しい。

でだ。
自分が愛用している使い方としては、Daily notes の template にこの code block を埋め込んでおくことで毎日の時間計測結果が地頭的に可視化される点だ。もう最高に便利。

差し込む方法としては

````
```toggl
LIST
FROM {{date}} TO {{date}}
```
````

と書いてやれば、 以下のスクリーンショットのような感じで、その日に Toggl で計測されたデータがリスト形式で日報に表示される。
最高にクール!

![](/posts/2023-08-01-0144/images/obsidian-toggl-integration.png)

Daily notes が `{{date}}` を作成時の日付に自動変換してくれるからこれが実現できます。

蛇足: Session のカレンダー連携機能を利用するために年間 6000 円のサブスクリプションを契約していたが、これで解約できたのでそれも嬉しい。だが、Seesion の作者は個人開発者として、買い切り型ではなくサブスクリプション形式でアプリを提供していきたい。そもそも買い切り型は、アプリの継続的改善やファイナンス的にも非持続的とフォーラムに書いており非常に共感して、応援も込めてサブスクリプションを契約した記憶がある。自分は解約する形になったが、素晴らしいアプリだったのでこれから頑張って欲しい。

[^memos]: [Twitter 形式でメモが残せる Obsidian Memos で 考えるな、書けを体現できるくらい筆が進むようになった](/posts/2023-06-16-1452/)
[^session]: [時間計測アプリを toggl から session へと乗り換えてみた](/posts/2023-02-12-0133/) Session はアプリ単体で見るとものすごく作り込まれていて感動するレベル(特にカレンダーとの統合で、カレンダースケジュールを時間計測対象としてなめらかに取り込むことができる点が素晴らしい)で、その作り込みのお陰で導入当時は集中できていたので、Session に目立って悪い点はなかった。
[^toggle-obsidian]: [Creating Toggl reports inside notes · mcndt/obsidian-toggl-integration Wiki · GitHub](https://github.com/mcndt/obsidian-toggl-integration/wiki/Creating-Toggl-reports-inside-notes)
