---
title: "HerokuのDBにpgadmin4で接続してローカルにデータをダウンロードする"
date: 2017-12-27T08:12:17.298Z
lastmod: 2019-06-16T18:17:25+09:00
lang: ja
tags:
  - heroku
  - postgresql
  - development
---

pyadmin4 で Heroku 上の DB に接続する記事が日本語になかったので、メモ

### 接続前の準備

Heroku にログインして、対象の App の DB のページへ

![image](/posts/2017-12-27/images/1.png)

Heroku App DB page

そこから DB のセッティングページにある credential ボタンをクリック

![image](/posts/2017-12-27/images/2.png)

click credential button

そこに記載されている各種情報を pgadmin4 に入力して Heroku 上の DB に接続する

![image](/posts/2017-12-27/images/3.png)

Copy information

### pgadmin4 で Heroku の DB に接続

以下のページから pgAdmin4 をダウンロード

[Download](https://www.pgadmin.org/download/)

そこからアプリを開くと下記の画面になるので、`Add new Server`をクリック

![image](/posts/2017-12-27/images/4.png)

Click Add New Server

Heroku 上の DB の情報を入力していく。Server の名前は適当で大丈夫です。

![image](/posts/2017-12-27/images/5.png)

![image](/posts/2017-12-27/images/6.png)

接続されるとこんな感じになります。

![image](/posts/2017-12-27/images/7.png)

### Query Tool

`Query Tool`を使うことで Heroku 上の DB に対して SQL クエリを投げる事ができます。

`Query Tool`は上部のツールバーからアクセス可能です。 注意) 左カラムのテーブルをクリックした後でないとアクティブになりません。

![image](/posts/2017-12-27/images/8.png)

SQL の実行結果

雷ボタンで SQL を実行可能 ↓ ボタンで SQL 結果をローカルに CSV 形式で保存できます。

![image](/posts/2017-12-27/images/9.png)
