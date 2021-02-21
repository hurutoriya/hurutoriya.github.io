---
title: "GKE でローリングアップデート後、ローカルからポートフォワードでリクエストを投げるとcurl: (52) Empty reply from server と返ってくるときの対処方法"
date: 2021-02-21T23:46:30+09:00
lang: ja
tags:
- k8s
- dev
---

## 前提

ローカルから`kubectl`でポートフォワードして、GKEにリクエストを投げて確認を行っている

## 発生した問題

deployment のローリングアップデート前は問題なくポートフォワードを通してリクエストが返っていた。コードに変更を加えてGKE上でも確認をしたかったので、まずローカルで確認をして問題がなかった変更が、ローリングアップデート後ポートフォワード でGKE にリクエストを投げると `curl: (52) Empty reply from server` と返ってくる。

## TL; DR;

- ポートフォワードはrolling update が終わったら貼り直そう。なぜなら、ポートフォワードの接続先はローリングアップデート前後で変化するため。

## エラーメッセージ

curl でリクエストした際のメッセージ

```bash
curl: (52) Empty reply from server
```

Port foward の出力

```bash
uid : Error: No such container: xxxxx
```

## まとめ

発生していた問題は、ローリングアップデートを行うと、ポートフォワードの接続先が変更され、その際にローリングアップデート前後でkubectl でのポートフォワードは固定されたままなのでリクエストはサーバーから返ってこないという説明するのも恥ずかしい問題でした。

理由は単純だけど、気づくのに時間がかかってしまった。k8s の動きを理解していないからこういうので時間を溶かしてしまった。反省

## Appendix

- [Performing a Rolling Update](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/)