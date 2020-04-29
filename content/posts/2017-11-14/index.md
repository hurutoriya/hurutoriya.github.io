---
title: "OpenCV 3.3から使えるDNNモジュールを使って物体検出"
date: 2017-11-14T11:36:43.926Z
lastmod: 2019-06-16T18:16:04+09:00
lang: ja
tags:
  - Python
  - OpenCV
  - Deep Learning
  - Computer Vision
---

OpenCV と MobileNet を使って物体検出を行った

![image](/posts/2017-11-14/images/1.png)

Object Detection with OpenCV dnn modules and MobileNetSSD on Jupyter Notebook

### Introduction

物体検出を Deep Leaning と OpenCV を用いて行う

OpenCV 3.3 から`dnn`モジュールが正式にリリースされた

> _The main news is that we promoted DNN module from opencv_contrib to the main repository, improved and accelerated it a lot. An external BLAS implementation is not needed anymore. For GPU there is experimental DNN acceleration using Halide (_[_http://halide-lang.org_](http://halide-lang.org)_). The detailed information about the module can be found in our wiki: Deep Learning in OpenCV.  
> _[_https://opencv.org/opencv-3-3.html_](https://opencv.org/opencv-3-3.html)

今回はその dnn モジュールを使って物体検出を行う

- [OpenCV dnn modules](https://github.com/opencv/opencv/tree/master/modules/dnn)
- [Official Sample](https://github.com/opencv/opencv/tree/master/samples/dnn)

この記事は主に[pyimagesearch の記事](https://www.pyimagesearch.com/2017/09/11/object-detection-with-deep-learning-and-opencv/)を参考に行いました。詳細な解説がありがたいです Deep Leaning を基にした物体検出で有名な手法は以下の 3 つである

- Faster R-CNN : 2015
- YOLO : 2015
- SSDs : 2015

物体検出を行う際の DNN のアーキテクチャでは主に VGG か ResNet が用いられる。しかし欠点としてこれらのアーキテクチャは非常に大きく 200–500MB のサイズになってしまう

物体検出において速度、精度、メモリの３つのバランスを考慮する場合、どのアーキテクチャを選ぶべきかを Google が論文としてまとめている

[[1611.10012] Speed/accuracy trade-offs for modern convolutional object detectors](https://arxiv.org/abs/1611.10012)

一行でまとめると、基本的に速度と精度はトレードオフであり、最速は SSDs MobileNet, 最高精度は Faster R-CNN w/Inception Resnet at stride 8

今回は省メモリかつ速度が早い SSDs MobileNet を用いて物体検出を行った

Demo on JupyterNotebook

### Code

[hurutoriya/yolov2_api](https://github.com/hurutoriya/yolov2_api)

### Study

- Print デバッグをやめて、logging module に切り替えた。出力が綺麗になっていい感じ
- OpenCV だけで DNN を使えるのは結構便利(学習済モデルとかは必須)

### Future Work

- YOLO v2 も C++のサンプルがあるので、Python でも動くようにしたい
- Web App に組み込めるくらい速そうなので、やってみましょう
