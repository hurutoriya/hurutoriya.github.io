---
title: "Python の内包表記とジェネレータ式のメモリ使用量比較"
date: 2020-08-23T21:28:10+09:00
lang: ja
tags:
- Python
---

リストを構築する際にPythonではリスト内包表記とジェネレータ式の２種類が存在する。
今回、リスト構築時にメモリ使用量にどれだけ差異が発生するのか調査をしてみた。
メモリ使用量の調査には、[memory_profiler](https://github.com/pythonprofilers/memory_profiler)というパッケージを使用した。

まず、２つのリストのデカルト積のタプルを表示するプログラムでの比較

```python
from memory_profiler import profile


@profile
def main():
    """
    Comparision List comprehension VS generator memory usage
    """
    colors = "colors" * 1000
    sizes = "S" * 100
    for shirts in ((color, size) for color in colors for size in sizes):
        print(shirts)
    [print((color, size)) for color in colors for size in sizes]


if __name__ == "__main__":
    main()
```

```bash
Filename: src/listcomp_vs_generator.py

Line #    Mem usage    Increment   Line Contents
================================================
     4     10.5 MiB     10.5 MiB   @profile
     5                             def main():
     6                                 """
     7                                 Comparision List comprehension VS generator memory usage
     8                                 """
     9     10.5 MiB      0.0 MiB       colors = "colors" * 1000
    10     10.5 MiB      0.0 MiB       sizes = "S" * 100
    11     10.5 MiB      0.0 MiB       for shirts in ((color, size) for color in colors for size in sizes):
    12     10.5 MiB      0.0 MiB           print(shirts)
    13     15.1 MiB      0.1 MiB       [print((color, size)) for color in colors for size in sizes]
```

次に、1000x1000のデカルト積を作成した場合

```python
from memory_profiler import profile


@profile
def main():
    """
    Comparision List comprehension VS generator memory usage
    """
    colors = "colors" * 1000
    sizes = "S" * 1000
    ((color, size) for color in colors for size in sizes)
    [(color, size) for color in colors for size in sizes]


if __name__ == "__main__":
    main()

```

```bash
Line #    Mem usage    Increment   Line Contents
================================================
     4     10.5 MiB     10.5 MiB   @profile
     5                             def main():
     6                                 """
     7                                 Comparision List comprehension VS generator memory usage
     8                                 """
     9     10.5 MiB      0.0 MiB       colors = "colors" * 1000
    10     10.5 MiB      0.0 MiB       sizes = "S" * 1000
    11     10.5 MiB      0.0 MiB       ((color, size) for color in colors for size in sizes)
    12    434.6 MiB      5.8 MiB       [(color, size) for color in colors for size in sizes]
```

結果を見ると一目瞭然で、ジェネレータ式の場合だとイテレータプロトコルが要素を一つ一つ作成するので、メモリ使用量もリスト内包表記と比べると40倍以上と一目瞭然の差になった

機械学習でも大規模なデータを扱うことが多い、なのでジェネレータ式を意識して書いてメモリ使用量を抑えていきたい。