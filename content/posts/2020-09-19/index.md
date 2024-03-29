---
title: "GitHub codeowners でGithubグループを指定しても反映されない時の対処方法"
date: 2020-09-19T11:31:36+09:00
lang: ja
tags:
  - github
---

GitHub の [CODEOWNERS](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/about-code-owners) という機能を使えば、レポジトリに対する PR では設定された CODEOWNER が APPROVE を出さないとマージされないようにできます。

この機能を使うことで、例えばそのリポジトリのオーナーであるグループが必ず PR を確認しないとマージできないようにすることでコードのクオリティを保つ仕組みが作れます。

## TL;DR

- GitHub codeowners で特定のグループを CODEOWNERS に設定したいときは、そのグループをレポジトリの `/settings/access`で `Maintain` として追加しないと GitHub PR で自動的に reviwer に追加されない
- リポジトリで`.github/CODEOWNERS` のファイルを作成して、以下の形式で GitHub group を追加する

```bash
* @octo-org/codeowners-team
```

- リポジトリの設定の`/settings/access`にアクセスして、`@octo-org/codeowners-team` を `Maintain` として追加する。

\*試していないのですが、`Write` や `Triage` 権限でも問題ないかもしれません。

![repository access setting](/posts/2020-09-19/images/1.png)

この設定をしたあとに、GitHub PR を新たに作成すると、自動的に CODEOWNERS の approve がないとマージされないように設定されるはずです。

### 自分自身がハマった経緯

グループ全体のアカウントが追加されている`a-group/all`という Github Group がすでにリポジトリのアクセス権限に `Write` 権限として追加されており、全員が write 権限をもっているなら codeowners としての権限も問題ないだろうと思っていたらハマりました。

CODEOWNERS の仕組みを知ると理解できるのですが、`a-group/all` が指定したいグループの包含関係にあるからといって、そのように取り扱ってくれるわけではないということですね。
