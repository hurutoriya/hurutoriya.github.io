---
title: "pandas を使って特定のディレクトリのCSVファイルをすべて連結して一つのCSVファイルを作成"
date: 2020-09-09T23:49:37+09:00
tags:
  - python
  - pandas
---

## 目的

複数の同じフォーマットの CSV ファイルが特定のディレクトリに配置されており、その CSV ファイル群を一つの CSV ファイルに連結したい

今回は、Python の Pandas と pathlib を使って上記の目的を実現します。

### 実行環境

```python
In [1]: import pandas as pd
In [2]: pd.__version__
Out[2]: '1.1.2
In [3]: import sys
   ...: print(sys.version)
3.8.2 (default, Jul 19 2020, 07:23:27)
[Clang 11.0.3 (clang-1103.0.32.62)]
```

目的となる csv ファイルは `tmp` ディレクトリに以下のような形式で配置されているとする

```bash
tmp
├── 1.csv
├── 2.csv
└── 3.csv
```

各ファイルはこのような形式で保存されています。

```text
id  name  created
1   John  2020/09/10
2   bob   2020/09/10
3   taro  2020/09/11
```

以下の Python スクリプトを実行

```python
import pathlib
import pandas as pd


def contcat_csv(f_path:str):
    # pathlibのitedir()で対象とするディレクトリのCSVファイル一覧をジェネレーターとして取得
    csvs = [pd.read_csv(str(path)) for path in pathlib.Path(f_path).glob('*.csv')]
    # そのファイル一覧をPandasで読み込んで、pd.concat()で連結してDataFrameとして返す
    return pd.concat(csvs, sort=False)

df = contcat_csv('tmp')
# 連結されたDataFrameをCSVとして保存する
df.to_csv('concat.csv', index=False)

```

concat.csv を確認してみると

```text
id  name    created
1   John    2020/09/10
2   bob     2020/09/10
3   taro    2020/09/11
4   hanako  2020/09/12
1   John    2020/09/10
2   bob     2020/09/10
3   taro    2020/09/11
4   hanako  2020/09/12
1   John    2020/09/10
2   bob     2020/09/10
3   taro    2020/09/11
4   hanako  2020/09/12
```

無事連結された CSV を取得することができました

## 追記

- 2020-09-12: @siumachi さんから[ご指摘](https://twitter.com/shiumachi/status/1304325924377096192)を受け、CSV ファイル以外がディレクトリに混入していても問題ないように変更しました

> 拝見しました。for でディレクトリを走査するときは pathlib.Path.glob("\*.csv")を使った方が、csv 以外のファイルが混入したときの対策になると思ったのですが、いかがでしょう https://docs.python.org/ja/3/library/pathlib.html#pathlib.Path.glob
