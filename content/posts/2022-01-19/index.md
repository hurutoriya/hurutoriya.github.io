---
title: "GitHub discussion を使ったコメントシステム giscus を導入"
date: 2022-01-19T00:21:05+09:00
lang: ja
author: Shunya Ueta
tags:
  - note
---

Blog にコメントシステムを採用したいなと思って [giscus](https://github.com/giscus/giscus)
を入れてみた。

## 経緯

Blog を読んだ際にコメントするまでではないけど、書いた人に対するシグナルとして、絵文字リアクションという仕組みがとても好き。
Medium だと clap 👏 だったり、はてなだとはてなスター ⭐️ ですね。また Slack や GitHub の emoji reaction も同じ発明だと思う

また、はてぶや Twitter 以外でも感想が書ける場所があると良いのではと思いコメントシステムを Blog に導入してみた。

## 選定基準

コメントシステムの採用候補は２つ

- [utterances](https://github.com/utterance/utterances) GitHub issues をベースにしたコメントシステム
- [giscus](https://github.com/giscus/giscus) は GitHub Discussions をベースにしたコメントシステム

両者とも OSS で、コメントのデータを GitHub 上で保持できるのが魅力的。
[DISQUS](https://disqus.com/)も同じ機能を提供してくれているが、自分のデータは自分で持ちたいかつデザインが激しめな印象があるので、uttrances, giscus が候補に残った。

両者ともデザインシンプルで良い。

だが、giscus は コメントを取り扱うなら issues ではなく [Discussions のほうが適している](https://laymonage.com/posts/giscus)という動機から作られた。

giscus は記事に対してリアクションができたり、コメントに関する voting もあるので、迷わず giscus を採用する流れとなった。

確かに issues よりも GitHub Discussions のほうがコメントという概念に適していると思う。

というわけで GitHub でサインインすれば記事末尾にて、giscus を通じてコメントやリアクションができるようになったので、リアクションお待ちしております...! 👇

## 余談

[Webmention](https://www.w3.org/TR/webmention/) などの仕組みも気になるのだが、ちょっと採用するまでの仕組みが重いので不採用にした

## References

- [Giscus: The New Commenting Engine for My Website](https://zhauniarovich.com/post/2021/2021-06-giscus/)
