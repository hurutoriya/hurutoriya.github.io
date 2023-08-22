---
title: "poetry show でパッケージ名に (!) が付与されている意味"
date: 2022-08-10T17:17:29+09:00
lang: ja
author: Shunya Ueta
tags:
  - python
  - poetry
---

[poetry show](https://python-poetry.org/docs/cli/#show) は、poetry の設定ファイルの `pyproject.toml`に記載された利用可能なパッケージ名を表示してくれる。

例えば、ターミナルで `poetry install` を行う前に、`poetry show`を行うと以下のような結果がでる。

![poetry show result](/posts/2022-08-10-1717/images/1.png)

そして、grep で上記の結果を表示させてみると

```shell
> poetry show | grep aiohttp
aiohttp                  (!) 3.8.1       Async http client/server framework (asyncio)
```

と パッケージ名に `(!)`が付与されている。

この`(!)`ってそもそもどんな意味なのか気になったので調べてみました。

Poetry のコードを直接読んでみると、
[test_show_basic_with_not_installed_packages_non_decorated](https://github.com/python-poetry/poetry/blob/68f4da8c0af754dd9afd8c96cf97a2b80fced33e/tests/console/commands/test_show.py#L357)のテストケースが今回の事例にマッチしており、わかりやすかった。
意味としては、「インストールされたパッケージに対する show コマンドを非装飾モードで結果を出力」へのテストだ。
状況としては、`cachy`と`pendulum`を poetry add して、 `cachy`のみを poetry install している。

```python
    poetry.package.add_dependency(Factory.create_dependency("cachy", "^0.1.0"))
    poetry.package.add_dependency(Factory.create_dependency("pendulum", "^2.0.0"))

    cachy_010 = get_package("cachy", "0.1.0")
    cachy_010.description = "Cachy package"

    pendulum_200 = get_package("pendulum", "2.0.0")
    pendulum_200.description = "Pendulum package"

    installed.add_package(cachy_010)
```

その後に、poetry show を実行した際に以下のように`(!)`が期待される出力となっている。

```bash
cachy        0.1.0 Cachy package
pendulum (!) 2.0.0 Pendulum package
```

実際に`(!)`を付与している部分はここ。
https://github.com/python-poetry/poetry/blob/68f4da8c0af754dd9afd8c96cf97a2b80fced33e/src/poetry/console/commands/show.py#L310-L311

```python
if not self.io.output.is_decorated():
	# Non installed in non decorated mode
	install_marker = " (!)"
```

`is_decorated` は、出力結果を装飾するかどうかのフラグを指しており、このフラグの可否で`True`の場合は色がついて装飾されて出力される。
[is_decorated](https://github.com/python-poetry/poetry/blob/68f4da8c0af754dd9afd8c96cf97a2b80fced33e/get-poetry.py#L124)の定義はここにあった。

自分の場合、設定が上手くいかなかったのが原因で内製パッケージを読み込んでいる部分を知らないうちに失敗して、そのパッケージが(!)がついて表示されていた。

おそらくパイプを通すことで、`poetry show`の装飾フラグが`False`になっていそうではある

## まとめ

- (!)は該当パッケージがインストールされていないことを示している
- 装飾(decorated)モードが `True`なら、ターミナルでは(!)の代わりに装飾されてパッケージ名が表示される(例えば自分のターミナルなら、未インストールのパッケージ名が赤色で表示される)

---

蛇足)設定をミスってインストール失敗していた際に、Python の実行画面では

> ModuleNotFoundError: No module named

と表示されていたので、やはりログが言っていることは正しかった...!
