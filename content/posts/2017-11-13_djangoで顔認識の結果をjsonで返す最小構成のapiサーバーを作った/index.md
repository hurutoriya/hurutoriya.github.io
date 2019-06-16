---
title: "Djangoで顔認識の結果をJSONで返す最小構成のAPIサーバーを作った"
author: "Shunya Ueta"
date: 2017-11-13T17:22:38.891Z
lastmod: 2019-06-16T18:16:00+09:00

description: ""

subtitle: "githubでコードを公開してます。"
tags:
 - 日本語 
 - Computer Vision 
 - Django 
 - Python 
 - Development 

image: "/posts/2017-11-13_djangoで顔認識の結果をjsonで返す最小構成のapiサーバーを作った/images/1.gif" 
images:
 - "/posts/2017-11-13_djangoで顔認識の結果をjsonで返す最小構成のapiサーバーを作った/images/1.gif" 
 - "/posts/2017-11-13_djangoで顔認識の結果をjsonで返す最小構成のapiサーバーを作った/images/2.png" 


aliases:
    - "/django-start-85278724cdb4"
---

![image](/posts/2017-11-13_djangoで顔認識の結果をjsonで返す最小構成のapiサーバーを作った/images/1.gif)

DEMO



githubでコードを公開してます。

[hurutoriya/face_detector_api](https://github.com/hurutoriya/face_detector_api)


Djangoの勉強は、基本的なイントロダクションとしてオフィシャルサイトのドキュメントが充実しているのでオススメです 。

pyimagesearchのBlog記事で最小限の構成で顔検出を行うAPIサーバーを作る記事があり、今回はそれを基本に作成した。

以下所感です。

*   DjangoはRailsと比べるとそんなにレールが敷かれていない
*   日本語の記事がほぼ存在しないので、英語の記事を読む良い練習になった
*   OpenCVやScikit-leanがそのまま動くのは相当魅力的で、サーバからのレスポンスが帰ってきた時には地味に感動
*   API設計や非同期処理なんかの知識が全く足りない

### 次の課題

今回の発展形としてdjango-rest-frameworkを使って、モデルを組み込んで作り上げてGoogle Apps Engine上で公開してみよう。 REST Frameworkはこの記事[2](https://hurutoriya.github.io/blog/django-start.html#fn-django_rest_article)を参考に画像をアップロードできる雛形は作り上げた。 後はOpenCVで処理を施す部分を書き上げたらいけそう。



![image](/posts/2017-11-13_djangoで顔認識の結果をjsonで返す最小構成のapiサーバーを作った/images/2.png)

django-rest-frameworkで使える管理画面

### Thanks

1.  [hurutoriya/face_detector_api](https://github.com/hurutoriya/face_detector_api)
2.  [Django REST Frameworkを使って爆速でAPIを実装する](http://qiita.com/kimihiro_n/items/86e0a9e619720e57ecd8),[ChristianKreuzberger/django-rest-imageupload-example](https://github.com/ChristianKreuzberger/django-rest-imageupload-example/tree/master/tutorial)
3.  [Creating a face detection API with Python and OpenCV (in just 5 minutes)](http://www.pyimagesearch.com/2015/05/11/creating-a-face-detection-api-with-python-and-opencv-in-just-5-minutes/)
4.  [Django 1.11 Documentation](https://docs.djangoproject.com/ja/1.11/intro/)
5.  [Django REST framework is a powerful and flexible toolkit for building Web APIs.](http://www.django-rest-framework.org/)
[Djangoで顔認識の結果をJSONで返す最小構成のAPIサーバーを作った](https://hurutoriya.github.io/blog/django-start.html)


以前のBlog記事から転載しました
