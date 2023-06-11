---
title: "go-ga-toppages, ga-top-pages-py: 静的サイトジェネレーターで作成したサイトの人気ページをGoogle Analytics(GA4)で集計して、マークダウン形式で書き出すPythonとGoのスクリプト"
date: 2023-06-12T00:30:04+09:00
lang: ja
author: Shunya Ueta
tags:
  - blog
  - python
  - go
  - hugo
---

表題の通り、静的サイトジェネレーターで作成したサイトの人気ページを Google Analytics(GA4)で集計して、マークダウン形式で書き出す Python と Go のスクリプトを公開した。

- Go: [hurutoriya/go-ga-toppages](https://github.com/hurutoriya/go-ga-toppages)
- Python: [hurutoriya/ga-top-pages-py](https://github.com/hurutoriya/ga-top-pages-py)

## 動機

このサイトは、静的サイトジェネレーターの Hugo を使って構築している。
だが静的サイトジェネレーター(SSG)は、アクセスログを利用した人気記事機能を提供しておらず、自分のサイトでも提供してみたいけど、SSG からは公式には提供されない機能... と思っていた。
だが、[フューチャー技術ブログ](https://future-architect.github.io/)さんのサイトを見ていると静的サイトジェネレーターを使っているはずなのに人気記事機能を提供しており、ソース[^souce]をみてみると、あ、そうか自分の Google Analytics のデータを使えばできるんだなと目からウロコの気持ちになり、今回のスクリプトを書いた。

現在は、サイトのトップページにアクセスユーザー数を軸にした 1 年間の人気記事を表示するようにした。

後から見返すと楽しいと思うのでスクリーンショットも以下に残しておく。

![Blog Google Analytics base top ranking page](/posts/2023-06-12-0030/images/blog-ga-top-page.png)

今は、実行結果をクリップボードに貼り付けて、コピペしている。機運があれば CI で定期更新が可能になるように対応してみても面白そう。
非常に満足。

動機としては、@chezou さんの記事や [^chezou] @morygonzalez さんの記事[^morygonzalez]で自分のブログを改造するモチベーションが湧いたのがことの始まりな気がする。

全てが自分でコントロール可能なのは本当に OSS の醍醐味ですね。素晴らしい

## ChatGPT を活用しつつ書いてみた感想

ChatGPT を使いつつ、Google Analytics のデータを基に直近 1 年間の人気記事 top10 記事一覧を作成するスクリプトを作成した。
感想としては、最近のライブラリだとまともにコード生成してくれないし、そのデバッグにあまり馴染みの深くない言語で挑戦すると時間を取られる。

なので、諦めて公式ドキュメントを見て、スクリプトを書いて、適宜追加したい修正を ChatGPT に最小限の大きさで聞いた。
また、プロンプトに GA4 に対応したスクリプトを書きたいと記述しても GA4 に対応するパッケージ自体が GPT の学習対象に入っていないので、GA4 ではない元の Universal Analytics を扱うためのパッケージをひたすら推されて、その判明にも時間を取られたりした。

- 例えば Python で frontmatter からデータを取りたいなどは聞いたら一発で生成できたは楽。
- あとは、一年前の日付を取得したいの要望も一発

Python で書いた後は、Go の勉強がてら、Google analytics に基づいてアクセス数ランキング 1op10 を作成しようとしたら、GCP 関係のパッケージは Python がめちゃくちゃ豊富で、Go は同様のパッケージがそもそも存在しない or 未成熟なことが多く、またあったとしてもそのパッケージに対してそもそもやってきた系統の記事がそもそもなくて驚いた。

ということでまずは、Python で集計スクリプトを書き上げた。なんだかんだ ChatGPT で楽しようとしたら 1n 振り回されて、使うの諦めたら 30m で動かせた。
Rye や Ruu を知り、試しに使ってみましたがノンストレスで使えました。

その後、Go の勉強がてら、慣れた Python で書いた後に、ChatGPT で Go に変換して修正していった。
この方法だと間違った生成はほぼされなかった。

こういう自分のやりたいことのためにコード書くのって集中できるし、何より楽しい。

## 余談

個人的にはポータビリティが高いので、利用形式としては Go の方が圧倒的に好みです。
マシン変わるたびに Rye のインストールとかしたくないですし、Go のインストールのみで終わるのは凄い。
また、発展的に CI に組み込んで定期的に作成したい場合も、圧倒的に Python と比べると Go は楽だと思う。

[^souce]: [フューチャー技術ブログ](https://future-architect.github.io/) さんは[GitHub Pages](https://github.com/future-architect/tech-blog) で運用されているので、どうやって集計されているかも確認できる。
[^chezou]: [3 ファイル追加して GitHub Actions で Hugo にレコメンド記事を表示する \| Democratizing Data](https://chezo.uno/post/2022-01-25-hugo-content-based-recommendation/)
[^morygonzalez]: [ブログの執筆状況を可視化して書くモチベーションを高める \- portal shit\!](https://portalshit.net/2023/05/23/how-to-motivate-blog-writers)
