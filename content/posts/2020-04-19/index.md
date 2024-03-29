---
title: "機械学習システムの信頼性を数値化する論文「 What’s your ML test score? A rubric for ML production systems」"
date: 2020-04-19T22:18:10+09:00
lang: ja
ShowToc: true
tags:
  - machinelearning
  - paper
  - translation
  - mlops
---

NIPS206 にて開催された [Reliable Machine Learning in the Wild - NIPS 2016 Workshop (2016)](https://sites.google.com/site/wildml2016nips/) という、`現実世界でどうやって信頼性の高い機械学習に取り組んでいくか`についてのワークショップがある。

ここで Google から発表された `What’s your ML test score? A rubric for ML production systems` がとても面白く、身になるものが多かったのでメモがてら抄訳を残しておく。

- [PDF](https://research.google/pubs/pub45742/)
- [Slide](https://0586f9b3-a-62cb3a1a-s-sites.googlegroups.com/site/wildml2016nips/SculleySlides1.pdf?attachauth=ANoY7crr9fea9TxDl1EIyOScNG1yJSo3gBkHKOq5exLlPtetuZ_EiAKL3rJq7h17Nwcx82i0CSwmLWc97IQiQdTBODUaMhMm7CBrbpU7uQXx55Km8JFTLlOMIgFflPev0_chmj41VydTan6OjwAOfeQ_U5tRz7m-HHi0rKvumbALo74j5XV0NbPaXcQDbwInz3CdFaDamzvwOH7nn0V-DADxKf6Kqkv-SA%3D%3D&attredirects=0)
- 発表動画もワークショップページにて公開されています。

## change logs

- 2021-04-25
  - この原著論文の完全版になっている論文の抄訳を新たに公開しています。
  - [[抄訳]: The ML Test Score: A Rubric for ML Production Readiness and Technical Debt Reduction](https://shunyaueta.com/posts/2020-04-25/)

---

## 概略

- 現実世界のプロダクションシステムで機械学習を使う際に、機械学習の研究実験と異なる、小さなもしくは小さくない問題がある
- テストとモニタリングはプロダクションレディの機械学習システムにとって必要不可欠
- しかし、どれくらいのテストとモニタリングをすれば十分と言えるのだろうか?
- この論文では、それらの問題を解決する `ML Test Score` という基準を提案する

## Introduciton

- Google 内で積み重ねたベストプラクティスをもとに、実行可能なテスト、そしてその機械学習システムがどのていどプロダクションレディなのかを示すスコアシステムを提案

- このスコアは、機械学習を始めたばかるのチームからエキスパートがあつまるチームまで幅広く適用可能
- 注意: 一般的な Sofware Engineering のベストプラクティスは含んでいない
- そのかわり、学習とサービングのための Unit Test Coverage の計算方法など機械学習に必要不可欠な点を抑えている

### ML Test Score の計算方法

- 各テストの加点基準
  - 1pt: 手動で実行し、その結果を文章として共有済
  - 2pt: CI に組み込まれ、自動的に反復実行済
- 最終的な ML Score は以下の基準となる
  - `0pt` : プロダクション向けというよりも研究プロジェクト
  - `1-2pt` : テストが少しはされているが、プロダクションではもっと深刻な罠がある可能性あり
  - `3-4pt` : 最初のプロダクションレディへの第一歩。しかし、さらなる投資が必要
  - `5-6pt` : 適切なテストがされているが、もっと自動化してみよう
  - `7-10pt` : 自動化されたテストとモニタリングが整備されている。重要なシステムでも適切なレベルに達している
  - `12+pt` : 卓越した自動化されたテストとモニタリング

#### 前提条件

- システムアーキテクチャの前提として、生データから特徴量を抽出し、学習システムに流し込まれる。そして推論のためにサービングされ、その機能は顧客に影響を与える。また、ソースリポジトリや CI を通したテスト、実験のバージョン管理なども可能

### 特徴量とデータセット

- 各特徴量の分布が期待した値になっているか?
  - 一例として、特徴 A が 1 から５の値を持つ、または特徴 B の最も普遍期な値として「Harry」と「Potter」が全体の 10%を占める特徴に対して、上記の分布を検証するようなテストを書き、このテストが失敗すれば外部環境が変化しモデルの変更が余儀なくされていることが把握できる
- 各特徴と目的変数の関係性そして、ペアの相関が独立してあらわれるか?
  - 個の特徴がモデルに使用される際に、
- 各特徴量のコストは検討されているか?
  - 特徴量のコストとは、各特徴を追加した際の推論速度やメモリ使用率、データ依存  やその特徴に依存することによるシステムの不安定性などの検証
- 手動作業により適切でない特徴量は使用されていないか?
- データパイプラインの中で、プライバシーコントロールが考慮されているか?
  - Access Controll の権限は機械学習システムにも適切に付与されているか検証を行う
- プロダクションモデルへ新しい特徴量を開発・追加するのに必要な日数はいくらか?
  - ちょっとしたアイデアをプロダクションで素早く検証できるチームは強い。速さはシステムの改善と外的変化の対応するために重要
- 学習とサービングで使用される特徴量生成に関わるコードすべてに対するテスト
  - 軽視されがちだが、非常に重要

### モデル開発

- 全てのモデルはコードレビューされリポジトリに格納されているか?
  - コードレビューは素晴らしい仕組みで、つまらないミスやインシデントに関わるような潜在的なものまで顕在化される
- オフラインの疑似指標とオンライン指標の関係性
  - 1%の精度がお客さまの満足度にどうつながるのだろうか? (例: CTR) この検証は意図的に劣化させたモデルなどで小規模の AB テストを通して検証可能
- チューニング可能な各ハイパーパラメータのインパクト
  - グリッドサーチやベイズ最適化は、予測性能を向上させるだけではなく潜在的な信頼性の問題を明らかにできる。例えば、データ並列によるモデルの精度の変化は大きなインパクトである
- モデルのフレッシュネス
  - 各モデルが、`昨日` VS `先週` VS `過去一年` で学習されたとしてオンラインメトリクスへの影響がどう異なるか? 全てのモデルは外部要求により更新を余儀なくされる。この評価は注意深く行い、決定していくこと
- 単純なモデルをベースラインとした検証
  - 線形モデルで少ない特徴量のモデルでベースラインを作成しよう。これは、大規模なパイプライン構築やコストのトレードオフの検証にとても効果的である
- 重要なデータを分割した際のモデル品質の検証
  - TBD: ちょっと理解しきれない
- 暗黙的バイアスへの検証
  - 例えば学習データの規模が小規模だと暗黙的なバイアスが掛かってしまう。(例：靴の認識で、男物の靴しか学習データが収集できず、女性の靴のデータがほぼ存在しないなど)

### 機械学習インフラストラクチャ

- モデルの学習の再現性検証
  - 完全に同一データから、２つのモデル作成する。両者のスコア、サンプルに対する予測結果など大きな違いがないか検証を行う
- モデルの仕様に関する検証
  - 有用な Assertion として、ロスの低下や学習ジョブがクラッシュしても復元可能など
- 完全な機械学習パイプラインテストのための結合テスト
  - 良い結合テストとは、もとのデータソースから特徴生成 → 学習 またはサービングまでをカバーする。結合テストは CI を通じて実行し、潜在的な問題をリリース前に発見するために新規リリースの前に検証される
- サービング前のモデル品質テスト
  - サンプルデータを収集して、既知の正しい出力がされるように検証を行い、集計する。 前バージョンの機械学習モデルの予測結果を用いたバックテストも良い取り組みの一つ
- 一つのサンプル、もしくはバッチ学習をモデルに送り、学習から予測までの内部状態の変化の監視
  - 少量のデータを流し、モデルの状態がどう変化するか監視するのは有効なアプローチである
- 本番環境前のカナリアリリースによるテスト
  - モデリングのコードはサービングコードと違って高頻度に変化する。それにより以前のサービングコードが新しいモデルでは動かない危険性なども発生する。この検証は、モデルがプロダクション環境下で正常に読み込まれるか、正常に推論が稼働するかを確認する。新しいモデルは常に、小規模のトラフィックで検証されるべきである
- 新しい機械学習モデルから、安全かつ素早く前の機械学習モデルに戻せるか?
  - モデルのローロバック手続きは、モデルの品質がリリースして良くなかった場合にとても便利である。以前の高性能なモデルに安全かつ素早く戻せる仕組みは非常に重要

### 機械学習のためのモニタリング指標

- 学習とサービングの両者にて、イベント発生時の不安定性の検証
  - モデルの学習時間の不安定性
    - モデルが頻繁に再学習されるような状況だと、特に問題である
  - サービング時間の不安定性
    - client 側の通信が停止したりすると、サービングされなくなる
- 学習時とサービング時でデータの不変性が保持されているかの検証
  - 例: 特徴量 A と B は、常に同一の非零の要素数を持つ、特徴量 C は常に(0,100)の範囲内かなどを検証する
- 学習したモデルと、サービングの特徴が完全に同一か
  - Training/ Serviing Skew とも呼ばれている (Concept Drift とも呼ばれています)
  - 学習したデータと本番のデータが時間経過、もしくは何らかの要因で異なってしまうことが原因です
  - Training/Serving skew は [TFX](https://github.com/tensorflow/tfx/blob/master/docs/guide/tfdv.md) で説明されている
- モデルは枯れているか?
  - 使い古されたモデルの場合、パイプラインが停止しても何が原因か把握できる。例えば、重要なテーブルを作成する毎日実行されるジョブがストップしたとして、どんなアラートが良いだろうか? \*TBD
- 学習、もしくはサービング時に`NaN` または、 無限の値が発生への検証
- 学習速度、サービング速度、スループットまたは RAM 使用率の検証
  - スケールする際に機械学習システムの計算機コストは悩みの種である。回帰テストなどで検証されるべきである
- 予測品質に関する回帰テスト
  - 外部要因により、品質が下がる場合もあるが多くの場合は現実の問題を洗い出すことができる

---

翻訳でもし怪しい部分やもっとこうしたほうが良いというところがあれば、コメントか [@hurutoriya](https://twitter.com/hurutoriya) までご連絡ください

実際読み込んで見ると、信頼性の高いモデルを届けるための秘訣が山盛りで、流石 Google 内のベストプラクティスをまとめたチェックリストですね
実際に開発している機械学習システムがあれば、この Test Score を当てはめてみてどの程度できているのか計測してみるが良さそう

機械学習エンジニアとして働く自分として、興味のど真ん中にあるようなワークショップだが、2016,2017 年の二回しか開催されておらず、非常に悲しい
逆に言えば、すごく先進的なワークショップでこのワークショップが開催されていたのは凄いことだ

自分が業務を通じて得た経験やベストプラクティスがすでに論文として世の中に公開されているのはすごく経験になるし、経験から学ぶのではなく歴史から学べるようにしていきたい！
なので、この Workshop 論文の発展形として、[The ML Test Score: A Rubric for ML Production Readiness and Technical Debt Reduction](https://research.google/pubs/pub46555/) が発表されているので読んでみる

いや、実装寄りの勉強ばかりしていたけど気分転換にこういう知識体系に触れるのすごく楽しい
