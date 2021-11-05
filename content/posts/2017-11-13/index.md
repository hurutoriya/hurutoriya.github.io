---
title: "Djangoで顔認識の結果をJSONで返す最小構成のAPIサーバーを作った"
date: 2017-11-13T17:22:38.891Z
lastmod: 2019-06-16T18:16:00+09:00
lang: ja
tags:
  - computervision
  - django
  - python
---

![image](/posts/2017-11-13/images/1.gif)

DEMO

github でコードを公開してます。

[hurutoriya/face_detector_api](https://github.com/hurutoriya/face_detector_api)

Django の勉強は、基本的なイントロダクションとしてオフィシャルサイトのドキュメントが充実しているのでオススメです 。

pyimagesearch の Blog 記事で最小限の構成で顔検出を行う API サーバーを作る記事があり、今回はそれを基本に作成した。

以下所感です。

- Django は Rails と比べるとそんなにレールが敷かれていない
- 日本語の記事がほぼ存在しないので、英語の記事を読む良い練習になった
- OpenCV や Scikit-lean がそのまま動くのは相当魅力的で、サーバからのレスポンスが帰ってきた時には地味に感動
- API 設計や非同期処理なんかの知識が全く足りない

### 次の課題

今回の発展形として django-rest-framework を使って、モデルを組み込んで作り上げて Google Apps Engine 上で公開してみよう。 REST Framework はこの記事[2](https://hurutoriya.github.io/blog/django-start.html#fn-django_rest_article)を参考に画像をアップロードできる雛形は作り上げた。 後は OpenCV で処理を施す部分を書き上げたらいけそう。

![image](/posts/2017-11-13/images/2.png)

django-rest-framework で使える管理画面

### References

1.  [hurutoriya/face_detector_api](https://github.com/hurutoriya/face_detector_api)
2.  [Django REST Framework を使って爆速で API を実装する](http://qiita.com/kimihiro_n/items/86e0a9e619720e57ecd8),[ChristianKreuzberger/django-rest-imageupload-example](https://github.com/ChristianKreuzberger/django-rest-imageupload-example/tree/master/tutorial)
3.  [Creating a face detection API with Python and OpenCV (in just 5 minutes)](http://www.pyimagesearch.com/2015/05/11/creating-a-face-detection-api-with-python-and-opencv-in-just-5-minutes/)
4.  [Django 1.11 Documentation](https://docs.djangoproject.com/ja/1.11/intro/)
5.  [Django REST framework is a powerful and flexible toolkit for building Web APIs.](http://www.django-rest-framework.org/)
    [Django で顔認識の結果を JSON で返す最小構成の API サーバーを作った](https://hurutoriya.github.io/blog/django-start.html)

以前の Blog 記事から転載しました
