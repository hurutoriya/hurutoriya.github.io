---
title: "PythonでApache beam 入門"
date: 2020-12-26T00:41:30+09:00
lang: ja
tags:
- Apache beam
- Distributed Data Pipeline
- Python
---

TensorFlowの勉強をしていたら、Apache beam を前処理に採用していたケースがあり、興味を持ったので深堀りしてみます。

興味が湧いたモチベーションとしては、

- データ量が増加しても前処理部分を難なくスケールできそう(前処理部分をスケールさせて高速に実験を回したい、並列化などはすべて良い感じにbeamに任せれそう
- バッチとストリーミングの両者に対応可能なので、柔軟な機械学習の推論サービスが提供できるのでは? (GCPの参考資料 [Data preprocessing for machine learning: options and recommendations](https://cloud.google.com/solutions/machine-learning/data-preprocessing-for-ml-with-tf-transform-pt1))
- Apache beam を触りつつ分散データ処理を学びたい

[https://github.com/jhuangtw/xg2xg#services](https://github.com/jhuangtw/xg2xg#services)

を見てみるとGoogle 内部のFlume という並列データパイプライン技術がApache beam として公開されているみたいです。

*** 

Apache beam について端的に説明すると

Apache beam は3つの考えを基礎にしています。

- Unified
  - ストリーミング、バッチの両者のケースに一つのプログラミングモデルで対応可能な統一性
- Portable
  - 実行パイプラインが複数の実行環境で実行可能な可搬性
- Extensible
  - 新しいSDK、IO Connectorsや変換ライブラリなどをを書いて共有することができる拡張性

Java, Python, Go やScalaを使ってBeam Model を作成して任意のruntime で実行する流れです。

自分はPythonが一眼手軽に書けるのでこの記事ではPythonで紹介していきます。

Version 2.14.0 からPython 3がサポートされたのは非常にありがたいですね。それまではPython 2のみをサポートしており、その影響で技術選定時に採用しづらかったのでは無いのでしょうか?

Spotify が作成しているApach BeamとDataflowのScala APIであるscioが開発されており、そちらも気になっています。

- [https://github.com/spotify/scio](https://github.com/spotify/scio)
- [https://engineering.atspotify.com/2017/10/16/big-data-processing-at-spotify-the-road-to-scio-part-1/](https://engineering.atspotify.com/2017/10/16/big-data-processing-at-spotify-the-road-to-scio-part-1/)

では、まずは実際に動かしながら学んでみようということで

[https://beam.apache.org/get-started/try-apache-beam/](https://beam.apache.org/get-started/try-apache-beam/)

を参考にApache Beam をPython SDKで試してみます

COLABで実行を試せるので便利ですね

ですが、Python2で実行されるように設定されているのでPython3で実行してみました。

実行したcolab のコードを見ていきます。

### 環境準備

`apache-beam` のinstallとGCSからApache beamで処理を行うテキストファイルをダウンロードします。

```python
# shell コマンドを実行して表示する関数
def run(cmd):
  print('>> {}'.format(cmd))
  !{cmd}
  print('')

# Install apache-beam.
run('pip install --quiet apache-beam')

# 対象ファイルの格納ディレクトリを作成後、gsutil を使って /data ディレクトリに格納
run('mkdir -p data')
run('gsutil cp gs://dataflow-samples/shakespeare/kinglear.txt data/')
```

## 文字のカウント

Hello World として単語のカウントを行うデータ処理をbeam で記述してみます。

テキストファイルを読み込んで、各単語の頻度のカウンティングを行う単純なデータパイプラインを作成しています。

パイプラインの結果はファイルシステム上で保存されるので分散環境下での大規模処理でも取り扱いに役立ちます。

```python
import apache_beam as beam
import re

inputs_pattern = 'data/*'
outputs_prefix = 'outputs/part'

with beam.Pipeline() as pipeline:
  (
      pipeline
      | 'Read lines' >> beam.io.ReadFromText(inputs_pattern)
      | 'Find words' >> beam.FlatMap(lambda line: re.findall(r"[a-zA-Z']+", line))
      | 'Pair words with 1' >> beam.Map(lambda word: (word, 1))
      | 'Group and sum' >> beam.CombinePerKey(sum)
      | 'Format results' >> beam.Map(lambda word_count: str(word_count))
      | 'Write results' >> beam.io.WriteToText(outputs_prefix)
  )
```

はい、いきなり

with beam.Pipeline() as pipeline:
の以降から意味がわからなくなりました。

Apache beam特有の概念を理解する必要があるので

[https://beam.apache.org/documentation/programming-guide/](https://beam.apache.org/documentation/programming-guide/)

を参考に解説してみます。

## Apache Beam Programming Guide

Beasm SDKで提供されるクラス郡をここでは紹介していきます。このクラス郡を使うことでデータパイプラインを作成することができます。

### Overview

まずBeamを使用するためには、まず最初にBeam SDKのクラスを使って起動プログラムを作成する必要があります。driver program は、あなたのパイプライン(入力、変形と出力のすべて)と実行環境を定義する必要があります。

Beam SDKは大規模なデータ処理のメカニズムを単純な形で抽象化している

- Pipeline
  - Pipeline はデータ処理タスクの実行開始から終了までをカブセル化するクラスです。これは入力データの読み込みやデータの変形、出力データの書き込みを含む。Beam driver programs は必ずPipelineを作成します。またPipelines 作成時には、実行オプション(どの実行環境下でどのように実行するか)を必ず明記する必要があ。
- PCollection
  - Pcollection は分散データセットを表現するクラスです。ここでのデータセットは bounded (ファイルなどの固定されたソース、つまりバッチ)とunbounded (subscriptionなど連続的にアップロードされるソース、つまりストリーム)の両者を指しています。実行するパイプラインは外部データの読み込みによって初期化されたPCollectionによって構築されます。また外部データだけでなく、インメモリのデータからPCollectionを作ることも可能です。つまり、PCollectionはPipelineの出力と入力を担当する。
- PTransform
  - PTransform パイプラインでのはデータ処理命令を表現するクラスです。すべての `PTransform` は一つ以上のPCollection オブジェクトを入力として受け取り、ゼロもしくはそれ以上の数のPCollectionを出力として作成する
- IOS transrforms
  - Beamはいくらかの入力と出力のインタフェースがあり、PTransformが読み込み、もしくは書き込みを多種多様な外部のストレージシステムに対して行う

基本的なBeamの起動プログラムは以下の手順で動く

1. Pipeline オブジェクトを作成し、パイプラインの実行オプションとパイプラインランナーを設定する
2. Pipeline データのために初期のPCollection を行う。そのためにIOs を用いて外部のストレージシステムもしくはインメモリデータから PCollectionを作成する。
3. PTransform を各 PCollection へ適用する。Transform は新しい出力としてPCollection を作成する。PCollection を変数、PTransformは関数として考えると、Pipelineは変数と関数からなる複雑な処理グラフとして捉えることができる。
4. IOs を使用し、最終的に PCollection を外部ソースに書き出す
5. パイプラインをパイプラインランナーで実行する

あなたが Beam の起動プログラムを実行した時、パイプラインランナーはPCollection を基に作成した transformが適用される workflow graph が構築される。このグラフは適切な分散処理バックエンドで、非同期ジョブとして実行される。

ここまでで Beam の基礎的な概念を理解できたと思うので最初のサンプルコードでの各行の実行内容について解説します

```python
import apache_beam as beam
import re

inputs_pattern = 'data/*'
outputs_prefix = 'outputs/part'

# ローカル環境でDirectRunnerを実行
with beam.Pipeline() as pipeline:
  # 文字の集計データをPCollection に格納
  # 各要素は (word, count) のタプルであり、(str, int)の型となっている
  word_counts = (
      # 入力のPCollection は空のパイプラインとする
      pipeline

      # テキストファイルから行を読み込む
      | 'Read lines' >> beam.io.ReadFromText(inputs_pattern)
      # Element type: str - text line

      # 正規表現を利用して行内のすべての単語に反復処理を行う
      # FlatMap will yield an element for every element in an iterable.
      | 'Find words' >> beam.FlatMap(lambda line: re.findall(r"[a-zA-Z']+", line))
      # Element type: str - word

      # 単語が存在した場合、value が１となるkey-value のペアを作成
      # すべての単語を集計していき、同一単語をグループ化する
      | 'Pair words with 1' >> beam.Map(lambda word: (word, 1))
      # Element type: (str, int) - key: word, value: 1

      # sum() 関数を使ってkeyごとにグループを行う
      | 'Group and sum' >> beam.CombinePerKey(sum)
      # Element type: (str, int) - key: word, value: counts
  )
  (
      # 入力となるPCollection は上記で作成された
      word_counts

      # 結果は文字列に処理することで、テキストファイルとして書き込み可能にする
      | 'Format results' >> beam.Map(lambda word_count: str(word_count))
      # Element type: str - text line

      # 最後に結果をファイルに書き込みます。
      | 'Write results' >> beam.io.WriteToText(outputs_prefix)
  )

#20個の結果を各ファイルから出力してみる。その際に順序は保証されない
run('head -n 20 {}-00000-of-*'.format(outputs_prefix))
```

実行結果

```python
WARNING:apache_beam.runners.interactive.interactive_environment:Dependencies required for Interactive Beam PCollection visualization are not available, please use: `pip install apache-beam[interactive]` to install necessary dependencies to enable all data visualization features.
>> head -n 20 outputs/part-00000-of-*
('KING', 243)
('LEAR', 236)
('DRAMATIS', 1)
('PERSONAE', 1)
('king', 65)
('of', 447)
('Britain', 2)
('OF', 15)
('FRANCE', 10)
('DUKE', 3)
('BURGUNDY', 8)
('CORNWALL', 63)
('ALBANY', 67)
('EARL', 2)
('KENT', 156)
('GLOUCESTER', 141)
('EDGAR', 126)
('son', 29)
('to', 438)
('Gloucester', 26)
```

どうでしたか?
まだサンプルコードを動かしただけなので使いこなす自信はありませんが、Apache beam がどのような考えで設計され動かすことができるかが少しはつかめたのでは無いのでしょうか?

次回は典型的なデータ処理をApache beamで動かしてみたいと思います。