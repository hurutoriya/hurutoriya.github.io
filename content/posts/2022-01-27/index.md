---
title: "Slack チャンネルに GitHub の特定リポジトリのrelease を通知する"
date: 2022-01-27T11:44:11+09:00
lang: ja
author: Shunya Ueta
tags:
  - slack
  - github
---

Slack 公式のヘルプページには反映されていないが、GitHub の Slack integration で特定リポジトリの release を購読してチャンネルに通知することができる。

利用用途としては、更新を追いかけておきたいリポジトリやリリースチャンネルに対して、リリースが作成されました、このリリースが次のデプロイ予定だよと通知させたい場合に便利。

Slack コマンド

```shell
# リリースを購読
/github subscribe elastic/elasticsearch releases
# デフォルトで、issues, pulls, commits, release, deployment すべてが購読されてしまうので、 releases 以外購読を解除
/github unsubscribe elastic/elasticsearch issues,pulls,commits,deployments
```

[Slack の日本語公式ドキュメント](https://slack.com/intl/ja-jp/help/articles/232289568-GitHub-%E3%81%A8-Slack-%E3%82%92%E9%80%A3%E6%90%BA%E3%81%95%E3%81%9B%E3%82%8B)にはフィードバックを送ったので、近いうちに反映されるかもしれない

## References

- [GitHub と Slack を連携させる](https://slack.com/intl/ja-jp/help/articles/232289568-GitHub-%E3%81%A8-Slack-%E3%82%92%E9%80%A3%E6%90%BA%E3%81%95%E3%81%9B%E3%82%8B)
- [integrations/slack](https://github.com/integrations/slack)
