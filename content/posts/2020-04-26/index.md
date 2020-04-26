---
title: "Pythonの関数のデフォルト引数はmutable(上書きされる)"
date: 2020-04-26T12:04:13+09:00
lang: ja
tags:
- Python
---

例えば以下のように、デフォルト引数で初期化を行い、文字列を追加する関数があるとする。

```python
def append_to(values=[]):
    values.append("Hoge")
    return values
```

期待する振る舞いとしては。

```python
In [14]: def append_to(values=[]):
    ...:     values.append("Hoge")
    ...:     return values
    ...:

In [17]: append_to()
Out[17]: ['Hoge']

In [18]: append_to()
Out[18]: ['Hoge']
```

と関数呼び出しごとに、`values` は空のリストに初期化されるので上記のように返ってきてほしい

だが、実際に表示されるのは

```python
In [14]: def append_to(values=[]):
    ...:     values.append("Hoge")
    ...:     return values
    ...:

In [17]: append_to()
Out[17]: ['Hoge']

In [18]: append_to()
Out[18]: ['Hoge', 'Hoge']
```

である。

実際に内部で何が起きているかというと

```python
In [23]: def append_to(values=[]):
    ...:     values.append("Hoge")
    ...:     return values
    ...:

In [24]: pinfo append_to
Signature: append_to(values=[])
Docstring: <no docstring>
File:      ~/<ipython-input-23-4530a91351ab>
Type:      function

In [25]: append_to()
Out[25]: ['Hoge']

In [26]: pinfo append_to
Signature: append_to(values=['Hoge'])
Docstring: <no docstring>
File:      ~/<ipython-input-23-4530a91351ab>
Type:      function

In [27]: append_to()
Out[27]: ['Hoge', 'Hoge']

In [28]: pinfo append_to
Signature: append_to(values=['Hoge', 'Hoge'])
Docstring: <no docstring>
File:      ~/<ipython-input-23-4530a91351ab>
Type:      function
```

が起きている。
`pinfo` は ipython上で、オブジェクトの情報が確認できる便利コマンドです。
関数呼び出しごとに、デフォルト引数のvalues が上書きされていっていることがわかります。
これは、Pythonのデフォルト引数が、関数が定義されたときのみ評価され、毎回毎回評価されるわけではない。(Ruby は評価される)
ここでわかるのは、mutable 

## 対処方法
関数が呼び出されるごとに新しいオブジェクトを作成する。
何も設定されていないときは、デフォルト引数を使うことで検知する

```python
def append_to(values=None):
    if values is None:
        values = []
    values.append("Hoge")
    return values
```

```python
In [34]: def append_to(values=None):
    ...:     if values is None:
    ...:         values = []
    ...:     values.append("Hoge")
    ...:     return values
    ...:

In [35]: append_to()
Out[35]: ['Hoge']

In [36]: pinfo append_to
Signature: append_to(values=None)
Docstring: <no docstring>
File:      ~/<ipython-input-34-8e047f793784>
Type:      function

In [37]: append_to()
Out[37]: ['Hoge']

In [38]: pinfo append_to
Signature: append_to(values=None)
Docstring: <no docstring>
File:      ~/<ipython-input-34-8e047f793784>
Type:      function
```

想定通りの動きになった

## Ref
- https://docs.python-guide.org/writing/gotchas/
- http://moqada.hatenablog.com/entry/20090206/1233935560