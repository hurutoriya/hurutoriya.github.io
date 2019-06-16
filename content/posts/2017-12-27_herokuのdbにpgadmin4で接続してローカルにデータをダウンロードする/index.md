---
title: "HerokuのDBにpgadmin4で接続してローカルにデータをダウンロードする"
author: "Shunya Ueta"
date: 2017-12-27T08:12:17.298Z
lastmod: 2019-06-16T18:17:25+09:00

description: ""

subtitle: "pyadmin4でHeroku上のDBに接続する記事が日本語になかったので、メモ"
tags:
 - Heroku 
 - Postgresql 
 - Development 
 - 日本語 

image: "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/1.png" 
images:
 - "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/1.png" 
 - "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/2.png" 
 - "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/3.png" 
 - "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/4.png" 
 - "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/5.png" 
 - "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/6.png" 
 - "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/7.png" 
 - "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/8.png" 
 - "/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/9.png" 


aliases:
    - "/pgadmin4-connetct-to-heroku-db-c0abe2342aa8"
---

pyadmin4でHeroku上のDBに接続する記事が日本語になかったので、メモ

### 接続前の準備

Herokuにログインして、対象のAppのDBのページへ



![image](/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/1.png)

Heroku App DB page

そこからDBのセッティングページにあるcredentialボタンをクリック



![image](/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/2.png)

click credential button

そこに記載されている各種情報をpgadmin4に入力してHeroku上のDBに接続する



![image](/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/3.png)

Copy information

### pgadmin4でHerokuのDBに接続

以下のページからpgAdmin4をダウンロード

[Download](https://www.pgadmin.org/download/)

そこからアプリを開くと下記の画面になるので、`Add new Server`をクリック



![image](/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/4.png)

Click Add New Server

Heroku上のDBの情報を入力していく。Serverの名前は適当で大丈夫です。



![image](/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/5.png)





![image](/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/6.png)



接続されるとこんな感じになります。




![image](/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/7.png)



### Query Tool

`Query Tool`を使うことでHeroku上のDBに対してSQLクエリを投げる事ができます。

`Query Tool`は上部のツールバーからアクセス可能です。 注意) 左カラムのテーブルをクリックした後でないとアクティブになりません。




![image](/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/8.png)



SQLの実行結果

雷ボタンでSQLを実行可能 ↓ボタンでSQL結果をローカルにCSV形式で保存できます。




![image](/posts/2017-12-27_herokuのdbにpgadmin4で接続してローカルにデータをダウンロードする/images/9.png)
