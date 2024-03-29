---
title: "[抄訳] Data engineers vs. data scientists"
date: 2018-04-24T02:18:46.954Z
lang: ja
tags:
  - datascience
  - dataengineering
  - translation
  - machinelearning
---

データサイエンティストとデータエンジニアの定義とその誤解による悲劇、そしてそれを救う存在である機械学習エンジニア

## 紹介記事

[Data engineers vs. data scientists](https://www.oreilly.com/ideas/data-engineers-vs-data-scientists)

紹介記事を同僚から教えてもらい、面白かったので抄訳した

> [](https://twitter.com/chezou/status/980349709339394048) > [Aki Ariga](https://medium.com/u/d2572dc96c55) さんが言及していた記事と方向性が同一で面白かった。

**Data Scientists** : ビジネスサイドを理解し、他者にわかりやすく可視化と言語化できる職能。そして高度な数学的知識に基づいたモデリングやアルゴリズム提案スキルも持っている。Data Scientists には高度な Programming skill は必ずしも必須ではない、なぜならモデリングやアルゴリズムを実装するためにプログラミングを習得した人が多いからだ。システムデザインや Programming スキルは、Software Engineer や DataEngineer からみると見れたものではない(そしてそうでなくてはならない、なぜならスペシャリストだから)

**Data Engineer** : 分散プログラミングを意識して構築できる職能。DE は卓越したプログラミングスキルとシステム構成力を持つ。定義 : つまりビッグデータに対してシステム的に解決できるスキル。クラスタ設計までが Data Engineer の役割であり運用(Ops)はやらない

![image](/posts/2018-04-24/images/1.png)

from : [https://www.oreilly.com/ideas/data-engineers-vs-data-scientists](https://www.oreilly.com/ideas/data-engineers-vs-data-scientists)

- Data Scientists と Data Engineer の互いの特化したスキルは補完しあってこそ輝く。
- Data Scientist がデータパイプラインを作ると悲劇が起きてしまう。多くの企業が Data Scientist を Data Engineer として雇っているが、それは Data Scientists のスペックを活かしきれず、20–30%の効率で働かせてしまっている。そしてその ROI はめちゃくちゃ悪い。Data Scientists は適切なツールと選択肢を熟知していない(そして Data Engineer はシステムデザインと熟知しているのでミスは侵さない)
- e.g.
- 実際著者が聞いたこんな話がある。 Data Scientists が Apache Spark を使って 10GB のデータ処理を行うのに 1 回 15m の時間がかかっていた。(だが RDBMS を使えば、10ms で終わる) Data Scientist は彼らの流儀を疑うこと無く 1 日に 16 回 Spark の処理を実行しており、15mx16=240m つまり 4h の時間を無駄にしてる。RDBMS を使えば、160ms で終わるというのに…
- Data Scientist が頑張ってシステムを構築するが、職能の限界で Data Engineer しか作れないシステムなので時間とお金の浪費になった
- **実情 :** Data Scientist として雇われたのに、Data Engineer として働かざるを得ない人がほとんどだ
  **理想的な人材配置
  Case : 初期の組織**: 2–3 人の Data Engineer : DataScientist Group
  **Case : 更に複雑な事に取り組みたい** 4–5 人の Data Engineer : 1 Data Scientist
- `Data Engineer change to Data Scientist` の王道 → それが新しい職種 : **Machine Learning Engineer**!!

![image](/posts/2018-04-24/images/2.png)

from : [https://www.oreilly.com/ideas/data-engineers-vs-data-scientists](https://www.oreilly.com/ideas/data-engineers-vs-data-scientists)

- **Machine Learning Engineer** は両方の職種の経験がある。Machine Learning Engineer は Data Scientist が規律を守っていないコードのラストワンマイルを守り、データパイプラインを作る職種である。
- (_ここで バランスを取るように Data Engineer のディスりが突然入る_) Data Engineer は白黒、0–1 の世界が好きなので推測の世界(DS)が好きではない。そのため、Machine Learning Engineer は Data Scientists ,Data Engineer のふたつにまたがる存在である
- 時代の流れにより、最適化や機械学習のパッケージが揃いつつあり、既存の有名なアルゴリズムは簡単に使える。また Google Auto ML, Data Robot のように、Data Scientist の領域も代替可能な tools が普及しつつある
- **結論**: Data Scientist, Data Engineer の役割が判明した今、組織の構造変革が必要
- Data Engineer を雇って Data Scientist の代わりにデータパイプラインのシステム構築させれば皆幸せになる。
