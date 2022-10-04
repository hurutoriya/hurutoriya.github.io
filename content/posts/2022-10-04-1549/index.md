---
title: "AirFlow 1系で設定されている環境変数を JSON ファイルとして書き出す方法"
date: 2022-10-04T15:49:30+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-10-04-1549/images/1.png"
  caption: "AirFlow で環境変数をJSONファイルとしてお手軽に書き出す方法"
tags:
  - airflow
  - gcp
---

CloudComposer(GCP の Airflow のマネージドサービス)で運用している AirFlow 1 系上で設定されている環境変数を JSON ファイルとして書き出したかったが、つまずいたのでメモを公開しておく。

AirFlow の運用の理想としては、リポジトリをベースに CI 経由で CloudComposer を構築していくのがベスト。
だが、AirFlow では GUI でお手軽に環境変数(Airflow では Variables という概念[^airflow-var])が設定でき、便利な半面、デメリットとしてリポジトリをベースにした Single Source of Truth の状態が保てなくなってしまう。

## AirFlow の環境変数を JSON ファイルとして書き出す方法

1. 上部の Admin メニューから、`Variables`をクリックしてページに移動
2. `With selected`ボタンをクリックすると `Export`ボタンがドロップダウンリスト内にでてくるので、これをクリックすれば AirFlow に保存されている環境変数を JSON ファイルとして書き出せる
   - Export できるとは初見でわからなかったのでこの UI を考えた人は罪深い。[@nao](https://twitter.com/na0fu3y)さんに教えていただけて感謝!

![AirFlow で環境変数をJSONファイルとしてお手軽に書き出す方法](/posts/2022-10-04-1549/images/1.png)

Airflow CLI からでも環境変数を JSON ファイルとして出力できるらしい[^cloudcomposer-cli]が、手元から

```bash
gcloud composer environments run COMPOSER_NAME --location asia-northeast1 variables -- --export env.json
```

を実行してもローカルには保存されなかったので、実行結果は CloudComposer 内部のインスタンスに保存されている模様。

Bash と GCS のオペレーターを組み合わせれば JSON ファイルを GCS に保存はできそうだが、それもめんどくさそうではある。
直接 SSH で CloudComposer のインスタンスにつなげたほうがまだ楽そうですよね

## まとめ

Airflow の GUI で環境変数を設定するのは便利だけど、Single Souce of Truth ではなくなるので使い所をきちんと見極めよう!!

[^airflow-var]: [Variables — Airflow Documentation](https://airflow.apache.org/docs/apache-airflow/stable/concepts/variables.html)
[^cloudcomposer-cli]: [python \- Export all Airflow variables \- Stack Overflow](https://stackoverflow.com/questions/53206003/export-all-airflow-variables)
