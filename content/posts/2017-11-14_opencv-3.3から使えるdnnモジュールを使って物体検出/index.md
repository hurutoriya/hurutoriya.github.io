---
title: "OpenCV 3.3から使えるDNNモジュールを使って物体検出"
author: "Shunya Ueta"
date: 2017-11-14T11:36:43.926Z
lastmod: 2019-06-16T18:16:04+09:00

description: ""

subtitle: "OpenCVとMobileNetを使って物体検出を行った"
tags:
 - Python 
 - Opencv 
 - Deep Learning 
 - 日本語 
 - Computer Vision 

image: "/posts/2017-11-14_opencv-3.3から使えるdnnモジュールを使って物体検出/images/1.png" 
images:
 - "/posts/2017-11-14_opencv-3.3から使えるdnnモジュールを使って物体検出/images/1.png" 


aliases:
    - "/opencv-dnn-mobilenet-b341a8f3201b"
---

OpenCVとMobileNetを使って物体検出を行った



![image](/posts/2017-11-14_opencv-3.3から使えるdnnモジュールを使って物体検出/images/1.png)

Object Detection with OpenCV dnn modules and MobileNetSSD on Jupyter Notebook

### Introduction

物体検出をDeep LeaningとOpenCVを用いて行う

OpenCV 3.3から`dnn`モジュールが正式にリリースされた
> _The main news is that we promoted DNN module from opencv_contrib to the main repository, improved and accelerated it a lot. An external BLAS implementation is not needed anymore. For GPU there is experimental DNN acceleration using Halide (_[_http://halide-lang.org_](http://halide-lang.org)_). The detailed information about the module can be found in our wiki: Deep Learning in OpenCV.  
> _[_https://opencv.org/opencv-3-3.html_](https://opencv.org/opencv-3-3.html)

今回はそのdnnモジュールを使って物体検出を行う

*   [OpenCV dnn modules](https://github.com/opencv/opencv/tree/master/modules/dnn)
*   [Official Sample](https://github.com/opencv/opencv/tree/master/samples/dnn)

この記事は主に[pyimagesearchの記事](https://www.pyimagesearch.com/2017/09/11/object-detection-with-deep-learning-and-opencv/)を参考に行いました。詳細な解説がありがたいですDeep Leaningを基にした物体検出で有名な手法は以下の3つである

*   Faster R-CNN : 2015
*   YOLO : 2015
*   SSDs : 2015

物体検出を行う際のDNNのアーキテクチャでは主にVGGかResNetが用いられる。しかし欠点としてこれらのアーキテクチャは非常に大きく200–500MBのサイズになってしまう

物体検出において速度、精度、メモリの３つのバランスを考慮する場合、どのアーキテクチャを選ぶべきかをGoogleが論文としてまとめている

[[1611.10012] Speed/accuracy trade-offs for modern convolutional object detectors](https://arxiv.org/abs/1611.10012)


一行でまとめると、基本的に速度と精度はトレードオフであり、最速はSSDs MobileNet, 最高精度はFaster R-CNN w/Inception Resnet at stride 8

今回は省メモリかつ速度が早いSSDs MobileNetを用いて物体検出を行った


Demo on JupyterNotebook



### Code

[hurutoriya/yolov2_api](https://github.com/hurutoriya/yolov2_api)


### Study

*   Printデバッグをやめて、logging moduleに切り替えた。出力が綺麗になっていい感じ
*   OpenCVだけでDNNを使えるのは結構便利(学習済モデルとかは必須)

### Future Work

*   YOLO v2もC++のサンプルがあるので、Pythonでも動くようにしたい
*   Web Appに組み込めるくらい速そうなので、やってみましょう
