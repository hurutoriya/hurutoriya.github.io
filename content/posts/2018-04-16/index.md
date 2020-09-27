---
title: "eBayのAR測定機能を試してみた"
date: 2018-04-16T14:57:41.155Z
lastmod: 2019-06-16T18:17:59+09:00
lang: ja
tags:
  - AR
  - Android
  - Review
  - Computer Vision
---

eBay が ARCore を使った商品の梱包測定機能を提供しているので試した

![image](/posts/2018-04-16_ebay/images/1.png)

![image](/posts/2018-04-16_ebay/images/2.png)

![image](/posts/2018-04-16_ebay/images/3.png)

梱包測定の仕組みとしては、ARCore(今回は Pixel2 XL で試した)で平面検出を行って、そこに eBay のダンボールオブジェクトを設置することで、ダンボールに入るかどうかを判定できる。

![image](/posts/2018-04-16_ebay/images/4.png)

![image](/posts/2018-04-16_ebay/images/5.png)

![image](/posts/2018-04-16_ebay/images/6.png)

下のダンボールアイコンを選択して、検出された平面をタップするとダンボールオブジェクトを設置できる

![image](/posts/2018-04-16_ebay/images/7.png)

![image](/posts/2018-04-16_ebay/images/8.png)

![image](/posts/2018-04-16_ebay/images/9.png)

今回例として用いた MBP の空箱だと ARCore が空箱自体を平面と認識してしまうという罠があるので、床で平面検知を終えてから商品を置くという裏技が必要

### まとめ

- ARCore を用いた AR 機能の UX としては 🙆
- 実用性は 🙅、平面検出しかしてないので、荷物に合わせて最適なダンボールを選ぶのは結局ユーザー。そこまで自動化してこそ革新的な機能になると思った

Related Post

[eBay uses augmented reality to help sellers find the right box for their product](https://venturebeat.com/2018/03/19/ebay-uses-augmented-reality-to-help-sellers-find-the-right-box-for-their-product/)
