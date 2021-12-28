---
title: "Jupyter でPandas DataFrame 内部に画像をURLから参照して表示させる"
date: 2021-12-28T23:04:19+09:00
lang: ja
author: Shunya Ueta
tags:
  - python
  - pandas
  - jupyter
---

データ分析などをしていると、特定の CDN で提供されている画像を参照して、処理した結果を Jupyter Notebook 上で良い感じに表示させたいときがある。
例えば、自分は画像と説明文がペアになっている画像を Jupyter 上で良い感じに表示させたいときが多々ある。

[url からとってきた画像を jupyter に表示する](https://tsukin.hateblo.jp/entry/2020/04/08/162605) でも同じような課題に取り組んでいるが、今回紹介する方法なら余計なパッケージを入れずに最小構成で Jupyter 上で表示できるのが利点。

```python
import pandas as pd
from IPython.display import HTML

# NOTE: https://www.irasutoya.com/2021/01/onepiece.html から画像を参照
onepiece = {
    "モンキー・D・ルフィ" : "https://1.bp.blogspot.com/-uxIsaN0S5lQ/X-FcrvAAInI/AAAAAAABdD4/6uw_qNUh9dQrG0aUzIExybt84yTEmXOPwCNcBGAsYHQ/s200/onepiece01_luffy.png",
    "ロロノア・ゾロ" : "https://1.bp.blogspot.com/-rzRcgoXDqEg/YAOTCKoCpPI/AAAAAAABdOI/5Bl3_zhOxm07TUGzW8_83cXMOT9yy1VJwCNcBGAsYHQ/s200/onepiece02_zoro_bandana.png",
    "ナミ" : "https://1.bp.blogspot.com/-2ut_UQv3iss/X-Fcs_0oAII/AAAAAAABdD8/jrCZTd_xK-Y6CP1KwOtT_LpEpjp-1nvxgCNcBGAsYHQ/s200/onepiece03_nami.png",
    "そげキング（ウソップ）" : "https://1.bp.blogspot.com/-mZpzgXC1Sxk/YAOTCAKwWTI/AAAAAAABdOM/5B4hXli0KLU5N-BySHgjVbhZscKLSE-bQCNcBGAsYHQ/s200/onepiece04_usopp_sogeking.png",

}

df = pd.DataFrame({"Name": onepiece.keys(),
                   "Image": onepiece.values()})

def path_to_image_html(path):
    return f'<img src="{path}"/>'

pd.set_option('display.max_colwidth', None)
HTML(df.to_html(escape=False ,formatters=dict(Image=path_to_image_html)))
```

結果はこうなる

![Jupyter 上でDataFrame内部に画像が表示されている](/posts/2021-12-28/images/1.png)

やっていることとしては、

1. Pandas の[DataFrame.to_html()](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_html.html)関数で、DataFrame を HTML に変換
1. 変換時に、`escape=False` にすることでエスケープせずに HTML を出力
1. `formatters`では、特定のカラムに関数を適用して変換できる。この関数は文字列を返す関数でなくてはならない。
1. 最後に出力された HTML を `IPython.display` の`HTML`モジュールで HTML を Jupyter 上で表示

## Appendix

Gist はこちら

<script src="https://gist.github.com/hurutoriya/0ebd3b83be391948fdec11e2dbfe5c83.js"></script>

Colab でも公開しておきます

[Colab link](https://colab.research.google.com/drive/1ufdIjcElRjmOLeYOy2RplgqXxaHXOgau?usp=sharing)

## References

- [url からとってきた画像を jupyter に表示する](https://tsukin.hateblo.jp/entry/2020/04/08/162605)
- [Pandas / IPython Notebook: Include and display an Image in a dataframe](https://stackoverflow.com/questions/37365824/pandas-ipython-notebook-include-and-display-an-image-in-a-dataframe)
