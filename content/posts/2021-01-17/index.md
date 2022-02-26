---
title: "TFXの歴史を振り返りつつ機械学習エンジニアリングを提案する論文「Towards ML Engineering: A Brief History Of TensorFlow Extended (TFX)」"
date: 2021-01-17T00:18:47+09:00
lang: ja
author: Shunya Ueta
ShowToc: true
tags:
  - tensorflow
  - machinelearning
  - mlops
  - mlengineering
  - paper
  - translation
---

この記事は[MLOps Advent Calendar 2020](https://adventar.org/calendars/5089)の 25 日目の記事です。(盛大に遅れました)

KDD2019 の招待講演で Google が TFX の歴史について発表されており、TFX 信者の自分としては発表内容が以前から気になっていたが、公開はされておらずなんとかして見れないかな~と思っていましたが、[TensorFlow の Blog](<%5Bhttps://blog.tensorflow.org/2020/09/brief-history-of-tensorflow-extended-tfx.html%5D(https://blog.tensorflow.org/2020/09/brief-history-of-tensorflow-extended-tfx.html)>)で該当の招待講演が論文化されたことを知ったのでメモがてら抄訳として残しておく。

- _注意)この翻訳記事は原著論文の著者陣からレビューはされていません_
- _Shunya Ueta, are providing a translation and abridgment, which has not been reviewed by the authors._

## Citation

---

Karmarkar, A., Altay, A., Zaks, A., Polyzotis, N., Ramesh, A., Mathes, B., … & Li, Z. (2020). Towards ML Engineering: A Brief History Of TensorFlow Extended (TFX). arXiv preprint arXiv:2010.02013. \*\*\*

- [Towards ML Engineering with TensorFlow Extended (TFX) at KDD2019](https://www.kdd.org/kdd2019/applied-data-science-invited-speakers/view/towards-ml-engineering-with-tensorflow-extended-tfx)
- [Towards ML Engineering with TensorFlow Extended (TFX) ACM](https://dl.acm.org/doi/abs/10.1145/3292500.3340408)
- PDF は arxiv でも閲覧可能
  - [https://arxiv.org/abs/2010.02013](https://arxiv.org/abs/2010.02013)

### TFX を知らない方向け

[TFX](<(https://www.tensorflow.org/tfx)>)とは、Google が開発する TensorFlow Extended(TFX)の略称で、Google 社内で開発された TensorFlow を基にした機械学習基盤のプロジェクト。 TFX の各コンポーネントは OSS として公開されている。

## 抄訳

### Abstract

ソフトウェアエンジニアリングは成熟しつつあるが、一方で機械学習エンジニアリングはまだ成熟しきっていない。この論文では Alphabet で成功しているエンドツーエンドの機械学習基盤である Sybil, TFX の紹介を行う。主に TFX が機械学習エンジニアリングの実現にどう役立つかについて紹介していく。そして我々は機械学習による恩恵を受けるために、まずは機械学習チームの成熟と強固なインフラストラクチャ、組織内での教育活動が同時に必要であることを主張する。また、先進的なモデル開発を行う前に、容易に相互運用可能な機械学習基盤導入を強くすすめる。

### Where We Are Coming From

### Sibyl 2002-2020

2007 年から[Sibyl](https://www.datanami.com/2014/07/17/inside-sibyl-googles-massively-parallel-machine-learning-platform/) は運用開始されており、2020 年まで運用されていた。最近では開発は廃止され、TFX に移行中であり、主に非深層学習をサポートする機械学習基盤である。

TFX と同等のミドルウェアである Data Ingestion, Data Analysis and Validation, Training (of course), Model Analysis, and Training-Serving Skew Detection を解決するコンポーネントが存在している。

(といっても Sibyl は TFX の先祖みたいなものなので、TFX がこれらの機能を踏襲してると考えるのが正しそうですね)

### TFX (2017 - ?)

2015 年からは深層学習の台頭により、TensorFlow がリリースされた。TensorFlow の課題点としてエンドツーエンドの機械学習基盤としては提供されてはいないことである。Sibyl は逆に深層学習用途に対する柔軟性が足りていないのが欠点であり、それらを補うために TFX の開発を開始したのは 2017 年のことだった。偶然にも TFX は Sibyl 誕生から約十年後に開発されことになった。

TFX の運用開始から 3 年、Alphabet 内で TFX は企業レベルの機械学習基盤として数千のユーザーから使われており、数百の Alphabet (GCP 含む) の機械学習プロダクトを支えている。毎日数千の TFX のパイプラインが稼働し、エクサスケールのデータとともに数万ものモデルが生み出されており、TFX が提供する推論のリクエスト数は秒間数百万超えの規模になっている。TFX により Alphabet 内の研究成果がより早くプロダクションにリリースされ、機械学習基盤の開発よりもモデル開発に集中することが可能になった。

TensorFlow が Alphabet 内部、そして外部でも人気と衝撃を与えたのと同じく、機械学習エンジニアから TFX にも人気と衝撃が走った。外部の機械学習エンジニアからの要望を叶えるために我々は TFX を徐々に OSS で公開していった。TFX, sibyl は Google 内部の強固なインフラストラクチャから構成されており、そのおかげで OSS での公開が加速した。例えば Sibyl は MapReduce と Flume を使ったデータ処理を行っており、TFX は同じくポータビリティ性の高い Apache beam をベースにしているので OSS での公開がスムーズに進んだ。

TFX は最終的に 2019 年の頭に OSS として公開され、オンプレスミスや GCP の Cloud AI Platform Pipelines などで活用可能になった。パートナー企業も TFX を活用し始めており、実践的な機械学習の開発速度が改善されはじめている。

参考文献: [The Winding Road to Better Machine Learning Infrastructure Through Tensorflow Extended and Kubeflow](https://engineering.atspotify.com/2019/12/13/the-winding-road-to-better-machine-learning-infrastructure-through-tensorflow-extended-and-kubeflow/)

### Lessons From Our 10+ Year Journey Of ML Platform Evolution

Google での機械学習基盤の進化の旅は長くそしてワクワクするものであり、ぜひとも我々が学んだことをここで共有したい。

我々が学んだことは大きく 2 つに分類される。

この長い旅で

1. 何が変わり
2. 何が変わらなかったのか

だ。Sibyl と TFX の開発を通じで学んだことを共有するが、Google 外部での機械学習基盤開発にも適用可能だと我々は信じている。

### What Remains The Same And

何が変わらず、そしてなぜそれが残ったのか この章では Sibyl, TFX の両者の長期間の運用期間にも耐えることができた機械学習とインフラストラクチャの観点についてまず説明を行う。

### Applied ML

[Rules of Machine Learning](https://developers.google.com/machine-learning/guides/rules-of-ml#ml_phase_i_your_first_pipeline) という Google 内部での機械学習プロダクト開発で学んだ経験則を我々は公開している。

_Rules of Machine Learning の一例_

1. シンプルなルールベースとヒューリスティックから開発をまずはじめ、そこからデータを生み出し学びを深めよう。基本的にはここでルールベースのサービングシステムを開発する。
2. 次に単純な機械学習モデルに移行することで、大きな利益を実現させます。ここでやっと機械学習パイプラインが導入される。
3. 特徴量を増やし機械学習モデルも先進的なものを適用してみる。
4. SOTA を達成した機械学習モデルを適用してみまる(管理コストは増大しパイプラインも複雑になるが、それに見合った価値があることが前提である。)
5. 上記のサイクルを念頭に置いて機械学習プロダクトの開発に役立ててみよう。そして常に費用対効果(ROI)は忘れないようにするのが大事である。

我々は Rules of Machine Learning がたとえサービスドメインや稼働する基盤が異なったり、時間が経過したとしても揺るぎない価値があると信じている。特に機械学習エンジニアリングの観点において Rules of Machine Learning は我々とその読者の致命的な失敗を避ける助けになると信じており、TFX は上記の流れを極めて高速に試行するのに役立つ。

### The Discipline Of ML Engineering

Rules of Machine Learning の作成を通じ、我々はソフトウェアエンジニアリングを基にした複雑なコードとデータの処理が実行可能な頑強なシステムの理念を学んだ。ここで我々は機械学習エンジニアリングを以下のように定義する。

- 機械学習エンジニアリングの定義: ソフトウェアエンジニアリングを包含する形での実践的な機械学習の複雑性を制御するための学問

実際、機械学習エンジニアリングのすべてをまとめようとするのは、なかなか難しいが

- 我々の持っている限られた理解していることは、プラットフォームと時間を超えてうまく稼働している
- 過去から学び、相似のものとしてみなすことは強力なアプローチであり、ソフトウェアエンジニアリングの様々な視点は、機械学習エンジニアリングにより機械学習プログラミングをどう進化させれるかが分かる

参考書籍: [Software Engineering at Google: Lessons Learned from Programming over Time]()

TFX に関する基礎的な考えは、[TFX: A TensorFlow-Based Production-Scale Machine Learning Platform](https://research.google/pubs/pub46484/) にて公開されており、現在 [ML metadata](<%5Bhttps://www.tensorflow.org/tfx/guide/mlmd%5D(https://www.tensorflow.org/tfx/guide/mlmd)>) を軸にして OSS として公開されている。

では、これから機械学習エンジニアリングの基礎的な要素について、ソフトウェアエンジニアリングとの相似を基に説明を行う。

#### Data

ソフトウェアの中心がコードであるように、データは機械学習の中心的な存在である。データマネジメントはプロダクション環境での機械学習適用において挑戦的な課題である。

参考文献: [Data Management Challenges in Production Machine Learning](https://research.google/pubs/pub46178/)

まずはデータに対するユニットテストを考える。ユニットテストはコードがどのように振る舞うべきかを検証する。同様に、データ形式への明示的な期待(スキーマ、不変量や分布)を設定し検証を行うことができる。

参考文献: [Data Validation for Machine Learning](https://research.google/pubs/pub47967/)

コードリポジトリとバージョンコントロールは、コード管理の軸となっている。。データ管理を行うことができるシステムはまた機械学習エンジニアリングでも同様に重要である。TFX の ExampleGen, StasticsGen, SchmaGen と Example Validator の各種コンポーネントにより継続的な機械学習パイプラインのデータ管理、分析、検証が可能になりデータをコードのように扱うために非常に役に立つ。

参考文献: [TensorFlow DataValidation](<%5Bhttps://research.google/pubs/pub48974/%5D(https://research.google/pubs/pub48974/)>) , [The ExampleGen TFX Pipeline Component](https://www.tensorflow.org/tfx/guide/examplegen)

#### Models (機械学習モデル)

ソフトウェアエンジニアがコンパイルされたコードを作成するのと同じように、機械学習エンジニアは、データとコードを基に「コンパイル」された機械学習プログラムを作成する。コンパイルされたものが、一般的には機械学習モデルとして知られている。この 2 種類のプログラムの性質は大きく異なっている。ソフトウェアはプログラムを通して一貫性を保つが、機械学習モデルは一貫性を保つことが非常に難しい。またこの一貫性の検証は何かしらの要約された形式でしか検証できない。(例えばラベルデータの部分集合で十分な精度が出ているなどの形でしか機械学習モデルの一貫性の保証ができない)

コードとデータは時間経過により変化し、モデルもそれに伴い変化する。しかし、モデルの変化はコードやデータの変化に比べて更に複雑になる。例えば、コードに対する高いテストカバレッジはコードの一部の正しさと変化に対する高い信頼性を得ることができるが、モデルに対するテストでは、分布外のデータや因果関係を理解できるデータを作成しテストすることはとても困難である。

同じく結合テストでも同じ問題が発生し、end-to-end でのモデルの検証と理解が機械学習エンジニアリングの重要な構成要素である。

参考文献: [Slice Finder: Automated Data Slicing for Model Validation](<%5Bhttps://research.google/pubs/pub47966/%5D(https://research.google/pubs/pub47966/)>)

TFX の evaluator と InfraValidator コンポーネントはモデルの検証と理解についての機能を提供する。これらもまた機械学習エンジニアリングの大事な一要素である。

[The Evaluator TFX Pipeline Component](https://www.tensorflow.org/tfx/guide/evaluator)

### Mergeable Fragments

ソフトウェアエンジニアがプログラムを既存のパッケージを合わせて作成するのと同じように、機械学習エンジニアはコード、データ、解析、モデルの断片を合わせて機械学習パイプラインを構築する。ソフトウェアエンジニアリングと機械学習エンジニアリングの決定的な違いは、コードは不変だが、データは常に揮発性を持ってり、変化する点である。(基本的にデータは常に新しくなり続ける)。例えば、入力データの一部分でも傾向が変化した場合には、それに対応して新しいモデルを作成する必要がある。

このように作成される生成物は常に mergeable (併合可能) であることは、機械学習パイプラインにおいて重要である。例えば一つのデータセットの統計値の要約は、2 つのデータセットの和集合の統計値を簡単に要約できるように、もう一つのデータセットへ簡単に併合可能であるべきである。またモデルの観点から言えば、一つのモデルの学習を別のモデルへと簡単に転移学習できるようにしておくべきである。

しかしこれは前章で述べたモデルのテストカバレッジと同じ課題を抱えている。新しくモデルにフラグメントをマージすると、分布外データや反実仮想の評価データの作成が必要になる可能性があり、それによってモデルの複雑性があがってしまう。

TFX の Example Gen, Transform, Trainer, Tuner のコンポーネントは[TensorFlow Hub](https://www.tensorflow.org/hub/overview) で管理され、併合可能なパイプラインを作成することに役立ちます。

### Artifact Lineage (生成物の経路追跡)

ソフトウェアエンジニアリングは方法論やツールなどが高度に発展しているが、それでも常にデバッグが必要である。それは機械学習プログラムも同様の課題があるが、ソフトウェアエンジニアリングと比べると一段と難易度が増す。なぜなら、機械学習プログラムではプログラムに付随する生成物が難易度への影響を与えている。モデルのデバッグを行う際にコードの欠陥、学習アルゴリズム、学習データ、サービングパス、サービングされるデータなどいくつものエラー原因があり、それらが原因で精度の低下につながる。ソフトウェア開発において、根本原因を探すためにスタックトレースが重要なように、機械学習パイプラインではすべての生成物の生産と消費の追跡が機械学習モデルの精度劣化の根本原因の解明に役立つ。

TFX では[ML Metadata (MLMD)](https://www.tensorflow.org/tfx/guide/mlmd) を使用して、生成物を管理している。MLMD は、生成物のメタデータ管理と追跡を可能にし、機械学習パイプライン外に高い信頼性を持って生成物の管理が可能になる。

### Continuous Learning And Unlerning

プロダクション環境下での機械学習パイプラインは、動的な環境下で以下の特徴がある。

- 定期的に新しいデータが到来する
- モデルのコードは、初期段階では頻繁に変化する
- インフラ面も変化する

もし上記の変化が発生した場合、パイプラインはそれらに対して追従する必要があり、変更後の環境でパイプラインを新たに実行する必要がある。パイプライン実行の監視は、デバッグと原因究明の解析にとても有用である。例えば単純な例では、モデルの失敗原因をデバッグするためには、どのデータが学習済のモデルに使われたかだけではなく、モデルコードとパッケージのバージョンの把握が必要不可欠である。

機械学習パイプラインはそれらの変化に対して対応できる仕組みが必要である。例えば新しいデータが到来した際には、モデルの再学習が必須である。これらは推薦システムや広告関係などのように迅速に変化する環境においてごく自然に要求される。もしデータが頻繁かつ定期的に変化する環境だった場合、エンジニアが手作業でモデルの再学習を実行することが要求されているならそれは非現実的である。その代わりに TFX はパイプラインが新規のデータを検知して、モデルの再学習を行うことで継続的学習を実現し、手作業を自動化することができる。その自動化を実現するためには高度なオーケストレーションが必要である。また機械学習パイプラインは、何年間もコードとデータを取り込み、継続的に意思決定に役立つ予測を行うモデルを作成するのが一般的である。

参考文献: [Continuous Training for Production ML in the TensorFlow Extended (TFX) Platform](https://research.google/pubs/pub47978/)

次に機械学習パイプラインのために必要とされる仕組みの例では、backfilling 機能がある。例えば、モデルのパッケージやコードは更新済のものを既存のデータに適用するケースなど、エンジニアはコンポーネントが更新された状態でパイプラインを実行する必要があるかもしれない。次の backfilling が必要となる状況例として、データ関連の問題を解決するために、既存のデータの新しいバージョンに対してパイプラインを実行することが考えられる。これらの backfill は継続的学習のために直交である必要がある。実例では、エンジニアは手作業で学習ジョブを実行可能であり、モデルが生成後、そのモデルは自動的にモデルの評価と検証が実行が可能である。

[The TFX User Guide](https://www.tensorflow.org/tfx/guide) ではまだ継続的機械学習パイプラインを公開できていないが、この公開に向けて我々は動き続けている。 参考: [RFC: TFX Advanced DSL semantics #253](https://github.com/tensorflow/community/pull/253)

### Infrastructure

### Building On The Shoulders Of Giants

野心的な目標実現のために、強固な基盤を作る必要がある。TFX は Sibyl のシステムデザインの多くを再利用を行った。

- Sibyl のアルゴリズムとワークフローは MapReduce を基に実現されていたが、TFX は TensorFlow, [Apache Beam](https://beam.apache.org/)を使って、分散学習とデータ処理のワークフローを実現した
- Sybyl はカラムベースのデータ管理を行っていたが、[Apache arrow](https://arrow.apache.org/) によりインメモリでのカラムベースのデータ管理に適合した。

また、頑強な標準化が進んでいる箇所では、依存性をあえてもたせることにより TFX とその使用者にパフォーマンスとスケーラビリティを提供することに成功した。例えば、TFX の依存先でもある[Kubeflow Pipelines](https://www.kubeflow.org/docs/pipelines/overview/pipelines-overview/) や [Apache Airflow](https://airflow.apache.org/) はそれらを使用する利益が依存先の管理に勝ると判断されたので選択されました。

### Interoperability And Positive Externalities

機械学習基盤は孤立した環境で運用されるのではなく、既存のデータ基盤からの ETL やシステムへのモデルのデプロイなどの相互運用を意識する必要がある。

- Google Ads で Sibyl が相互運用されていたのと同じく、TFX では複数のサービスからのデータの ETL、サービングが複数の開発環境やデバイスに提供している
- Sibyl で Google 社内技術で相互運用されていたのと同様に、TFX は [Apache Beam](https://beam.apache.org/)は [Apache Flink](https://flink.apache.org/) や [Apache Spark](https://spark.apache.org/) のクラスターや[Google Cloud Dataflow](https://cloud.google.com/dataflow/) などのサーバーレスデータ処理を実行するために活用されている
- TFX はオーケストレーション機能の抽象化を MLMD を用いて実現し Apache Airflow, Apache Beam, Kubeflow Pipelines も選択肢の一つとして採用できるようにしている

上記で説明したように、運用が簡単になるような技術群を採用しており既存のデータ基盤との接続や、サービングなどが Alphabet 外でも容易に構築可能になっている。

また複数の技術の組み合わせは指数関数的に開発環境の設定が増加するため、マネージドサービスである [Could AI Platform Pipelines](https://cloud.google.com/blog/products/ai-machine-learning/introducing-cloud-ai-platform-pipelines) も提供を開始した。

## What Is Different And Why

ここでは、TFX を現実的な問題に適応するために変化させた部分を説明する。

### Environment And Device Portability

Sibyl は Google での大規模クラスタである [Borg](https://research.google/pubs/pub43438/) へのデプロイを前提にデザインされていた。当初、Google での機械学習適用についてこれで問題なかったが、世界的に機械学習技術の発展に伴い、Google 外部かつ大規模だけではない小規模な環境へのデプロイの必要性も高まった。その結果、ポータビリティが重視された機械学習基盤が必要になってきた(が厳密な一貫性を保つことももちろん要求される)。

- Sibyl が Google のデータセンターでのみ動くが、TFX はラップトップ、ワークステーション、外部のデータセンター、クラウド上で実行することができる。特に[Google Cloud](https://cloud.google.com/) では最適化と自動化された TFX が提供される
- Sibyl は CPU でのみ動くが、TFX は異なるハードウェア(CPU, GPU, [TPU](https://cloud.google.com/tpu) )で動く
- Sibyl で作成されたモデルはサーバー上での実行のみ可能だが、TFX はラップトップ、サーバー、[TensorFlow Serving](https://www.tensorflow.org/tfx/guide/serving), Apache Beam、モバイルや IOT では [TensorFlow Lite,](https://www.tensorflow.org/lite/guide) ブラウザ上では [TensorFlow JS](https://www.tensorflow.org/js/tutorials)によって実行可能である

小規模から大規模な問題を解くために、TFX のポータビリティ性は洗練され多種多様な環境、デバイスでの実行を可能にしている。

だがポータビリティはコストも高くなってしまう。メンテンスを行う際に、環境固有もしくはデバイス固有の特殊な要求を満たす必要があり、環境やデバイスの数が増えるとそれらは超線形にコストが増加する。が、一般の使用者はそれらのメンテンスコストは意識せず TFX を使用することが可能です。

### Modularity And Layering

Sibyl は既存のプロダクトと密結合され、モノリシックに構成されており、既存の仕様に把握して、それに合わせる必要があった。対象的に TFX はモジュラー化とレイヤー化が意識されたアーキテクチャ設計になっており、チーム間で連携しつつ開発を行えるようになっている。

TFX のレイヤーデザイン

- ML Service
  - [Cloud AutoML](https://cloud.google.com/automl)
  - [Cloud Recommendations AI](https://cloud.google.com/recommendations)
  - [Cloud AI Platform](https://cloud.google.com/blog/products/ai-machine-learning/introducing-cloud-ai-platform-pipelines)
  - [Cloud Dataflow](https://cloud.google.com/dataflow)
  - [Cloud BigQuery](https://cloud.google.com/bigquery)
- Pipelines
  - [TensorFlow Extended](https://www.tensorflow.org/tfx)
- Binaries
  - [TensorFlow Serving](https://research.google/pubs/pub46801/)
- Libraries
  - [TensorFlow DataValidation](https://github.com/tensorflow/data-validation)
  - [TensorFlow Transform](https://github.com/tensorflow/transform)
  - [TensorFlow Hub](https://github.com/tensorflow/hub)
  - [TensorFlow Model Analysis](https://github.com/tensorflow/model-analysis)
  - [TFX Basic Shared Libraries](https://github.com/tensorflow/tfx-bsl)
  - [ML Metadata](https://github.com/google/ml-metadata)

TFX のレイヤーアーキテクチャは、使用者の必要性に合わせて、開発者にはライブラリから、パイプライン、エンドユーザー向けには ML Service などを提供可能にしている。

### Multi-faceted Flexibility

Sibyl は開発当初は他の利用可能なツールに比べると、柔軟性があったが機械学習ワークフローの高速化の需要に答えることができなかったことも TFX の開発に繋がった。

- Sibyl は特定のデータ解析しか提供していなかったが、TFX は TensorFlow DataValidation により柔軟なデータ分析が可能になっている
- Sibyl は特定の mappers しか提供していなかったが、TFX は TensorFlow Transform により、カスタマイズ可能な柔軟性に長けた mappers, analyzers が使用可能になっている
- Sibyl は非深層学習のみサポートしていたが、TFX は Trainer Component により TensorFlow ベースのモデルを提供可能になっており、TensorFlow Hub などで転移学習なども容易に行えるようになっている
- Sibyl は非深層学習モデルに対する自動的な特徴量の組み合わせ(feature conjunction) のみ提供していたが、TFX では Tuner component により state of the art ベースのハイパーパラメータチューニングが利用可能になっている
- Sibyl は特定のモデルの解析手法しか提供していなかったが、TFX は TensorFlow Model Analysis により、Evaluator Component をベースにビルトインのメトリクスなど多様なモデル解析手法を提供している
- Sibyl は 固定されたパイプラインしか扱えなかったが、TFX はカスタムコンポーネントが使用可能であり、柔軟にパイプラインを設計可能である

## Where We Are Going

2020 年において、TFX の開発は[roadmap](https://github.com/tensorflow/tfx/blob/master/ROADMAP.md)、 [RFC](https://github.com/tensorflow/tfx/blob/master/RFCs.md)、 [Contribution guideline](https://github.com/tensorflow/tfx/blob/master/CONTRIBUTING.md) を基に進めています。我々は応用機械学習の普及のために、機械学習エンジニアリングのさらなる発展に尽力し、[responsible AI](https://www.tensorflow.org/responsible_ai) (TensorFlow を用いた高い信頼性を持つ機械学習開発のための方法論)を[Google の AI 原則論](https://ai.google/principles/) に基づき実世界へ適用していく。

### Drive Interoperability And Standards

相互運用性を高め、我々は原則論である、社会に利益をもたらすことを意識していく。我々のミッションとして、我々は OSS による先進的な機械学習システム構築をサポートし、機械学習による生成物の標準化も行っていく。例えば具体例として上げると

- [TFX standardized input](https://github.com/tensorflow/community/blob/master/rfcs/20191017-tfx-standardized-inputs.md)
- [TFX DSL semantics](https://github.com/tensorflow/community/blob/102bc5f3beb6ff756d147e7cbf88ffb5422a9f5c/rfcs/20200601-tfx-udsl-semantics.md), [Data model and IR](https://github.com/tensorflow/community/pull/271)
- 標準化された機械学習生成物とメタデータ
- 多様な実行環境での分散実行環境の標準化
- 分散かつストリーミングでのモデルの推論
- モバイルやエッジでの相互運用を意識した改善
- 相互運用を意識した機械学習フレームワークの改善

### Increase Automation

自動化こそ、高信頼性のプロダクションシステムの柱となる考えであり、TFX は自動化にとてつもなく投資を行っている。我々の原則論である”安全のためのビルドとテスト”、””

TFX pipeline では開発が進むことで、 [TFX Tuner](https://github.com/tensorflow/community/blob/master/rfcs/20200420-tfx-tuner-component.md) によるモデルの自動改善や、教師あり学習のモデルの多次元でのスライスでの挙動の自動検知、[Model Cards](https://modelcards.withgoogle.com/about) の自動生成もサポート、training-serving skew の自動検知も開始された。GCP での TFX は先進的な機能が提供されていく。

### Improve ML Understanding

機械学習を理解することは、プロダクション環境下に機械学習を適用する際に重要な側面の一つである。機械学習を理解するためにはモデル作成に付随する生成物の追跡( lineage) は最も重要事項の一つである。[struct2tensor](https://github.com/google/struct2tensor) (TensorFlow 内部の構造化データのパーシングライブラリ)は構造化データにおいて、学習やサービング、解析においてより役立つ TFX の技術の一つである。

### Uphold High Standards And Best Practices

高水準の標準化とベストプラクティスの共有のために、TFX チームはこれからも科学的論文の執筆・公開を継続していくことで Alphabet 外にもこのベストプラクティスが普及することを狙っていく。AutoML pipelines のベンチマークツールとして[NitroML](https://www.youtube.com/watch?v=SagSL38Kx0Q)も再現性の鍵の一つとなる。

### Improve Tooling

TFX は機械学習エンジニアリングと機械学習ライフサイクルのいくつもの段階のためのツールを提供しており、いまだこの領域は黎明期であることを願っている。

大規模かつ重要度が高いストリーミングかつレイテンシーが要求されるデータは挑戦的な課題である。TFX では Apache Beam と Cloud Dataflow の実行によりストリーミングイベントにも対応した予測を実行可能になっている。我々はこの枠組みを TensorFlow Serving でも同等のことが行えないか計画している。

更に、たくさんのツールが機械学習ワークフローでもまだ自動化が必要とされているものが多い。例えば、機械学習パイプライン実行時に、そのジョブの結果が現行のモデルよりもパフォーマンスが低いことを積極的に予測しジョブの実行を停止することで、大幅なリソースと実行時間の削減が期待できる。

## A Joint Journey

TFX の構築は、機械学習エンジニアリングの基礎の探索でもあり、多くの人々の長年の努力の累積である。

さあ、我々もあなたを"機械学習エンジニアリングに向けた" 旅に招待します。
