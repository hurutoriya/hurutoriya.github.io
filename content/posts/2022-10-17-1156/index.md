---
title: "Python で zip関数を使う際に、２つの配列が同じ大きさを想定する場合は 3.10 から導入された strict=True を使おう"
date: 2022-10-17T11:56:22+09:00
lang: ja
author: Shunya Ueta
tags:
  - python
---

Python で２つの配列を for 文で扱いたい場合によく使うのが zip() です。

zip()を使った for 文では暗黙的に同じ大きさが要求されると思っていたが、実際には以下のように２つの配列の大きさが異なっていてもエラーが出ないことに気が付かず、困ったことがあった。

```python
In [1]: a = [1,2,3,4]

In [2]: b = [1,2,3]

In [3]: for i,j in zip(a,b):
   ...:     print(i,j)
   ...:
1 1
2 2
3 3
```

てっきり、大きい配列の要素を参照時にエラーが発生するかと思ったら、そんなことはなかった。

`assert` とかで事前にコケるようにしておくとか必要そう。
もしくは、両者の配列のサイズが同じことを明示的に確認するのが吉。

また蛇足だが、Stackoverflow では意図的に異なる大きさの配列を上手く循環させつつ回したい場合の対処法も書いてあり勉強になった。[^pythono-zip]

2022-10-27: 追記

@ftnext さんから以下の情報[^twitter]を教えてもらいました。

> 小さい方を読み切ったら for を抜けるの予想と違いますよね。 3.10 から zip に strict 引数が追加されており、True を指定すれば長さが異なると ValueError を送出するようになったんです！ [https://docs.python.org/ja/3/library/functions.html#zip…](https://t.co/kFqmxqphO8) また長い方に合わせたいときは zip_longest が標準ライブラリの itertools にありますー

なるほど。

> Without the `strict=True` argument, any bug that results in iterables of different lengths will be silenced, possibly manifesting as a hard-to-find bug in another part of the program.

わかる〜〜ということで試してみました。

```python
In [1]: a = [1,2,3,4]
In [2]: b = [1,2,3]
In [3]: for i,j in zip(a,b,strict=True):
   ...:     print(i,j)
   ...:
1 1
2 2
3 3
-------------------------------------------------------------------------
ValueError                              Traceback (most recent call last)
Cell In [3], line 1
----> 1 for i,j in zip(a,b,strict=True):
      2     print(i,j)

ValueError: zip() argument 2 is shorter than argument 1
```

おぉ、これは便利ですね!

## 結論

Python で zip 関数を使う場合、２つの配列に同じ大きさを想定する場合は strict=True を使うとバグの温床を潰せる

[^pythono-zip]: [How to zip two differently sized lists, repeating the shorter list? \- Stack Overflow](https://stackoverflow.com/questions/19686533/how-to-zip-two-differently-sized-lists-repeating-the-shorter-list)
[^twitter]: https://twitter.com/ftnext/status/1583483767645011968
