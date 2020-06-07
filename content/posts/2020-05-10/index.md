---
title: "Software Engineering for Machine Learning: A Case Study を読む"
date: 2020-05-10T17:13:34+09:00
lang: ja
draft: true
tags:
  - Paper
  - Machine Learning
  - MLOps
---

## TL;DR;

- MicroSoft の Software team が機械学習を活用したアプリを開発する際に得られたベストプラクティスを共有
- 9 段階の開発フローを定義

主に

1. 従来のソフトウェアエンジニアと比較してデータに対する発見、管理、バージョニングが必要で複雑かつ困難になる要素
2. モデルのカスタムと再利用はの要求は従来のソフトウェアエンジニアチームに要求されるものと異なる
3. 機械学習コンポーネントは個別のモジュールとして扱うことが難しく、モデル同士が複雑に絡み合いエラー発生が増大する傾向にある

## Introduction
