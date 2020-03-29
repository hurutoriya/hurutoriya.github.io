---
title: "メルカリのTeam AI Meetup #1 に参加してきた #mercari_ai"
author: "Shunya Ueta"
date: 2018-02-13T15:35:48.521Z
lastmod: 2019-06-16T18:17:53+09:00
lang: ja
tags:
  - Machine Learning
  - Report

image: "/posts/2018-02-13_メルカリのteam-ai-meetup-sharp1-に参加してきた-sharpmercariai/images/1.png"
images:
  - "/posts/2018-02-13_メルカリのteam-ai-meetup-sharp1-に参加してきた-sharpmercariai/images/1.png"
---

メルカリが主催する機械学習のミートアップに参加してきたので備忘録がてらメモ書きです。書きなぐったメモなので意訳として捉えて下さい

![image](/posts/2018-02-13_メルカリのteam-ai-meetup-sharp1-に参加してきた-sharpmercariai/images/1.png)

発表者の顔は隠しています。なにか問題があればお伝え下さい。

[Team AI Meetup #1 (2018/02/13 19:00〜)](https://mercari.connpass.com/event/77545/)

**Twitter**: [#mercari_ai](https://twitter.com/search?f=tweets&vertical=default&q=%23mercari_ai&src=tyah)

### 山口さん

- Image Net と mercari の持ってるデータセットは似てるのでいけるのでは!
- ルカリはクラス数 over 1100
- 始期の推定値 Top5 29.3%
- エラー例 :画像からサイズを推定しないと男女のシューズを区別不可(人間でも不可能なエラー例が多い)
- 意外と認識がうまくいく事例がかなりある(クラス設計の影響で推定が上手く出来ていないらしい)
- データセットはユーザーが作成してるので最高、画像が正方形なのも Good
- 学習は GPU,推論は CPU 環境下で行っている
- 画像検索自体はプロトタイプは出来ているが、実運用は計算量やリアルタイム性を担保するのが難しいので一旦保留中

大筋は以下の記事と資料で把握できます。k8s で運用しているなどの実運用の構成が今回の発表では差分として語られていました。

[画像での商品検索に向けて - Mercari Engineering Blog](http://tech.mercari.com/entry/2017/12/23/100000)

[【Mercari Summer Internship】商品画像の色推定を行いました! - Mercari Engineering Blog](http://tech.mercari.com/entry/2017/09/04/170000)

### 工藤さん

- 運用を継続すると色んな問題が出てきたので、それを解決する基盤環境を作成しはじめた
- e.g. 学習データのバージョン管理、モデルのデプロイ, etc
- 最終的には OSS としての公開も考えているとのこと

[メルカリの今年 1 年間の機械学習の取り組みとこれから - Mercari Engineering Blog](http://tech.mercari.com/entry/2017/12/02/093000)

[ML Ops Study (仮) #1](http://rindai87.hatenablog.jp/entry/2018/01/04/005931)の発表内容も今回の機械学習の運用周りの Tips が共有されているので興味のある方はオススメです

機械学習基盤といえば、最近**Polyaxon**という OSS が公開されてました。

[Polyaxon](https://polyaxon.com/)

### **Q.A.セッション**

- Q. 論文などは参考にされますか？
- A. ある程度枯れた手法をメインに実装している
- TFX(KDD2017)など Google が出している機械学習の基盤関係の論文は非常に参考している

* Q. 機械学習のプロジェクトをどう進めているか?
* A. ある程度の機械学習についての啓蒙が必要
* **必ずデモを見せて期待値のすり合わせを行っている**
* **何もしらない人は機械学習に対して過度な期待ではなく間違った期待をしてしまっているのでそこのすり合わせは重要**
* **e.g. データは無いが機械学習でなんとかして!** など**雑感** : 質疑応答でも機械学習を実運用したい場合にどう運用しているかにフォーカスした質問がメインでためになる質問が多かったので良かった。メルカリさんが今回のような知見を共有してくれるのは本当に尊敬できます。
