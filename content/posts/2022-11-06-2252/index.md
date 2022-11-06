---
title: " Beam summit 2022 雑感"
date: 2022-11-06T22:52:09+09:00
lang: ja
author: Shunya Ueta
tags:
  - apachebeam
---

毎年開催される Apache Beam の会議、[Beam Summit 2022](https://2022.beamsummit.org/) で講演資料が公開されていたので、気になる資料を読んだ。

以下に面白かった記事の備忘録を放流しておく

## Google's investment on Beam, and internal use of Beam at Google

- Google 内部で現在フルタイム Beam 開発者は 25 人! (多いな)
- Go SDK 提供開始がめでたい
  - 現在は Java, Python, Go の３つの言語をサポート
- 機械学習の推論を Beam の特性を生かしてスケーラブルに実行可能な RunInference も提供できた!
- TypeScript SDK も提供予定!
  - contribution している方も募集中
    https://github.com/apache/beam/tree/master/sdks/typescript
- Beam Playground を使えば、Beam がより効果的に学べるよ https://play.beam.apache.org/
- チケット管理では Jira をやめて GitHub Issues に移行したよ(最近の Apache Project の潮流な気がする。Lucene も移行していた)

## Beam @TwitterEvaluation, Adoption, Migration and future.

- 毎日実行される
  - data pipeline の総数 5 万
  - 200PB 超えのボリュームをデータ処理
  - 7 兆のイベント数
- Beam の魅力
  - batch, streaming の両者を扱うことができる、かつモダンな実行フレームワーク
  - ランナーの柔軟性
  - 複数のクラウド環境で実行可能
  - 複数のプログラミング言語で動く
  - 優れた OSS コミュニティ

## RunInference: Machine Learning Inferences in Beam

[Apache Beam 2\.40 で導入された scikit\-lean, Pytorch の効率的な推論が可能になる RunInference API を試してみる](https://shunyaueta.com/posts/2022-08-18-1938/) でも紹介した、 RunInference API の講演

内容自体は、自分が書いた記事と目立って違ったことは言っていなかったが、Beam の特性で推論を効率化できるのは面白い展開だと思う。
まだサポートしている機械学習フレームワークが、 scikit-learn、Pytorch, TensorFlow だけなので、これからどんどん増やしていくらしいです。
