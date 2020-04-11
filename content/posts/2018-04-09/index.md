---
title: "Google, Facebookが提供する機械学習基盤まとめ"
date: 2018-04-09T13:55:44.389Z
lastmod: 2019-06-16T18:17:59+09:00
lang: ja
tags:
  - Machine Learning
  - MLOps
  - Paper
---

Google, Facebook の機械学習基盤情報をまとめました

![image](/posts/2018-04-09_google-facebookが提供する機械学習基盤まとめ/images/1.gif)

TFX

社内の勉強会で Google, Facebook が提供する機械学習基盤に関する論文を紹介したので、その資料を公開します#### 経緯

機械学習をサービスとして提供開始すると、継続的な学習やプロダクション環境での機械学習の提供はモデル構築以外にもいろいろと考える問題が多くなります ¹

![image](/posts/2018-04-09_google-facebookが提供する機械学習基盤まとめ/images/2.png)

[1] Hidden technical debt in Machine learning systems NIPS’15

要するに機械学習をサービスとして届けるには、実はめちゃんこ大変なんだよという話なんですが、みんな同じ問題にぶち当たります。

そのためプロダクションレディなレベルで機械学習を提供できるプラットフォームを各社が提案しておりその中でも Google, Facebook の事例を提供します。

### TL; DR;

- FBLearner: MLaaS の事例として最初に読むべき論文、MLaaS をどのような戦略で提供しているかを抽象的にまなべるため、鳥瞰図として読みましょう
- TFX は逆に機械学習基盤が必要とする技術スタックや要件などを詳細に説明しており、教科書的な立ち位置です。社内で機械学習基盤を内製したい場合に詳しく読み込むこと必須
- 両社とも MLaaS をスケーラブルに提供する環境ができており、サービスのコアテクノロジーになっている

### Google : Tensorflow Expand

TFX: A tensor flow-based production-scale machine learning platform

### Facebook : FBLeaner

Applied machine learning at facebook a datacenter infrastructure perspective HPCA18

[ONNX](https://onnx.ai/) を見ていると TensorFlow VS. ONNX 陣営が出来つつありどちらのプラットフォームに乗るかの戦略が大事だなと思います。

Google はモバイル上の ML から超大規模分散学習まで TF シリーズで提供、実際のサービング環境も TFServing というスタックを提供しはじめていて個人的に TensorFlow が何歩も先にいっているという所感

(逆に TensorFlow 一強状態になると、競争状態がなくなるので是非 ONNX 陣営には頑張ってほしい)
