---
title: "Elasticsearch の Go client で有名な olivere/elastic がES8 以降はサポートしないので、利用者は公式クライアントに移行しよう"
date: 2022-12-13T22:18:45+09:00
lang: ja
author: Shunya Ueta
tags:
  - elasticsearch
  - go
---

Elasticsearch を Go lang から利用できるクライアントライブラリで、非公式なパッケージでは[olivere/elastic](https://github.com/olivere/elastic)があります。
このパッケージはかなりの人気を誇っており、なんと 2012 年から開発され現状 Elasticsearch v1.0 からすべてのバージョンをサポートしています。
素晴らしい OSS ですね。

## ES8 をサポートせずにメンテナンスモードに入る経緯

ES8 以降のサポートをどうするか決めあぐねている現状の経緯はこちらの issue に olivere さんから直接説明してくれています。
直接 olivere さんの意見を読んだほうが良いので、引用のみしておきます。

[Announcement: Future directions \(updated on 2022\-07\-22\) · Issue \#1533 · olivere/elastic](https://github.com/olivere/elastic/issues/1533)

> Finally a word about this repository. I'm sorry about all the people still waiting for an Elastic v8 version, waiting for their PRs to be merged and issues to be answered. I had a hard time personally over the last two years, and when I had to decide whether working on Elastic or focusing on my health is the top priority, I always decide for the latter. Now that I've seen the future of the Go client for Elasticsearch, I couldn't be happier, and I'll be the first one to switch and use the typed API client. So, unfortunately, and sad to some extend, but I have to say: **Elastic v8 won't happen.** I will polish v7 if I have the time and energy, but v8 won't happen. I'm sorry.

作成者の Olivere さん、お疲れさまでした。
10 年間の OSS 開発と何千時間もの時間の投資には経緯しか抱けません。

Buy Me a Coffee] というサービスで [Olivere さんを支援](https://www.buymeacoffee.com/Bjd96U8fm)できるので、もしご機会のある方は支援しても良いかもしれません。[^bmc]

## 余談

この issues がきっかけで知りましたが、Typed API や specification の存在をしりましたが、とても面白そうですね。

- [TypedAPI: Integration of the first working version in the client by Anaethelion · Pull Request \#508 · elastic/go\-elasticsearch](https://github.com/elastic/go-elasticsearch/pull/508)
- [elastic/elasticsearch\-specification: Elasticsearch full specification](https://github.com/elastic/elasticsearch-specification)

[^bmc]: 僕は、この issue を見て感銘を受けたのですが、気がついたら投げ銭していました。 https://www.buymeacoffee.com/Bjd96U8fm
