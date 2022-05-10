---
title: "社内でデータ分析結果を可視化して共有するのに、 Google Colab が便利"
date: 2022-05-10T22:00:23+09:00
lang: ja
author: Shunya Ueta
tags:
  - dataanalysis
  - python
  - pandas
  - jupyter
---

社内でデータ分析のレポートを書く際は Google Colab がとても便利な事に気がついた。

## Google Bigquery でデータを抽出、Google Sheets で可視化

従来だと、自分がやっていた方法として、

1. Google BQ などで分析対象結果のデータを抽出
1. その結果を Google Spread Sheet として保存して、Google Sheets の機能で可視化。元の SQL のコードは、別シートを作ってそこに貼り付けておく。

利点としては、一度データソースを抽出した後は、Google Sheets で二次加工するさいに便利。
また、 Produc Manager が共有後に自分が出したい数値を Google Sheets を元にさっと計算することもできる。
だが、二次加工が便利なのはいいが、大抵の可視化ってパターンが決まっているので、SQL 取得とその可視化を一気通貫でできないかなと考えていた。

なにか良い方法無いかなと思っている矢先に、別のチームの同僚が、Google Colab を使って、BQ を dataframe として保存後 matplotlib で可視化しているのを見かけて、

求めていたのは...こ、これだ.... となり、速攻取り入れました。

良いと思ったところは積極的に真似するスタイル

## Google Colab なら、データの取得・加工・可視化までを完結可能

Google Colab の利点を列挙しておくと

- SQL のコード、データ抽出や可視化のロジックなどが Python で記述可能かつ、Google Colab で完結
  - matplotlib で可視化できるので、見やすく美しい可視化を簡単に行える。
    - そしてそのコードは他のデータ分析でも再利用可能
  - [pandas](https://pandas.pydata.org/) dataframe で Google BQ からデータを取得するので、Standard SQL だけでは難しい計算も pandas、 numpy や scipy などを使ってデータ加工が簡単にできるのも、便利
- Google Sheets 同様、簡単に社内で共有できる
- Markdown も Google Colab 内で書けるので、凝った文章などもいれてレポートも書ける

マジックコマンドで、Google BQ の結果を dataframe として保存[^googlebq_colab]したり、

```python
# Save output in a variable `df`

%%bigquery --project yourprojectid df
SELECT
  COUNT(*) as total_rows
FROM `bigquery-public-data.samples.gsod`
```

また、`#@title TITLE` を Google Colab のセルの上部に入力すると、コードの部分は非表示になりスッキリした見かけにすることができる。[^colab_tips]

```python
#@title MODULE

import numpy as np
import pandas as np
```

と書くと

![colab cell display no title](/posts/2022-05-10-2200/images/1.png)

が

![colab cell display title](/posts/2022-05-10-2200/images/2.png)

こうなり、右側をクリックすると

![colab cell display only title](/posts/2022-05-10-2200/images/3.png)

コード部分を隠すこともできる。

この機能もレポートとして書く際には重宝しており、このセルで何をやっているかも docstring っぽく記述しておくことができる。

入力フォームも簡単に作れる[^colab_tips]ようなので可視化やレポート作成という目的を見誤ることがなければ、やはり Notebook は便利。
これこそ Jupyter Noteboob の本懐を果たしていると思う。

二次加工が決まっている工程なら「Google Bigquery でデータを抽出、Google Sheets で可視化」の方法を取ればいいが、
サっと分析して可視化結果を共有したいときには、Google Colab が一択になった。

## 余談

@yohei_kikuta さんが、以前 Blog で「BigQuery を使って分析する際の tips」のシリーズを書いており、他者のワークフローを拝見するのは参考になるなと思い、自分も書いてみた。[^yoheikikuta_googlebq]

[^googlebq_colab]: [Getting started with BigQuery](https://colab.research.google.com/notebooks/bigquery.ipynb)
[^colab_tips]: [Google Colab Forms](https://colab.research.google.com/notebooks/forms.ipynb)
[^yoheikikuta_googlebq]: BigQuery を使って分析する際の tips

    - [part1: 開発環境やデータ連携](https://yoheikikuta.github.io/BigQuery_tips_part1)
    - [part2: クエリを書く際に押さえておくとよいこ](https://yoheikikuta.github.io/BigQuery_tips_part2)
    - [part3: 具体的なクエリの tips （このエントリ）](https://yoheikikuta.github.io/BigQuery_tips_part3)
