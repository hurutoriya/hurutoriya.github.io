---
title: "pipenv のversion 2020.11.15 でローカルパッケージが正常にインストールされないときの対処法"
date: 2021-03-13T21:43:44+09:00
lang: ja
tags:
  - python
---

## TL; DR;

- pip install pipenv==2018.11.26 をすれば直った!!!!!

## 実行環境

```bash
$pipenv --version
pipenv, version 2020.11.15
```

## 直面した問題

```bash
./app/
├── model
│   └── setup.py
└── serving
    └── Pipfile
```

のような構成で、`model`というローカルパッケージを作成しており、serving 直下の Pipfile は、`model` を読み込んで setup.py に記述されている依存パッケージもインストールするようにしたい。

serving ディレクトリで、以下のコマンドを入力すればローカルパッケージが pipenv によりインストールされるはずだが

```bash
pipenv install --editable ../model
```

依存関係をすべて記述するはずの Pipenv.lock には、`model`のパスのみが記述され、ローカルパッケージが要求する依存パッケージが記述されていない。

原因を探してみたところ、

[Installing a local package with pipenv install '-e .' doesn't save dependencies #1024](https://github.com/pypa/pipenv/issues/1024)

同じ GitHub issue を発見しダメ元で pipenv を以下のコマンドでダウングレードして見たところ

```bash
pip install pipenv==2018.11.26
```

なんと.... 直った。無事にローカルパッケージの依存パッケージが Pipenv.lock に記述されており、無事にローカルパッケージが serving 直下で動くようになった。

後方互換性が無いとかそんなちゃちな問題ではない気がするのだが、この問題でかなり時間が溶けたので非常に精神的に消耗した。

思えばこういう問題が多くて、普段は poetry を使っていたのを思い出した。

## Ref

- [Installing dependencies of a local dependency with pipenv](https://stackoverflow.com/questions/53505681/installing-dependencies-of-a-local-dependency-with-pipenv)
