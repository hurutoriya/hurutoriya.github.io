---
title: "JupyterNotebookをリモートサーバー上で公開して、どこでも研究開発 & 講義でJupyterhubを利用する"
author: "Shunya Ueta"
date: 2017-12-23T17:48:12.894Z
lastmod: 2019-06-16T18:17:22+09:00

description: ""

subtitle: "JupyterNotebookをリモートサーバー上で公開して、どこでも研究開発 & 講義でJupyterhubを利用するお話です。"
tags:
 - 日本語 
 - Python 
 - Jupyter Notebook 
 - Education 

image: "/posts/2017-12-23_jupyternotebookをリモートサーバー上で公開してどこでも研究開発-講義でjupyterhubを利用する/images/1.gif" 
images:
 - "/posts/2017-12-23_jupyternotebookをリモートサーバー上で公開してどこでも研究開発-講義でjupyterhubを利用する/images/1.gif" 


aliases:
    - "/how-to-public-jupuyernotebook-and-jupyterhub-4034c9fa1692"
---

JupyterNotebookをリモートサーバー上で公開して、どこでも研究開発 &amp; 講義でJupyterhubを利用するお話です。




![image](/posts/2017-12-23_jupyternotebookをリモートサーバー上で公開してどこでも研究開発-講義でjupyterhubを利用する/images/1.gif)



GIF画像は下記の記事で知った`tqdm`というパッケージを使いたくなった衝動の成れの果てです。

*   [私が選ぶ2015年の”新しい”Pythonモジュール トップ5](http://postd.cc/my-top-5-new-python-modules-of-2015/)
[IPythonデータサイエンスクックブック ―対話型コンピューティングと可視化のためのレシピ集](http://amzn.to/2DGM8UA)


IPythonデータサイエンスクックブックをキッカケに研究室でもJupyterNotebookの凄さを皆が知り、MATLABのkernelを通して利用を始めたりしています。自分はPython2→MATLAB→MATLAB &amp; Python3という流れで移り変わっています。

### JupyterNotebookをリモートサーバー上で公開

コードは以下の通りです。特に問題なく公開することができました。

### 環境

*   CentOS 7系

下記の記事を参考にセットアップする。

*   [pyenvとvirtualenvで環境構築](http://qiita.com/Kodaira_/items/feadfef9add468e3a85b)

今回はpyenvを使ってPython3.5.1でホストしています。

昨日この記事を読んで、Anacondaがオススメされているので今度セットアップするときに使ってみよう。

*   [Running a public notebook server | JupyterNotebook Docment](http://jupyter-notebook.readthedocs.org/en/latest/public_server.html#notebook-public-server)

こまかい設定等は以下の記事で説明されています。IPython Notebookを対象にした記事ですが、ほとんど一緒なので問題ありません。(config.py自体がコメントで丁寧に各設定が記述されています。)

*   [IPython notebook サーバーを立ち上げる](http://qiita.com/ynakayama/items/ab3ea36fa8a7f0f6e5b3)
*   [ipython notebookをリモートサーバ上で動かす。](http://akiniwa.hatenablog.jp/entry/2013/11/25/001805)

### 参考記事

*   [iPython notebookで研究開発生活](http://qiita.com/jellied_unagi/items/10877ca7f53bda4c34fa)

### Juptyerhub : 講義でJupyterを利用する。

JupyterNotebookを講義でも活用できるようにならないかなと先生と探していたのですが、Jupyternotebookを公開するだけだとユーザー管理が不可能です。例えば `~tarou/`というディレクトリでjupyternotebookを公開すると`~tarou/`にnotebookが沢山できだれがどのノートを作ったのかが把握できないという問題点があります。

その問題点を解消するのが`JupyterHub`です。

*   [Jupyterhub](https://github.com/jupyter/jupyterhub)

Jupyterhubは標準のユーザー認証で[PAM](https://en.wikipedia.org/wiki/Pluggable_authentication_module)を利用しているので、Cent OSのユーザー名とパスワードでログインすることができます。

2016/01/29 現時点で、PAMの認証方式だと上手く認証されるときとされないときが存在しています。

PAM以外の認証方法としては[Auth](https://github.com/jupyter/jupyterhub/wiki/Authenticators)で記述されているが以下の

*   GitHub/BitBucket/MediaWiki/CILogon OAuth
*   Google OAuth
*   Local+Google OAuth (from within a Docker container)
*   LDAP Authenticator

が用意されている。大学でLADPサーバーが公開されているならそれと連携するのが一番だが、Githubなどを認証に使うのも良いんじゃないかと。

[余談]Jupyterhubの記事を探していて見つけたこの記事が面白い。UCバークレーのPh.Dの学生が教育用にどうJupyterhubを活用しているか。そして運用の段階でどのような問題がでてきたかが書かれている。海外の大学は進んでいるな~

*   [Deploying JupyterHub for Education](https://developer.rackspace.com/blog/deploying-jupyterhub-for-education/)

### 参考記事

*   [CentOS6.6(64bit)にJupyterHubをインストールする](http://estrellita.hatenablog.com/entry/2015/07/31/083202)

2016/01/29 0:52 昨日の時点では問題なくJupiterが稼働していたんですが、今は動かないので問題を解決できたらスクリーンショット載せます。
