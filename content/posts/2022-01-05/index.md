---
title: "PythonでDeepL API Free を利用してテキストファイルを翻訳する"
date: 2022-01-05T23:02:06+09:00
lang: ja
author: Shunya Ueta
tags:
  - python
---

機械翻訳サービスの DeepL はアプリだけでなく API 提供も行っている。
今回は DeepL が公開している free API を利用して、テキストファイルを英日翻訳して、翻訳結果をテキストファイルとして保存する方法について説明する。

無料 API は`1か月あたり500,000文字の上限あり`の制限があるが、Pro version と変わらない品質の翻訳を行うことができる。
個人利用する分にはこの文字数制限は特に大きな問題にはならないと思われる。

https://www.deepl.com/ja/pro#developer

まずアカウントを作成して、DeepL API Free の`API_KEY`を入手する。
その後、以下のスクリプトを実行すれば完了。

```python
import requests

# NOTE: put API KEY
API_KEY:str = ''
# NOTE: put
target_file:str = ""

with open(target_file) as f:
    txt = f.read()

params = {
            "auth_key": API_KEY,
            "text": txt,
            "source_lang": 'EN',
            "target_lang": 'JA'
        }

request = requests.post("https://api-free.deepl.com/v2/translate", data=params)

result = request.json()

with open("JA_"+target_file, "w") as text_file:
    text_file.write(result["translations"][0]["text"])
```
