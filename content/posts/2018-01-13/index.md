---
title: "PythonでGaussian Kernelのアニメーションを作成"
date: 2018-01-13T17:03:43.429Z
lastmod: 2019-06-16T18:17:44+09:00
lang: ja
tags:
  - python
  - matplotlib
  - jupyter
---

Python でアニメーションを作成したかったのでメモ

![image](/posts/2018-01-13/images/1.gif)

Gaussian Kernel GIF Animation

当然ながら、HTML5 の Video は再生されないので GIF に変換した結果が以下。

これで HTML5 で再生される。

**_GIF_**で表示する方法として
`%matplotlib nbagg`

というオプションが存在しているが、Kernel が busy 状態を何度も繰り返すので、自分は mp4 で出力するようにした。  
実験結果も以前は GIF で保存してたが、最近は全て`mp4`で管理するようにした。

あと、**np.linspace()**が iterable ではないので、イマイチな書き方になった。。  
**np.arange()**を使うべきなのか…

### Thanks

[Embedding Matplotlib Animations in Jupyter Notebooks](http://louistiao.me/posts/notebooks/embedding-matplotlib-animations-in-jupyter-notebooks/)

[Jupyter 上で matplotlib のアニメーションを再生する - Qiita](https://qiita.com/Tatejimaru137/items/6083e2e3a4e618da6274)
