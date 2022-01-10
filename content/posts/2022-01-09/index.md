---
title: "OSSのアノテーションツール Label Studio を使って、快適にアノテーションする"
date: 2022-01-09T23:05:16+09:00
lang: ja
author: Shunya Ueta
tags:
  - annotation
  - machinelearning
---

## Google Spread Sheet による即席アノテーションの限界

データ分析で、ラベルがないデータに対して、自分でアノテーション(ラベルを付与)してデータの傾向を素早く掴みたい時がある。
例えば、文章に対してネガティブ・ポジティブなクラスを割り振ったり、画像に対して人が写り込んでいるか否かなどの簡単な分類タスクでは、お手軽に Google Spread Sheet などを使って、500 件のアノテーションはそこまで問題がなく気合でやれる。

実際の流れとしては、GCP を採用している場合、Google BigQuery から SQL でデータを抽出してそのまま Google Sprad Sheet に出力、`=image()`関数で CDN から画像の URL を参照できたりなどなどかなり便利。
Spread Sheet を共有して複数人でも作業ができるのも魅力的。

だが、文章の特定の部分を選択してタグを付けたかったり、クラス数が二桁など少し複雑なアノテーションタスクを行いたい場合 Google Spread Sheet では、アノテーションの生産性が劇的に落ちる、もしくは不可能になる。あくまで Google Spread Sheet はお手軽にラベリングを行うだけで、ラベリング専用ツールではないので当然の帰着ではある...

## Label Studio とは

今回紹介する[Label Studio](https://labelstud.io/)は OSS データのラベリング(アノテーション)ツールは、

- 画像
  - 画像分類
  - 物体認識
  - セマンティックセグメンテーション
- 音声
  - 音声分類
  - 話者分類
  - 感情認識
  - 文字起こし
- 文章
  - 文書分類
  - 固有表現抽出(NER)
  - 質疑応答
  - 感情分析
- 時系列データ
  - 時系列分類
  - 時系列分割
  - イベント認識
- マルチモーダル
  - 対話処理
  - 文字認識(OCR)
  - ビデオ・音声の時系列分類

など多種多様なドメインに対してラベリングを行うことができるソフトウェアだ。

また、アカウント認証や、キーボードショートカットなどアノテーションの生産性を向上させる基本的な機能が標準で搭載されており、アノテーション効率の向上と管理が期待できる。

同様に OSS の自然言語タスクに特化したアノテーションツールの[doccano](https://github.com/doccano/doccano) も検討したが、Label Studio は自然言語以外にも画像やランキングなど多種多様なラベリングタスクに対応しているので、後々にアノテーションしたいデータの種類が増えたとしても Label Studio を活用できて便利そうなので、今回は Label Studio を選択した。

機能として

- アノテーションのインターフェイスは xml のような形式で、GUI で柔軟に作成可能。画像・文章を組み合わせて表示したいときでも容易に表現が可能。
- Web アプリとして完結していて、よほど込み入ったことをしたいと思わない限り、Docker か pip でインストールしてコマンド実行するだけで良い。データを準備するだけで、コードを書かなくてよい
- 実行環境として Cloud Run で実行可能、pip でインストールして実行するだけでも起動可能なのでポータビリティが高い。

が気に入った。

また、今は使わないが

- 機械学習モデルを組み込んで、アノテーションの補助が可能な点
- AWS, GCP, Azure の CloudStorage と連携が可能
- Webhook で連動させて、アノテーションが完了したらジョブを実行

が気になっている。

## Label Studio の活用方法

以下の画像の URL が格納されている `onepiece.csv`を使って、各画像に指定のクラスを割り振るデータラベリングを Label Studio を使って実行する。

```csv
image
https://1.bp.blogspot.com/-uxIsaN0S5lQ/X-FcrvAAInI/AAAAAAABdD4/6uw_qNUh9dQrG0aUzIExybt84yTEmXOPwCNcBGAsYHQ/s200/onepiece01_luffy.png
https://1.bp.blogspot.com/-rzRcgoXDqEg/YAOTCKoCpPI/AAAAAAABdOI/5Bl3_zhOxm07TUGzW8_83cXMOT9yy1VJwCNcBGAsYHQ/s200/onepiece02_zoro_bandana.png
https://1.bp.blogspot.com/-2ut_UQv3iss/X-Fcs_0oAII/AAAAAAABdD8/jrCZTd_xK-Y6CP1KwOtT_LpEpjp-1nvxgCNcBGAsYHQ/s200/onepiece03_nami.png
https://1.bp.blogspot.com/-mZpzgXC1Sxk/YAOTCAKwWTI/AAAAAAABdOM/5B4hXli0KLU5N-BySHgjVbhZscKLSE-bQCNcBGAsYHQ/s200/onepiece04_usopp_sogeking.png`
```

例とする画像の URL は[いらすとや](https://www.irasutoya.com/)さんを参照させていただいております。

今回はお手軽に Poetry で Label Studio をインストールして、ローカル環境で実行した。

```shell
# Requires >=Python3.6, <3.9
poetry add label-studio

# Start the server at http://localhost:8080
poetry run label-studio
```

## プロジェクトの作成

![](/posts/2022-01-09/images/1.png)

`poetry run label-studio` で Lebel Studio を起動後、右上の Create ボタンからプロジェクトを作成する。プロジェクト = 必要なアノテーションデータの 1 単位と考えれば良い。
上の 3 つのタブ

- Project Name : プロジェクトの概要を入力
- Data Import : アノテーション対象のデータをアップロード
- Labeling Setup : ラベリング方式の設定

## アノテーションテンプレート選択

![](/posts/2022-01-09/images/2.png)

Labeling Setup では、様々なドメインのアノテーションタスクをテンプレートから選択が可能

## ラベリングインターフェイス

![](/posts/2022-01-09/images/3.png)

テンプレートを選択後、GUI でタグを自分で選択して編集する。
Code タグを選択すれば、直接インターフェイスを xml ライクに宣言ができる。
各種タグは

https://labelstud.io/tags/

を参考にすれば、柔軟にアノテーションが組める。Web アプリ上で完結しつつ柔軟にインターフェイスを構築できるのは感動した。

#### タグの豆知識

`<Header>` タグで、各種データの説明文を設定可能

```xml
<Header value="説明文"/>
```

タグの末尾に `/` を入れることで閉じタグを省略できる。
以下の 2 つは等価

```xml
<Header value="$title"/>
<Header value="$title"></Header>
```

`<TextArea>` タグを使えば、判断に困った際のデータに対してコメントを残せる
`toName` 要素で、何に対するコメントなのかを指定する。

```xml
<TextArea name="comment" toName="text" placeholder="Enter Comment here..." maxSubmissions="1" rows="3" editable="true"/>
```

## プロジェクト画面

![](/posts/2022-01-09/images/4.png)

プロジェクト画面では、アップロードされたデータやアノテーションの進捗具合などがひと目で把握できる。
データセットに画像の URL があれば、カラムの属性を`img`に変更すれば一覧画面でその画像が表示される。

## アノテーション画面

![](/posts/2022-01-09/images/5.png)

Mac だと Command + Enter で Submit, 例だと、例えばナミはキーボードで 3 を押せば選択される。これらのキーボードショートカット機能により高速にアノテーションが可能。

## 実際の作業の撮影動画

1. Label Studio の起動
1. プロジェクトの作成
1. データのアップロード
1. アノテーションの実行
1. アノテーション結果のダウンロード

までの動画を撮影した。

動画で見ることで、Label Studio の魅力がわかるのではなかろうか。
キーボードショートカットが搭載されていて、実際のアノテーション作業がとても快適に行える点がわかるのではなかろうか。

<iframe width="560" height="315" src="https://www.youtube.com/embed/lIuREkAdDa0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

もう少し使い込んだら、また続編を書きたい。
OSS でこのクオリティのアノテーションソフトウェアが公開されるようになっているのは本当に素晴らしい。
