---
title: "KyTeaをPythonで扱えるMykyteaを使うために必要なこと"
date: 2021-05-19T22:04:41+09:00
lang: ja
author: Shunya Ueta
tags:
- Python
- NLP
---

## テキスト解析機 KyTea

KyTeaを業務で使う機会があり、Python wrapper である Mykytea を使ってみたのですが、poetry や pip で Mykytea をインストールするだけでは、

`Library not loaded: /usr/local/lib/libkytea.0.dylib in version = "0.1.5"`

上記のエラーが出力され、KyTea を使うことができませんでした。
Mykytea のリポジトリに issue [^1] を立てて、@chezou さんにお聞きしてみたところ、

> Good point.
> Mykytea wheel assumes that kytea is installed under /usr/local/lib, while your kytea exists another place.
> This should be Mykytea issue and there are two options we can avoid it like:
> 1. Use delocate, like Linux's audit-wheel https://realpython.com/python-wheels/
> 2. Install from source using wheel instead.

とのことで、`/usr/local/lib` にKyTea がインストールされていることを前提としているので、KyTea自身をソースコードからビルドすることをおすすめするとご助言をいただくことができました。

C++,C に疎いので知らなかったのですが、`dylib`という仕組みで共通ライブラリとして扱えるんですね。

## Makefile によるkyteaのビルドと、quick check の自動化

自分はMakefile を好んで使うのですが、以下のようなタスクを作成することで、KyTeaのビルドと、quick check をワンライナーで行えるようにしました。

```make
.PHONY: keytea-install
keytea-install: ## install and build kytea
	curl -SsL -o kytea.tar.gz http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz
	mkdir -p /tmp/kytea
	tar -xzvf kytea.tar.gz -C /tmp/kytea --strip-components 1
	cd /tmp/kytea && ./configure && make -j4 && make install
	rm kytea.tar.gz

.PHONY: kytea-test
kytea-test: ## check kytea lib installed by C++ source code build
	echo "山田太郎はコーヒーを買って飲んだ。" | kytea
	poetry run python -c "import Mykytea"
```

使用した pyproject.toml は以下です。

```pyproject.toml
[tool.poetry]
name = "kytea-test"
version = "0.1.0"
description = ""
authors = ["]

[tool.poetry.dependencies]
python = "^3.7"
kytea = "~=0.1.3"

[tool.poetry.dev-dependencies]
pytest = "^5.2"

[build-system]
requires = ["poetry-core>=1.0.0"]
build-backend = "poetry.core.masonry.api"
```

機械学習タスクでは外部のデータに依存することが多いですが、Makefile でその検査を自動化することができるので愛用しています。

[^1]: [Library not loaded: /usr/local/lib/libkytea.0.dylib in version = "0.1.5" #17](https://github.com/chezou/Mykytea-python/issues/17)
