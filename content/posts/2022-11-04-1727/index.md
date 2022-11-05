---
title: "env Studio No such file or directory というVisual Studio Code 起因のエラーへの対処方法"
date: 2022-11-04T17:27:50+09:00
lang: ja
author: Shunya Ueta
tags:
  - cli
  - vscode
---

VSCode を`code`コマンドから実行可能にすると`PATH`に Visual Studio Code の空白スペースが含まれてしまうことが原因でこのエラーが発生する。

具体的には VSCcode の PATH が以下のように登録されてしまっている。

```bash
PATH = ...PATH:/Applications/Applications/Visual Studio Code.app/Contents/Resources/app/bin
```

自分が遭遇したエラーは、環境変数を参照する make コマンドで

```bash
make test
env: Studio: No such file or directory
```

というエラーが出てくるようになり、make task が実行できなくなってしまった。

原因として自分の場合は、brew で VSCode をインストールしなおしたら、このエラーが出てくるようになった。

## 対処方法

公式ページに書いてあるとおりの方式[^vscodecli]でパスを通せば解決する。
具体的に解説すると

1.  VS Code を起動
2.  コマンドパレット(Cmd+Shift+P)を開いて、`shell command`と打ち込み、`Shell Command: Install 'code' command in PATH` を選択して実行

でこのエラーが出てこなくなる。

もしくは、ダブルクォーテーションで`PATH`を登録すればこの問題は回避可能

```bash
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
```

[^vscodecli]:
    [Visual Studio Code on macOS](https://code.visualstudio.com/docs/setup/mac)
    You can also run VS Code from the terminal by typing 'code' after adding it to the path:

    - Launch VS Code.
    - Open the **Command Palette** (Cmd+Shift+P) and type 'shell command' to find the **Shell Command: Install 'code' command in PATH** command.
