---
title: "Makefile でコマンドの前に @ を付けると、コマンド自身は表示されず結果のみ表示される"
date: 2022-06-22T00:01:36+09:00
lang: ja
author: Shunya Ueta
tags:
- makefile
---

Makefile を眺めているとコマンドの前に`@`をつけているターゲットがあり、その効果を調べてみた[^silence-makefile]。日本語での記事が無かったので記事を書いた。

以下のように、コマンドの前に `@`をつけたコマンドとつけていないコマンド両方を実行してみる。

```makefile
echoing-silencing: 
	@echo "表示されない"
	echo "表示される"
```

```bash
> make echoing-silencing
表示されない
echo "表示される"
表示される
```

なので、例えばお役立ち事例として、Makefile でターゲットの実行時に、何を行うか説明をしたい場合に @を付けるとスッキリした文をターミナルに表示することができる。

[^silence-makefile]: https://makefiletutorial.com/ 
    >Command Echoing/Silencing
    > Add an `@` before a command to stop it from being printed  
    > You can also run make with `-s` to add an `@` before each line