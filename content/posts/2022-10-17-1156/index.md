---
title: "Python のzip関数で大きさが異なる２つの配列をfor文で回したら、エラーは発生せずに小さい配列を読み切ったら for文は終わる"
date: 2022-10-17T11:56:22+09:00
lang: ja
author: Shunya Ueta
tags:
  - python
---

てっきり、`b[3]`を参照してエラーが発生するかと思ったら、そんなことはなかった。
zip()を使った for 文では暗黙的に同じ大きさが要求されると思っていたが、実際には２つの配列の大きさが異なっていてもエラーが出ないことに気が付かず、困ったことがあった。

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

`assert` とかで事前にコケるようにしておくとか必要そう。
もしくは、両者の配列のサイズが同じことを明示的に確認するのが吉。

また蛇足だが、Stackoverflow では意図的に異なる大きさの配列を上手く循環させつつ回したい場合の対処法も書いてあり勉強になった。[^pythono-zip]

[^pythono-zip]: [How to zip two differently sized lists, repeating the shorter list? \- Stack Overflow](https://stackoverflow.com/questions/19686533/how-to-zip-two-differently-sized-lists-repeating-the-shorter-list)
