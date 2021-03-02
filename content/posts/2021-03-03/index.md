---
title: "GKE 上でPythonで logger.info() を行うとCloud logging では stderr に保存され、すべてエラーになるときの対処法"
date: 2021-03-03T00:29:03+09:00
lang: ja
tags:
- GCP
---

Python のアプリケーションで、Cloud logger にログを出力したいときに

1. 標準のPython logging モジュールを利用して、ログを出力する
2. Python Cloud Logging package を使用する

上記の２つの方法があります。

不必要にパッケージを増やしたくはないので、1の標準モジュールでCloud Logger へ出力できないか試してみました。

## 標準のPython logging モジュールを試す

標準のlogging モジュールでログを出力したいときに

```python
import logging

logger = logging.getLogger(__name__)

def hoge(): 
	logger.info('logging Start 2021')
```

と、logging.info() を仕込んで、Cloud logger にログを出力してみると、logger.info() で出しているはずなのに、Cloud logger 上ではすべてエラーとして扱われてしまっています。

原因を特定するために、logger のログを見てみると logger.info() がすべて `stderr`標準エラーストリームへ出力されてしまっています。

```bash
{
  "textPayload": "2021-02-20 21:26:51,012 - root:predict:36 - INFO:  logging Start\n",
	...
  },
  "timestamp": "2021-02-20T12:26:51.013213826Z",
  "severity": "ERROR",
  "labels": {
	...
  },
  "logName": "projects/.../logs/stderr",
  "receiveTimestamp": "2021-02-20T12:26:55.050911180Z"
}
```

そのため、明示的に標準出力へ出力先を変更してみました。

```python
import logging
import sys

logger = logging.getLogger(__name__)
handler = logging.StreamHandler(sys.stdout)
logger.addHandler(handler)

def hoge(): 
	logger.info('logging Start 2021')
```

これで解決できているはずと、Cloud Loggerを見てみると

![Cloud logging duplicate log in stderr and stdout](/posts/2021-03-03/images/clooudlogging_stderr.png)

なぜか、`stderr` への出力は残ったまま、`stdout`への出力が新たに増えました。このままでもINFO レベルでログは残せているので目的は達成できていますが、`stderr`への出力が残ってしまっているせいでCloud logger 上でエラーが発生しているようになり問題です。なので、これを避けるために２つ目の方法であるPython Cloud Logging package を利用してみます。 (というかパッケージをむやみに増やしたくないのだが利用せざるを得ない。)

## Python Cloud Logging package を使用する

まず[Python Client for Cloud Logging](https://github.com/googleapis/python-logging) のチュートリアルをすすめて行きます。

Cloud logging のPython package の[Quick Start](https://github.com/googleapis/python-logging#quick-start) にてわかりやすく導入方法が紹介されています。ここで混乱しやすいのが、GCPの[Logging Client Libraries](https://cloud.google.com/logging/docs/reference/libraries#cloud-console) のドキュメントではまずService Account を作って、`GOOGLE_APPLICATION_CREDENTIALS` を使用してCloud Logging の認証を行ってくださいと書かれています。

ですが、

- [GCP上でのVMでパッケージを使用するなら認証は必要ない](https://googleapis.dev/python/google-api-core/latest/auth.html) 。ただし、デフォルトのSAを使いたくない場合や、GCP外などで動かしたい場合はSAが必要

と本元のパッケージのドキュメントでは書かれており、こちらのほうが誤解が少なくていいですね。(公式ドキュメントだと、SA作成時に `Project > Owner` を指定しろと書かれているんだけど、これって権限過多なのでは無いのだろうか??)

ちなみにGCP 上の認証過程はこちらのドキュメントが詳しく書かれているので、気になった方は御覧ください。

[Authenticating as a service account](https://cloud.google.com/docs/authentication/production)

上記の認証仮定をまとめると

1. GOOGLE_APPLICATION_CREDENTIALS を参照する
2. ADC (Application Default Credentials) が、コードに紐付けられているSAを使用する
3. ADCは各サービスのSAを利用する
4. 1-3 が使用できなかった場合、認証エラーが発生する


最終的にGKE上でCloud logging へログを出力するためには、
以下のコードで無事に `INFO` のログが`stderr` に吐き出されることなく、`stdout` のみに`INFO`として出力されるようになります。

```python
import logging
import sys
# NOTE: GKE ではCotainerEngineHandler が必要
from google.cloud.logging.handlers import ContainerEngineHandler

logger = logging.getLogger(__name__)
# NOTE: stream で stdout を指定する
logger.addHandler(ContainerEngineHandler(name=__name__, stream=sys.stdout))
# NOTE: ログが重複して出力されるので、propagate を切る
logger.propagate = False

logger.info('Hello Cloud Logging.')
```

## Appendix

- [https://docs.python.org/3/howto/logging.html](https://docs.python.org/3/howto/logging.html)
- [https://cloud.google.com/logging/docs/setup/python](https://cloud.google.com/logging/docs/setup/python)
- [https://www.ai-shift.co.jp/techblog/1217](https://www.ai-shift.co.jp/techblog/1217)
- [https://stackoverflow.com/questions/48078051/duplicate-log-entries-with-google-cloud-stackdriver-logging-of-python-code-on-ku](https://stackoverflow.com/questions/48078051/duplicate-log-entries-with-google-cloud-stackdriver-logging-of-python-code-on-ku)
  - 同じような質問があった
