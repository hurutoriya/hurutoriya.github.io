---
title: "CoreMLがTensorFlow Liteをサポート"
date: 2017-12-06T13:36:38.235Z
lastmod: 2019-06-16T18:16:14+09:00
lang: ja
tags:
  - Machine Learning
  - TensorFlow
---

TensorFlow 無双

![image](/posts/2017-12-06/images/1.png)

TensorFlow Lite meets CoreML!!

個人的にいま興味ある分野のうちの一つがスマホで動く機械学習なんですが、昨日 TensorFlow Lite が CoreML でサポートされるというアナウンスがありました!

[Announcing Core ML support in TensorFlow Lite](https://developers.googleblog.com/2017/12/announcing-core-ml-support.html)

CoreML の最大の利点は iPhone のアーキテクチャを最大限に利用した推論の高速化なので、Google も何かしらの手を打ってくると思っていましたがまさかそのまま CoreML にサポートされたのは驚きです。

個人的に keras2, Caffe[¹](https://developer.apple.com/documentation/coreml/converting_trained_models_to_core_ml)だけがサポートされてる今の状態は選択肢が少なくて微妙だなと思っていたので良いことだと思います。

少し横道にそれますが、ONNX と呼ばれる Machine Leaning のモデルを相互変換できるプロジェクトも立ち上がっているので、近いうちにフレームワーク間の差異は消えていき、書きたいフレームワークで書き、動かしたい環境にモデルを変換して運用するという流れになる未来がくるかもしれません。

[ONNX: Open Neural Network Exchange Format](http://onnx.ai/)

Pixel[²](https://techcrunch.com/2017/10/17/googles-first-custom-consumer-chip-is-the-secret-behind-the-pixel-2s-camera-performance/)も iPhone8[³](http://appleinsider.com/articles/17/09/23/inside-iphone-8-apples-a11-bionic-introduces-5-new-custom-silicon-engines)以降に搭載されている A11 チップに機械学習の計算を高速化させるチップが採用されているのでこれから Machine Learning on Mobile はドンドン加速していくとおもいます。iOS11 の吉田さんが担当している CoreML の章を見てましたが、利点と欠点が明快に知れるのでオススメです。

[iOS 11 Programming - PEAKS](https://peaks.cc/hurutoriya/iOS11)

TensorFlow Lite もデフォルトで Android をサポートしているので、こりゃほんとにプロダクション環境だと TensorFlow 一択になりつつありますね

にしても TensorFlow の勢いはほんとに凄い…
