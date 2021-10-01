---
title: "CircleCI アプリ内の設定ファイルエディターを利用して、CI上の環境変数などローカルCLIでは確認できない挙動を素早く確認して修正する"
date: 2021-10-01T20:39:06+09:00
lang: ja
author: Shunya Ueta
tags:
- circleci
---

## TL;DR;

- Pull Requestのコミット履歴を汚さずにCircleCIのConfigmap をWeb上で編集して、CIの挙動をすぐ試せる機能がすごく便利

## 課題点

CircleCI の上のCIの挙動のデバッグをする際、ブランチにプッシュをせずに挙動が確認できる方法として[ローカルCLI](https://circleci.com/docs/ja/2.0/local-cli/)を利用する方法がある。
しかし、CIのマシン上で定義されている環境変数などは、ローカルCLIを使用しても確認することができない。

そのためコミットでCIが失敗している際には、

1. `Rerun Job with SSH`を利用してSSHで接続して、環境変数を確認
2. 再度 `config.yml` を修正して、コミットをプッシュ
3. だが、上手くいかないので1→2を繰り返す

を繰り返してしまい、コミット履歴が不用意に汚れてしまう。

## 解決方法

この問題点を解決する方法として、[CircleCI アプリ内の設定ファイル エディター](https://circleci.com/docs/ja/2.0/config-editor/)を利用するのがすごく便利だった。

この機能は、ジョブのページの右上からアクセスできる。
`Rerun` ボタンの右に`...` ボタンがあり、そのボタンをクリックすると

- Project Settings
- Configuration File

の選択項目があり、`Configuration File` をクリックすると、`config.yml` のウェブエディターが起動する。
エディターでYAMLファイルを編集後、右上の`Save and Run`ボタンをクリックすれば、PRで作成されているブランチと別のリモートブランチがCircleCIによって新たに作成されるので、もとのPRのコミット履歴を汚さずにCIの問題を修正できる。

## Reference

- [CircleCI アプリ内の設定ファイル エディターの使用](https://circleci.com/docs/ja/2.0/config-editor/)
