---
title: "Dataflow template を使って Google Cloud Pub/Sub の中身を簡単に確認する"
date: 2021-11-05T23:05:22+09:00
lang: ja
author: Shunya Ueta
tags:
  - gcp
  - pubsub
  - dataflow
---

PubSub に出力された結果を確認するのって、なかなか手間がかかりませんか?

最近同僚に簡単な確認方法を教えてもらい、感動したのでそれを記事にしました。

## 確認方法

1. PubSub のメッセージを出力する Google Cloud Storage bucket を同一 GCP プロジェクトで作成する。
1. GCP の Pub/Sub ページに移動する
1. 確認したい Pub/Sub topic をクリックする
1. ページ下部にある `CREATE SUBSCRIPTION` ボタンを押すと選択肢で、`Create subscription`, `Export to BigQuery`, `Export to Cloud Storage`があり、 `Export to Cloud Storage`を選択する。
   - BigQuery、 Google Cloud Storage への吐き出しを行い際に、自動的に subscription が生成される。
1. `Export to Cloud Storage` を選択すると、Text 形式か Abro 形式での出力にするかを選択できる。基本的には簡単に確認できる Text 形式を選ぶと良さげ。
1. 選択後、下記のような設定画面が出てくるので情報を埋めていく。基本的には、どこの Google Cloud Storage に出力するかを埋めれば完了。

![Export to Cloud Storage config](/posts/2021-11-05/images/1.png)

1. 10m ほどすると Streaming job の Dataflow の起動が完了して、一定期間ごとに Pub/Sub の topic に公開されたデータがテキスト形式で出力され始めます。
1. 出力された GCS の結果を眺めるには、 `gsutil` コマンドなどを使うのが簡単です。自分は`gsutil cat` の結果をコピーして VS Code で確認しています。

Cloud Dataflow のテンプレート機能については、端的に説明すると、GUI でパラメータを設定するだけで、Dataflow によるデータ処理が簡単に実行できるようになる機能です。

詳しくは、 GCPUG での[Cloud Dataflow がテンプレートにより気軽に使えるサーバーレスのサービスに進化した話
](https://medium.com/google-cloud-jp/cloud-dataflow-%E3%81%8C%E3%83%86%E3%83%B3%E3%83%97%E3%83%AC%E3%83%BC%E3%83%88%E3%81%AB%E3%82%88%E3%82%8A%E6%B0%97%E8%BB%BD%E3%81%AB%E4%BD%BF%E3%81%88%E3%82%8B%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%83%AC%E3%82%B9%E3%81%AE%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%81%AB%E9%80%B2%E5%8C%96%E3%81%97%E3%81%9F%E8%A9%B1-f8105ea956d3)の記事がわかりやすいのでごらんください。
