---
title: "Apache Beam 2.40 で導入された scikit-lean, Pytorch の効率的な推論が可能になる RunInference API を試してみる"
date: 2022-08-18T19:38:29+09:00
lang: ja
author: Shunya Ueta
tags:
  - apachebeam
  - machinelearning
  - python
---

`2022-07-21` に Google Cloud が Cloud DataFlow の新機能として、DataFlow ML という新機能を発表した。[^dataflowml]

> **Dataflow ML** - Speaking of ML transforms, Dataflow now has added out of the box support for running PyTorch and scikit-learn models directly within the pipeline. The new RunInference transform enables simplicity by allowing models to be used in production pipelines with very little code. These features are in addition to Dataflow's existing ML capabilities such as [GPU support](https://cloud.google.com/dataflow/docs/guides/using-gpus) and the pre and post processing system for ML training, either directly or via frameworks such as [Tensorflow Extended (TFX)](https://www.tensorflow.org/tfx).

DataFlow は Apache Beam で記述したプログラミングモデルの実行環境だ。
主に、バッチ処理・ストリーミング処理で使われており、機械学習に欠かせないデータ処理の観点からして非常に面白いと思っているソフトウェアなので、積極的に動向を追っている。

DataFlow ML は簡単に説明すると、PyTorch と scikit-learn が Dataflow のパイプライン内部で直接推論可能になった。
直近では Python SDK に限るが DataFlow で GPU の利用が可能になったりと、大規模データ処理や機械学習を行う際に魅力的な機能が続々とサポートされはじめた。
DataFlow ML の実態は [Apache Beam 2.40.0](https://beam.apache.org/blog/beam-2.40.0)で追加された RunInference API だ。
RunInference API の DesignDocs [^designdocs]が公開されているので、それを見てみる。
機械学習システムの DesignDocs として非常に面白いので興味がある人は、見てみると面白いとおもう。

## DesignDocs: RunInference: ML Inference in Beam

RunInference API が作られた背景として、TensorFlow だけが Beam 内部で、処理するデータ( Apache beam では`PCollection` と呼ばれる) に対して、推論を行うための [ RunInference transformer](https://github.com/tensorflow/tfx-bsl/blob/master/tfx_bsl/beam/run_inference.py) (Apache Beam では `PTransform`と呼ばれ、`PCollection` を入力として処理を行う) が存在しており、実装不要だった。

- 問題点としては
  - Beam のレポジトリに存在せず、[tensorflow/tfx-bsl](https://github.com/tensorflow/tfx-bsl)のリポジトリに存在している。
  - TFX ライブラリに特化した API になっている
  - サンプルコードが充実しておらず、学習コストが高い

この DesignDocs の目的は、RunInference API を以下の 2 つの人気のある機械学習フレームワークで使えるように実装すること

- scikit-learn
- PyTorch

実装方法としては、

- 内部の最適化が行われているべき
- 単純かつ統合されたインターフェイスで提供されるべき
- 入力と出力が、機械学習エンジニアに対して、直感的な型になっているべき
  - scikit-learn なら numpy
  - PyTorch なら Tensors

最終的なゴールとしては、XGBoost や JAX など他の機械学習フレームワークにも適合したり、Vertex AI など外部のサービスも使えるようにしたい。

内部の実装方針は DesignDocs で詳細に議論されているので、そこは割愛して、まずは RunInference API のサンプルコードを動かしてみる。

## サンプルコードを通じて学ぶ

[Example RunInference API pipelines](https://github.com/apache/beam/tree/master/sdks/python/apache_beam/examples/inference)にサンプルコードが公開されていたので、動かしてみる。
まずは一番簡単そうなサンプルコードである scikit-learn による MNIST 分類を動かしてみる。
最初にドキュメントをじっくり読むよりも実際にコードを見たほうが理解が深まるので実際に動かしてみるのが近道。
サンプルコードはこちら[beam/sdks/python/apache_beam/examples/inference/sklearn_mnist_classification.py](https://github.com/apache/beam/blob/master/sdks/python/apache_beam/examples/inference/sklearn_mnist_classification.py)
公式のサンプルコードだと、推論対象の入力データと学習済みの scikit-learn のモデルを自前で用意する必要があるのでコマンド一発でサンプルコードを動かせるコードを以下のレポジトリに公開しました。
将来的には scikit-learn だけでなく、PyTorch にも対応したい。

https://github.com/hurutoriya/beam-runinferenceapi-sample

実際に何をやっているかの解説は、日本語のコメントを添えて解説してみます。

```python
"""このパイプラインは、RunInference APIを使って、MNISTデータの分類を行う。

このパイプラインは、int 形式でCSV形式で保存されているテキストファイルを読み込む。CSVの１つ目の列はラベル、そのほかの列はMNISTのピクセルの値を格納している。データは学習済みのモデルで推論される。このパイプラインは output ファイルに推論結果の書き込みを行い、ラベルと推論結果の比較を行うことができる。
"""

import argparse
from typing import Iterable
from typing import List
from typing import Tuple

import apache_beam as beam
from apache_beam.ml.inference.base import KeyedModelHandler
from apache_beam.ml.inference.base import PredictionResult
from apache_beam.ml.inference.base import RunInference
from apache_beam.ml.inference.sklearn_inference import ModelFileType
from apache_beam.ml.inference.sklearn_inference import SklearnModelHandlerNumpy
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.options.pipeline_options import SetupOptions

def process_input(row: str) -> Tuple[int, List[int:
  """入力データをラベルとピクセルに分けて、返す
  """
  data = row.split(',')
  label, pixels = int(data[0]), data[1:]
  pixels = [int(pixel) for pixel in pixels]
  return label, pixels


class PostProcessor(beam.DoFn):
  """予測ラベルを得るために予測結果を処理する。CSV形式で、真値と予測ラベルを返す。
  """
  def process(self, element: Tuple[int, PredictionResult]) -> Iterable[str]:
    label, prediction_result = element
    prediction = prediction_result.inference
    yield '{},{}'.format(label, prediction)


def parse_known_args(argv):
  """引数を定義"""
  parser = argparse.ArgumentParser()
  parser.add_argument(
      '--input_file',
      dest='input',
      required=True,
      help='text file with comma separated int values.')
  parser.add_argument(
      '--output',
      dest='output',
      required=True,
      help='Path to save output predictions.')
  parser.add_argument(
      '--model_path',
      dest='model_path',
      required=True,
      help='Path to load the Sklearn model for Inference.')
  return parser.parse_known_args(argv)


def run(argv=None, save_main_session=True):
  """パイプラインを定義"""
  known_args, pipeline_args = parse_known_args(argv)
  pipeline_options = PipelineOptions(pipeline_args)
  pipeline_options.view_as(SetupOptions).save_main_session = save_main_session

  # この例では、RunInference トランスフォームにキーとなる入力を渡している。それによって、SklearnModelHandlerNumpy のラッパーである KeyedModelHandler を使用している。
  model_loader = KeyedModelHandler(
      SklearnModelHandlerNumpy(
          model_file_type=ModelFileType.PICKLE,
          model_uri=known_args.model_path))

  with beam.Pipeline(options=pipeline_options) as p:
	# 入力データを読み込む
    label_pixel_tuple = (
        p
        | "ReadFromInput" >> beam.io.ReadFromText(
            known_args.input, skip_header_lines=1)
        | "PreProcessInputs" >> beam.Map(process_input))
	# 推論して後処理を行う
    predictions = (
        label_pixel_tuple
        | "RunInference" >> RunInference(model_loader)
        | "PostProcessOutputs" >> beam.ParDo(PostProcessor()))
	# 後処理したデータを出力してファイルとして保存する
    _ = predictions | "WriteOutput" >> beam.io.WriteToText(
        known_args.output,
        shard_name_template='',
        append_trailing_newlines=True)


if __name__ == '__main__':
  run()
```

## RunInference API についてドキュメントから学ぶ

RunInference API のドキュメント[^runinferenceapidocs]が既に公開されているので、読み込むことで実際にどんな概念で作成されているのか理解できる。
Apache Beam の基礎的な概念や用語については、この記事を読む前に過去に書いた Apache beam Python 入門を読んでいただけると、この記事が分かりやすく読めると思います。

### なぜ RunInferenceAPI を使うのか?

そもそも僕の疑問は「今まで、Beam で PyTorch や scikit-learn のモデルを使って推論は可能だったが、 RunInferenceAPI は何が嬉しいのか?」への答えがドキュメントに書いてありました。

- `BatchElements`トランスフォームや`Shared`クラスなど既存の Apache Beam の概念に沿って、機械学習の推論処理を最適化が可能になる。またマルチモデルパイプラインなど、複雑なパイプラインの構築も比較的簡単に構築できるようになる。

### BatchElements PTransform とは

多くのモデルが実装しているベクトル化推論の最適化を利用するために、モデルの予測を行う前の中間段階として、BatchElements トランスフォームの追加した。このトランスフォームは、要素をバッチ処理する。そして、バッチされた要素は、RunInference の特定のフレームワークのための変換で適用される。例えば、numpy の ndarrays の場合は numpy.stack()を、torch の Tensor 要素の場合は torch.stack()を呼び出す。

beam.BatchElements の設定をカスタマイズするには、ModelHandler の中で、batch_elements_kwargs 関数をオーバーライドする必要がある。例えば、`min_batch_size` でバッチあたりの要素数の最小値を設定し、`max_batch_size` でバッチあたりの要素数の最大値を設定する。
詳しいドキュメントは[こちら](https://beam.apache.org/releases/pydoc/current/apache_beam.transforms.util.html#apache_beam.transforms.util.BatchElements)

### Shared helper class

RunInference API で`Shared` クラスを使用することにより、プロセスごとに一度モデルを読み込んだ後に各プロセス内部でその読み込んだモデルを`DoFn`(全ての`PCollection`に適用される処理ロジックを保持する)内で共有することができる。このクラスを使えば、モデルの読み込み時間とメモリ消費を削減することができる。

詳しいドキュメント(ソースコード)は[こちら](https://github.com/apache/beam/blob/master/sdks/python/apache_beam/utils/shared.py#L20)。内部の処理ロジック自体 100 行未満で書かれているので、読んで見るのもあり。

### 機械学習モデルを使うためにパイプラインを構築する

以下のコードを Apache Beam のパイプラインに追加すれば、RunInference トランスフォームを使用できる。

```python
from apache_beam.ml.inference.base import RunInference
with pipeline as p:
   predictions = ( p |  'Read' >> beam.ReadFromSource('a_source')
                     | 'RunInference' >> RunInference(<model_handler>)
```

`model_handler` は、モデルのハンドラーのためのセットアップコードで、モデルのインポートができる。
以下のような`ModelHandler`の例がある

```python
from apache_beam.ml.inference.sklearn_inference import SklearnModelHandlerNumpy
from apache_beam.ml.inference.sklearn_inference import SklearnModelHandlerPandas
from apache_beam.ml.inference.pytorch_inference import PytorchModelHandlerTensor
from apache_beam.ml.inference.pytorch_inference import PytorchModelHandlerKeyedTensor
```

モデル A と モデル B の推論結果を並列して行ったり、

```python
with pipeline as p:
   data = p | 'Read' >> beam.ReadFromSource('a_source')
   model_a_predictions = data | RunInference(<model_handler_A>)
   model_b_predictions = data | RunInference(<model_handler_B>)
```

アンサンブルも柔軟に記述できる。

```python
with pipeline as p:
   data = p | 'Read' >> beam.ReadFromSource('a_source')
   model_a_predictions = data | RunInference(<model_handler_A>)
   model_b_predictions = model_a_predictions | beam.Map(some_post_processing) | RunInference(<model_handler_B>)

```

また、衝撃なのが、Apache Beam 2.41.0 移行は [Multi Language SDK](https://beam.apache.org/documentation/programming-guide/#multi-language-pipelines)によって、 Java からも RunInference API を使うことができるらしい。
これってモデル構築は Python で行って、運用は安定した Java で実行可能ということなので凄い機能ですね。

https://github.com/apache/beam/blob/master/sdks/java/extensions/python/src/main/java/org/apache/beam/sdk/extensions/python/transforms/RunInference.java

Multi Language SDK も非常に面白そうだが、まだ使ったことはないので、実際にコードをかきつつ理解を深めたい。

## まとめ

Apache Beam 2.40.0 から利用可能になった RunInference API についてサンプルコードと共に何をやっているかをまとめました。

Apache Beam はとても未来を感じるソフトウェアなので、この OSS にコントリビュートできる余地があれば積極的にやっていきたい。
そのため、これからはちょっとした Beam の勉強メモなども積極的に公開されていくと思います。

[^runinferenceapidocs]: [Apache Beam Python Machine Learning](https://beam.apache.org/documentation/sdks/python-machine-learning/)
[^designdocs]: [RunInference: ML Inference in Beam](https://docs.google.com/document/d/1bVMU7Uo9Nzuu6aXR702j74nhQK4j6J1lkRVVBRySI0g/edit#heading=h.cqivojrr7lme)
[^dataflowml]: [Latest Dataflow innovations for real\-time streaming and AI/ML \| Google Cloud Blog](https://cloud.google.com/blog/products/data-analytics/latest-dataflow-innovations-for-real-time-streaming-and-aiml)
