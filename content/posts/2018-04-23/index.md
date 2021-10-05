---
title: "Google Colaboratory で Mecab-ipadic-Neologd を使用可能にする"
date: 2018-04-23T15:38:10.151Z
lang: ja
author: Shunya Ueta
tags:
  - nlp
  - jupyter
  - colabratory
  - python
---

Colabratory 上で 日本語に対する NLP をしたいときありませんか？

```bash
# install MeCab neologd
!apt-get -q -y install sudo file mecab libmecab-dev mecab-ipadic-utf8 git curl python-mecab > /dev/null
!git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git > /dev/null 
!echo yes | mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n > /dev/null 2>&1
!pip install mecab-python3 > /dev/null
```

![image](/posts/2018-04-23/images/1.png)

インストールに成功しました。
## Google Colabratory

[colab-mecab-ipadic-NEologd.ipynb](https://colab.research.google.com/drive/1YK8XFnfD29775lEYWhwz3wh4h8boR9iE)
