---
title: "検索エンジンの達成度と検索チームの成熟度モデル"
date: 2021-05-12T22:33:23+09:00
lang: ja
author: Shunya Ueta
tags:
- search
- organization
- translation
---

[@rilmayer_jpさんのツイート](https://twitter.com/rilmayer_jp/status/1348151389298454528) をきっかけに、検索チームの成熟度モデルの存在を知りました。ありがとうございます!

[Eric Pugh](https://twitter.com/dep4b) さんが、検索エンジンに関する会議で公演した内容で、検索チームがどのように成熟していくかをモデル化しており、それが面白かったので備忘録として残しておく

## 更新

- 2021/05/13 : 原著者の[Eric Pugh](https://twitter.com/dep4b) さんから、抄訳のご快諾いただけました。ありがとうございます

## 翻訳元資料

- [Search Relevance Organizational Maturity Model slide](https://mices.co/mices2019/slides/pugh_search-organizational-maturity-model.pdf)
- [Haystack LIVE! 2020 Search Relevance Organizational Maturity Model](https://youtu.be/i1M2eUMXXQY)

## 検索エンジンのレベル

検索エンジンへの要求をどれだけ満たしているかをピラミッド構造でわかりやすく説明している

![翻訳 検索チームの成熟度モデル - Search Relevance Organizational Maturity Model MICES 2019 Berlin _ Eric Pugh _ @dep4b-(1).png](/posts/2021-05-12/images/1.png)

## 検索チームの成熟度モデル

7項目の検索チームの評価項目を考え、3段階で評価を行う

|   | ビジネス  | 顧客の要求の理解  | 検索技術  | 実験駆動  | UX  | コンテンツ強化  | データ保有  |
|---|---|---|---|---|---|---|---|
|  発展 |  ステークホルダーがリアルタイムKPIを使用している | データ解析から質的なデータを得ている  | カスタムプラグインを作成している  |  A/Bテスト、オフラインテストをサポートしている | 革新的な発見性を提供している(chatbot, 等)  |  NLPやデータサイエンティストの専任チームが取り組んでいる | 多種多様な、複雑かつ大規模なデータを扱っている |
|  実践 |  不定期にレポートを行っている | いくつかのユーザーテスト、基礎的な分析を行っている  | 関連性のための複雑な設定、プラグインの使用をしている | 実験は適用可能だが、A/Bテストなどはできない  | 発見しやすくするためのUIを提供している | 分類学や概念体型の適用をしている  |  データの複雑度の監視している |
|  基礎 | ビジネスインパクトが測定されていない  | クエリログは存在しない、またはユーザーテストを行っていない  | 技術スタックを適度に調整している  |  検索のテストは手作業で行い、デプロイは低頻度 | 1ページに10個の検索結果がある  | 僅かな取り組み(シノニムなど)  | とても単純なデータモデル  |

## 感想

ひと目で

- 今の自分達がどの位置にいて
- 何を目指せばいいか

わかる可視化は示唆に富むのでありがたい
