---
title: "mvn archetype:generate でJavaのプロジェクト雛形を作成する際のオプションの解説"
date: 2021-07-18T00:05:06+09:00
lang: ja
author: Shunya Ueta
tags:
  - java
---

最近、Java を業務で触っている。
門外漢の自分からすると Maven のお作法が分からなかったので、備忘録がてら残しておく。

## `mvn archetype:generate` コマンドのオプションの意味

`mvn archetype:generate` コマンドを使えば任意のテンプレートに沿ったプロジェクトを一発で作成することができる。

具体例として、Apache Beam でプロジェクト管理ツールである Maven を使って、`mvn archetype:generate` コマンドを用いて、プロジェクト作成を行う場合、[公式サイト](https://beam.apache.org/get-started/quickstart-java/)では以下のように指定されている

```
$ mvn archetype:generate \
      -DarchetypeGroupId=org.apache.beam \
      -DarchetypeArtifactId=beam-sdks-java-maven-archetypes-examples \
      -DarchetypeVersion=2.31.0 \
      -DgroupId=org.example \
      -DartifactId=word-count-beam \
      -Dversion="0.1" \
      -Dpackage=org.apache.beam.examples \
      -DinteractiveMode=false
```

| オプション名        | 意味                                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| archetypeGroupId    | `archetype`の `groupId` つまり、テンプレートを提供している作成元の識別子                                                                                                                                                                                                                                                                                                               |
| archetypeArtifactId | archetype のテンプレート。個々では beam-sdk に対応したプロジェクトテンプレートを作成している。                                                                                                                                                                                                                                                                                         |
| archetypeVersion    | テンプレートのバージョン                                                                                                                                                                                                                                                                                                                                                               |
| groupId             | [Java のパッケージ名のルール](https://docs.oracle.com/javase/specs/jls/se6/html/packages.html#7.7)に則ったすべてのプロジェクトで唯一に識別可能な識別子。今回は `org.example` が使われており、実際は識別子として機能指定なさそうな名前ではある。(実際昔のプロジェクトでは重複可能な単語が使われていることが多いが、その場合は marven に登録する際に名前が衝突して登録ができないとのこと |
| artifactId          | 任意の名前が使用可能であり、`jar` ファイルのバージョン抜きの名前を指定する。プロジェクトのパッケージ名と考えたら良さそう。これが作成されるロートディレクトリのフォルダ名                                                                                                                                                                                                               |
| version             | プロジェクトのバージョン情報                                                                                                                                                                                                                                                                                                                                                           |
| package             | クラスやインターフェースの名前空間を指す。基本的に groupid と同一だが、groupid を接頭辞にして、独自に付け足すこともある。                                                                                                                                                                                                                                                              |
| interactiveMode     | ウィザード形式の生成をするかしないか                                                                                                                                                                                                                                                                                                                                                   |

## Reference

- [Guide to naming conventions on groupId, artifactId, and version](https://maven.apache.org/guides/mini/guide-naming-conventions.html)
- [maven プロジェクトの作成 archtypeArtifactId を指定する](https://yossan.hatenablog.com/entry/2019/03/31/015458)
- [package 宣言 | java-code](https://java-code.jp/91)
