---
title: "技術書の翻訳作業の最終段階で、 Latex 形式に変換する際に英語だけコメントアウトして、日本語はそのまま残す Python スクリプト"
date: 2023-04-30T00:59:44+09:00
lang: ja
author: Shunya Ueta
tags:
  - python
---

直近 2 年くらいプライベートの時間を費やして、機械学習関係の技術書の翻訳作業を友人を交えて 3 人のグループで行っているのですが、ついに最終段階を迎え、ほぼほぼ翻訳作業は終えました。

翻訳作業中は、共同作業がしやすいように Google Docs を使っているのですが以下のような形で

```
Today is good weather.

今日はいい天気です。
```

英語(原著)を残して、その下に翻訳結果の日本語を追記していくスタイルで翻訳しています。

現在は書籍の校正作業のために、Google Docs で記載された文章を Latex に変換していく作業があるのですが、その際に原著の英語はコメントアウトする必要があります。
試しに、手作業でコメントアウトしていってみるとこれは辛いという時間がかかりそうなので、自動化することにしました。

最初は、シュッと機械学習ベースで Fasttext [^fasttext]や https://github.com/google/cld3 で言語判定してみようかと思ったら、Fasttext もうまくインストールできないし、cld3 もインストールさえできないしで、30 分くらい時間を溶かした後に不毛だなと思って正規表現ベースで言語判定を行うスクリプトを書きました。
precision 99%[^false]くらいで動いており、非常に快適です。

```python
import re

new_txt = []
file_name = "original.txt"

with open('./data/' + file_name, 'r') as file:
    for line in file:
        # 行ごとに処理を行う
        if len(line)==1:
            # 開業のみの場合はコメントアウトせず、そのまま
            new_txt.append(line)
        elif re.search(r'[ぁ-ん]+|[ァ-ヴー]+|[一-龠]+', line):
            # 日本語のひらがな、かたかな、漢字が含まれていたら日本語とみなして、コメントアウトをしない
            new_txt.append(line)
        else:
            # 英語はLatex形式ででコメントアウトする
            new_txt.append("% "+line)

# 新規のファイルとして保存
with open('./data/en-comment-out-' + file_name, 'w') as file:
    file.write(''.join(new_txt))
```

[^fasttext]: [fasttext を用いた言語判定 \- Out\-of\-the\-box](https://yag-ays.github.io/project/fasttext_language_identification/)
[^false]: 時たま巻き込みが発生しているときがある。数式とかで日本語が使われていない行など
