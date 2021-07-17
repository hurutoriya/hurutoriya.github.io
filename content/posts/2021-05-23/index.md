---
title: "Poetry からsetup.py を自動生成する"
date: 2021-05-23T23:42:28+09:00
lang: ja
author: Shunya Ueta
tags:
- python
---

現状の Poetry では、`pyproject.toml` を基にした `setup.py` の直接的な自動生成をサポートしていない。

[Support generation of poetry manged setup.py file #761](https://github.com/python-poetry/poetry/issues/761)

え？なんで `setup.py` が必要なんですか? `poetry build` で生成される `source` と `wheels` で事足りるんじゃないですかというツッコミがあると思います。

`PyPI` や `Jflog` などでホストせずに、GitHub のリポジトリでパッケージを管理したり、特定のサブディレクトリをパッケージとして扱う際には、未だ `setup.py` での依存関係の記述が必要です。

## Poetry による実現方法

[poetry build](https://python-poetry.org/docs/cli/#build) コマンドと Makefile を組み合わせることで、`pyproject.toml` に対応した `setup.py` の自動生成ができるのでそれを採用します。
コマンドはGitHub のissues でのコメントを参考にしました。 [^1]

```Makefile
# package name
PACKAGE = lib

.PHONY: build-package
build-package: ## Generate setup.py by poetry command for shared package 
    poetry build
    # source ./dist で解凍
    tar zxvf dist/$(PACKAGE).tar.gz -C ./dist
    # setup.py を手元にコピー
    cp dist/$(PACKAGE)/setup.py setup.py
    # poetry build で生成されたファイルをすべて削除
    rm -rf dist
```

[^1]: https://github.com/python-poetry/poetry/issues/761#issuecomment-689491920
