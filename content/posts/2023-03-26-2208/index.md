---
title: "現在 Lucene の KNN ベクトルの最大次元数は1024次元 だが、それを2048次元に変更できないかという議論"
date: 2023-03-26T22:08:18+09:00
lang: ja
author: Shunya Ueta
tags:
  - lucene
  - search
---

[初心者だけど Apache Lucene に貢献したい場合におすすめのチケットラベル](/posts/2023-03-11-1727/)のチケットを眺めていたときに面白いチケットがあった。

取り上げるのは、

[Increase the number of dims for KNN vectors to 2048 \[LUCENE\-10471\] · Issue \#11507 · apache/lucene](https://github.com/apache/lucene/issues/11507)

というチケットだが、表題の通りで、現在 KNN ベクトルとして扱える最大次元数は 1024 次元だが、それを 2048 次元に変更できないかの議論がされている。

該当 PR はこちら

https://github.com/apache/lucene/pull/874/files

```diff
-  public static final int MAX_DIMENSIONS = 1024;
+  public static final int MAX_DIMENSIONS = 2048;
```

と一行の変更だが、大きな議論が巻き起こっている。

例えば、

- MobileNet v2 は 1280 次元
- OpenAPI/ GPT-3 のベクトルは 2048 次元
  なので、2048 次元にすればそれらのベクトルを扱うことができるのではという課題提起。

概ねみんな反対ではないが懸念点として

- ある程度は既存の値から上げてもいいが、制限は設けるべきで次元削減などで特定の次元数以下にユーザーが処理しておくべき [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1224402769)
- Java API が Vector API を提供するようになれば、今の実装はすべて変わるので、難しいね [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1224402784)
- CNN ベースのモデルを使っている人は、Lucene の近傍探索が使えないという状況は改善すべき。(もちろんどこまで許容すべきかは議論すべきですが) [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1224402796)
- この決断は一方通行(制限を再び少なくしようという流れは永久に来ない)なので、急がずに慎重にベンチマークや正当性の議論などが必要 [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1224402827)
- プラグラマブルに自由に設定することはできますか？
  - それは可能ですが、フォークして自分の Lucene をメンテナンスすることになるので推奨できない [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1224402846)
- また、この決定にはデータと評価結果が無いと決定できません。争点は、1048 次元にあわせるために、ユーザー側がなぜ次元削減ができないのかという点もあると思います。 [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1224402846)
- 歴史的にユーザーは Luene の制限と常に戦ってきているものなので、今回の制限について文句を言われても正直気にしていません。最も心配なのは、KNN Vector の機能は初期段階であり、制限をゆるくすると柔軟性が低下してしまうことです [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1224402868)
- 2023-01-03: この issue が作成されてから、多くの変化が起きました。現在では OpenAI の ChatGPT が世の中を席巻しています。最低でも OpenAI が提供するベクトルの次元数である、1536 次元に変更することはできませんか? [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1369369480)
  - この変更は、1 行の変更で終わります。なので究極的に言えば、自分で PATCH を当ててビルドし、Elasticsearch に当てれば、すぐに利用することができます [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1369724615)
  - なぜこのアドバイスをしたかというと、実際にその変更後にレポートを返してください。恐らく、パフォーマンスが機能しないか、メモリ使用量が劇的に高くなっていると思います。 [ref](https://github.com/apache/lucene/issues/11507#issuecomment-1369749788)

## 総論

ベンチマークデータを取って、データを集めないとこの変更はされなさそう。
ここまで良い意味で保守的なのは、個人的に素晴らしいと思います。
それぐらい、慎重に考えていかないと今の Lucene のパフォーマンスは維持できないですよね。
