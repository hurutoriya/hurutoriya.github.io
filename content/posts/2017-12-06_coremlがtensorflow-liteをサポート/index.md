---
title: "CoreMLがTensorFlow Liteをサポート"
author: "Shunya Ueta"
date: 2017-12-06T13:36:38.235Z
lastmod: 2019-06-16T18:16:14+09:00

description: ""

subtitle: "TensorFlow無双"
tags:
 - Machine Learning 
 - TensorFlow 
 - 日本語 
 - 雑記 

image: "/posts/2017-12-06_coremlがtensorflow-liteをサポート/images/1.png" 
images:
 - "/posts/2017-12-06_coremlがtensorflow-liteをサポート/images/1.png" 


aliases:
    - "/coreml-support-tensorflowlite-53ef6f731e1c"
---

TensorFlow無双



![image](/posts/2017-12-06_coremlがtensorflow-liteをサポート/images/1.png)

TensorFlow Lite meets CoreML!!

個人的にいま興味ある分野のうちの一つがスマホで動く機械学習なんですが、昨日TensorFlow LiteがCoreMLでサポートされるというアナウンスがありました!

> [](https://twitter.com/TensorFlow/status/938127069095002112)

[Announcing Core ML support in TensorFlow Lite](https://developers.googleblog.com/2017/12/announcing-core-ml-support.html)


CoreMLの最大の利点はiPhoneのアーキテクチャを最大限に利用した推論の高速化なので、Googleも何かしらの手を打ってくると思っていましたがまさかそのままCoreMLにサポートされたのは驚きです。

個人的にkeras2, Caffe[¹](https://developer.apple.com/documentation/coreml/converting_trained_models_to_core_ml)だけがサポートされてる今の状態は選択肢が少なくて微妙だなと思っていたので良いことだと思います。

少し横道にそれますが、ONNXと呼ばれるMachine Leaningのモデルを相互変換できるプロジェクトも立ち上がっているので、近いうちにフレームワーク間の差異は消えていき、書きたいフレームワークで書き、動かしたい環境にモデルを変換して運用するという流れになる未来がくるかもしれません。

[ONNX: Open Neural Network Exchange Format](http://onnx.ai/)


Pixel[²](https://techcrunch.com/2017/10/17/googles-first-custom-consumer-chip-is-the-secret-behind-the-pixel-2s-camera-performance/)もiPhone8[³](http://appleinsider.com/articles/17/09/23/inside-iphone-8-apples-a11-bionic-introduces-5-new-custom-silicon-engines)以降に搭載されているA11チップに機械学習の計算を高速化させるチップが採用されているのでこれからMachine Learning on Mobileはドンドン加速していくとおもいます。iOS11の吉田さんが担当しているCoreMLの章を見てましたが、利点と欠点が明快に知れるのでオススメです。

[iOS 11 Programming - PEAKS](https://peaks.cc/hurutoriya/iOS11)


TensorFlow LiteもデフォルトでAndroidをサポートしているので、こりゃほんとにプロダクション環境だとTensorFlow一択になりつつありますね

にしてもTensorFlowの勢いはほんとに凄い…
