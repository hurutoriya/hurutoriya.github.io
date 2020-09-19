---
title: "GitHub codeowners でGithubグループを指定しても反映されない時の対処方法"
date: 2020-09-19T11:31:36+09:00
lang: ja
tags:
- GitHub
---

GitHub の [CODEOWNERS](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners) という機能を使えば、レポジトリに対するPRでは設定された CODEOWNER がAPPROVEを出さないとマージされないようにできます。

この機能を使うことで、例えばそのリポジトリのオーナーであるグループが必ずPRを確認しないとマージできないようにすることでコードのクオリティを保つ仕組みが作れます。

## TL;DR

- GitHub codeowners で特定のグループをCODEOWNERSに設定したいときは、そのグループをレポジトリの `/settings/access`で `Maintain` として追加しないとGitHub PR で自動的にreviwer に追加されない

1. リポジトリで`.github/CODEOWNERS` のファイルを作成して、以下の形式でGitHub group を追加する

```bash
* @octo-org/codeowners-team
```

2. リポジトリの設定の`/settings/access`にアクセスして、`@octo-org/codeowners-team` を `Maintain` として追加する。

*試していないのですが、`Write` や `Triage` 権限でも問題ないかもしれません。

![repository access setting](/posts/2020-09-19/images/1.png)

この設定をしたあとに、GitHub PRを新たに作成すると、自動的に CODEOWNERS のapproveがないとマージされないように設定されるはずです。