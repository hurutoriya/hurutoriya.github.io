---
title: "Google Colab で Spacy による NER の結果を表示するには、jupyter=True にする必要がある"
date: 2022-04-08T21:04:13+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-04-08/images/1.png"
  caption: "Spacy による NERの結果を Google Colab 上で可視化"
tags:
  - colabratory
  - jupyter
  - python
  - nlp
---

自然言語処理のフレームワークの Spacy を使って、Google Colab 上で NER の可視化を行う際に

```python
import spacy


spacy.displacy.render(doc, style='ent')
```

と実行しても

```html
<div class="entities" style="line-height: 2.5; direction: ltr"></br>\n<mark class="entity" style="background: #bfe1d9; padding: 0.45em 0.6em; margin: 0 0.25em; line-height: 1; border-radius: 0.35em;">\n    2022年\n    <span style="font-size: 0.8em; font-weight: bold; line-height: 1; border-radius: 0.35em; vertical-align: middle; margin-left: 0.5rem">Date</span>\n</mark>\n、\n<mark class="entity" style="background: #ddd; padding: 0.45em 0.6em; margin: 0 0.25em; line-height: 1; border-radius: 0.35em;">\n    日本人\n    <span style="font-size: 0.8em; font-weight: bold; line-height: 1; border-radius: 0.35em; vertical-align: middle; margin-left: 0.5rem">Nationality</span>\n</mark>\nは震撼した。</br>まだ\n<mark class="entity" style="background: #ddd; padding: 0.45em 0.6em; margin: 0 0.25em; line-height: 1; border-radius: 0.35em;">\n    ゾンビ\n    <span style="font-size: 0.8em; font-weight: bold; line-height: 1; border-radius: 0.35em; vertical-align: middle; margin-left: 0.5rem">Insect</span>\n</mark>\nの恐怖は
```

生の HTML が表示されるだけで、結果がレンダリングされなかったので、そのレンダリングするための方法を記しておく。

対処方法としては、

`spacy.displacy.render()` 関数の `jupyter` 引数を `True` にすれば良い。

Spacy の公式ドキュメントには、[^spacy]

> force Jupyter rendering if auto-detection fails.

と書かれており、本来は Jupyter ノートブックからの出力を自動検出してくれるらしいのだが、Google Colab 上では自動検出されてない模様。

そのため、明示的に `jupyter=True` にすれば解決する。
同じような質問が Stack Overflow[^colab] でも投稿されていた。

```python
import spacy


nlp = spacy.load('ja_ginza_electra')
doc = """
2022年、日本人は震撼した。まだ恐怖は拭いきれておらず、ネコに癒やしを求めていた。ネコこそが癒やしなのである。もしくはフレンチブルドッグ。
"""
doc = nlp(doc)
spacy.displacy.render(doc, style='ent', jupyter=True)
```

![colab result in spacy NER](/posts/2022-04-08/images/2.png)

実際に使用した Colab のリンクは[こちら](https://colab.research.google.com/drive/1nUs3cpeMxQ1j9ETFHK93RpJGuzu7ls2C?usp=sharing)です。

[^colab]: https://stackoverflow.com/questions/58892382/displacy-from-spacy-in-google-colab
[^spacy]: https://spacy.io/usage/visualizers#jupyter
