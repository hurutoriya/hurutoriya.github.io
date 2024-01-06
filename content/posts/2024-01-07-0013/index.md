---
title: "brew install で It seems the App source is not there というエラーへの対処法"
date: 2024-01-07T00:13:58+09:00
lang: ja
author: Shunya Ueta
tags:
  - brew
  - mac
---

intelij-idea-ce をアップグレードしたかったので、brew install したら以下のエラーが出たので対処。

```bash
brew install --cask intellij-idea-ce

Error: intellij-idea-ce: It seems the App source '/Applications/IntelliJ IDEA CE.app' is not there.
```

おそらく前にダウンロードした intelij を GUI でゴミ箱で消した影響でこうなっているのではなかろうか。

## 対処方法

`--force` オプションを追加すると無事にインストールできる [^brew-error]

```bash
brew install --cask intellij-idea-ce
```

[^brew-error]: [homebrew \- is it possible to override the legacy app when install using brew \- Ask Different](https://apple.stackexchange.com/questions/435745/is-it-possible-to-override-the-legacy-app-when-install-using-brew)
