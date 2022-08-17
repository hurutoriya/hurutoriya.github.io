---
title: "KDD2022 で気になった研究"
date: 2022-08-15T23:35:35+09:00
lang: ja
author: Shunya Ueta
tags:
  - machinelearning
  - paper
---

2022/08/14 - 2022/08/18 に開催される [Knowledge Discovery and Data Mining (KDD) 2022](https://kdd.org/kdd2022/index.html) の情報が出揃ってきたので、気になった情報をメモしておく。

自分が気になるトピックは、変わらず機械学習の実応用とその周辺領域なのでそれに偏ったリストになっている。

## ADS invited speaker

[KDD 2022 ADS Invited Speakers](https://kdd.org/kdd2022/ADSSpeaker.html)

An overview of AWS AI/ML’s recent contributions to open source ML tools: Accelerating discovery and innovation

招待講演は確か毎回論文化されて ACM で公開されるので論文公開されたらぜひ読みたい。

## Tutorias

[KDD 2022 Tutorials Schedule](https://www.appsheet.com/start/52fdb507-2f8c-41d8-a982-b6bd18933ba8#appName=KDD2022TutorialsRoomFinal-1001136659&group=%5B%5D&sort=%5B%5D&table=KDD2022Tutorial0716&view=KDD+2022+Tutorials) に Tutorial の情報がまとまっているが、タイトルだけでウェブサイトへのリンクが一切なく、読み手に不親切なので来年は、改善してほしい。去年は[そんなことなかった](https://kdd.org/kdd2021/tutorials)ので、なんとか来年はもとに戻って欲しい。

- Graph-based Representation Learning for Web-scale Recommender Systems. Authors: Ahmed El-Kishky (Twitter)\*; Michael Bronstein (Twitter); Ying Xiao (Twitter); Aria Haghighi (Twitter)
  - Twitter が開催する Tutorial で、すごく面白そうなのだが全く情報が見つからなかった。[Twitter Cortex](https://cortex.twitter.com/en.html) にも情報が更新されていないので、しばらくしたら公開されていることを祈る。
- New Frontiers of Scientific Text Mining: Tasks, Data, and Tools. Authors: Xuan Wang (University of Illinois at Urbana-Champaign)\*; Hongwei Wang (University of Illinois Urbana-Champaign); Heng Ji (University of Illinois at Urbana-Champaign); Jiawei Han (UIUC)
  - こちらも情報を発見できなかった。
- [Modern Theoretical Tools for Designing Information Retrieval System](https://moderntoolsfornextgenirs.github.io/). Authors: Da Xu (Walmart Labs)\*; Chuanwei Ruan (Walmart Labs); Bo Yang (Linkedin)
  - arxiv で[Tutorial: Modern Theoretical Tools for Understanding and Designing Next-generation Information Retrieval System](https://arxiv.org/abs/2203.13962) も公開されている。WSDM2022 チュートリアルでも同じチュートリアルが開催されていた模様。チートシート的に、情報検索の領域でどんなツール(理論)を使えばいいのかを紹介してくれているチュートリアル。
- [Model Monitoring in Practice](https://sites.google.com/view/model-monitoring-tutorial): Lessons Learned and Open Challenges. Authors: Krishnaram Kenthapadi (Fiddler AI)\*; Himabindu Lakkaraju (Harvard); Pradeep Natarajan (Amazon.com Inc.); Mehrnoosh Sameki (Microsoft Azure AI)
  - モデルの監視に関するチュートリアル。大前提としては、モデルの監視は、デプロイ後に必須の時代でどんな課題が今まで存在しており、どう実現するかをツールを交えて講義。そして最終的にはモデルの監視がガバナンス向上や責任のある AI につながっていくことについて話している。
- Reward Optimising Recommendation using Deep Learning and Fast Maximum Inner Product Search. Authors: Imad Aouali (ENS Paris-Saclay); Benjamin Heymann (Criteo); Martin Bompaire (Criteo); Achraf Ait Sidi Hammou (Criteo); Sergey Ivanov (Criteo); Amine Benhalloum (Criteo); DAVID J ROHDE (CRITEO)\*; Flavian Vasile (Criteo); Maxime VONO (Criteo); Otmane Sakhi (Criteo)
  - こちらも情報を発見できなかった
- [Deep Search Relevance Ranking in Practice.](https://dlranking.github.io/dlrr/) Authors: Linsey Pang (Salesforce)\*; Wei Liu (University of Technology Sydney); Moumita Bhattacharya (neflix); Keng-hao Chang (Microsoft); Xue Li (Microsoft); xianjing liu (twitter); Stephen Guo (Walmart Labs)
  - 検索のための深層学習によるレリバンスモデルのハンズオンチュートリアル。Jupyter notebook を通して手を動かしながら学べる。

## Workshops

[KDD 2022 Workshop](https://kdd.org/kdd2022/workshop.html)は、すべてリンクがまとめられていた。素晴らしい。
論文投稿を募集するから外的にわからないと開催できないので納得。

- [Workshop on Applied Machine Learning Management](https://wamlm-kdd.github.io/2022/)
  - 機械学習プロジェクトのマネジメントや機械学習のプロダクト開発と、超実践的な領域に焦点を当てたワークショップ
  - これは一番面白そうなワークショップで、ぜひとも資料を全公開していただきたいが、現状なにも情報は公開されていない。
- [Fragile Earth 2022 \- AI for Good Foundation](https://ai4good.org/fragile-earth-2022/)
  - ソーシャルハッピーのために機械学習をどう活用するかのワークショップ。災害予測や犯罪の予防などがトピック
- [Workshop on Decision Intelligence and Analytics for Online Marketplaces: Jobs, Ridesharing, Retail, and Beyond](https://sites.google.com/view/kdd22onlinemarketplaces)
  - オンラインマーケットプレイスでの課題をどう解決するかに焦点をあてたワークショップ。
- [Document Intelligence Workshop @ KDD 2022 DI@KDD2022](https://document-intelligence.github.io/DI-2022/)
  - 今年で 3 回目の開催となるワークショップ。現実世界の書類をどのように理解(例えば OCR など)して活用するかについて焦点をあてている。
  - 現実世界のデータって全部紙なので、それを構造化してデジタル化するってものすごく大変だけどやりきった先に競合優位性が発生し、とんでもない価値を生むと思うのでこの領域は気になっている。
- [First Content Understanding and Generation for E-commerce Workshop](https://content-generation.github.io/workshop/)
  - e コマースでのコンテンツ生成に関するワークショップ。e コマースに関わっている方ならおもしろトピック満載です。
- [ESCI Challenge for Improving Product Search](https://amazonkddcup.github.io/)
  - 後述する KDD Cup の成果がこのワークショップで公開される。既に論文が公開されており、読むのが非常に楽しみ
- [KDD  online and adaptive recommender systems Workshop](https://oars-workshop.github.io/)
  - リアルタイムでの推薦システム構築に関して焦点を当てたトピック。

## KDD Cup

[Search Engineering Newsletter vol.05](:/58287871c6a94f2581e856e6c6fb55f2) で言及した Amazon が主催する KDD カップ。
自分が e コマースの検索システム開発に携わっているので、このタスクは非常に興味がある。

Amazon Product Search
https://www.aicrowd.com/challenges/esci-challenge-for-improving-product-search

## Papers

論文関係は数が多いので、見出しだけで面白そうだなと思った論文をリスト化した。
時間がある時にこのリストから選んでみたい。
全ての論文が網羅されているのページがこちら。
https://kdd.org/kdd2022/toc.html

KDD のサイトで提供されているトラックごとのページは抜け漏れ?がある模様
https://kdd.org/kdd2022/researchPosterAssignments.html
ポスターだけに絞っているからそうなっている?

会社ごとの論文は、会社によってはまとめられているので便利。
自分は職業柄、e コマースに関するに関する課題に向き合っている Amazon の論文が好きな事が多い。

- [KDD 2022 \- Amazon Science](https://www.amazon.science/conferences-and-events/kdd-2022)
- [KDD 2022 \- Apple Machine Learning Research](https://machinelearning.apple.com/updates/apple-at-kdd-2022)

## Research Track Full Papers

- HyperLogLogLog: Cardinality Estimation With One Log More
- Streaming Graph Neural Networks with Generative Replay
- Non-stationary A/B Tests
- A Generalized Backward Compatibility Metric
- On-Device Learning for Model Personalization with Large-Scale Cloud-Coordinated Domain Adaption

## SESSION: ADS Track Papers

- ItemSage: Learning Product Embeddings for Shopping Recommendations at Pinterest
- Graph-based Multilingual Language Model: Leveraging Product Relations for Search Relevance
- Amazon Shop the Look: A Visual Search System for Fashion and Home
- TwHIN: Embedding the Twitter Heterogeneous Information Network for Personalized Recommendation
- Automatic Generation of Product-Image Sequence in E-commerce
- Alexa Teacher Model: Pretraining and Distilling Multi-Billion-Parameter Encoders for Natural Language Understanding Systems
- Automatic Controllable Product Copywriting for E-Commerce
- Learning Backward Compatible Embeddings
  - 埋め込み空間の後方互換性に関する研究
- Rax: Composable Learning-to-Rank Using JAX
- A/B Testing Intuition Busters: Common Misunderstandings in Online Controlled Experiments
- TaxoTrans: Taxonomy-Guided Entity Translation
- Persia: An Open, Hybrid System Scaling Deep Learning-based Recommenders up to 100 Trillion Parameters
  - [PersiaML/PERSIA: High performance distributed framework for training deep learning recommendation models based on PyTorch\.](https://github.com/PersiaML/PERSIA) PyTorch による深層学習ベースの推薦モデルを分散学習するためのフレームワーク。
- User Behavior Pre-training for Online Fraud Detection
- Lion: A GPU-Accelerated Online Serving System for Web-Scale Recommendation at Baidu
- Semantic Retrieval at Walmart
- Looper: An End-to-End ML Platform for Product Decisions
  - [Looper: An End\-to\-End ML Platform for Product Decisions \- Igor Markov \| Stanford MLSys \#60 \- YouTube](https://www.youtube.com/watch?v=UAZHJK9VWPY) Stanford の講義で動画が公開されていた、Meta(Facebook)の
- Amazon SageMaker Model Monitor: A System for Real-Time Insights into Deployed Machine Learning Models
- Human-in-the-Loop Large-Scale Predictive Maintenance of Workstations
- PinnerFormer: Sequence Modeling for User Representation at Pinterest
- Improving Relevance Modeling via Heterogeneous Behavior Graph Learning in Bing Ads
- Profiling Deep Learning Workloads at Scale using Amazon SageMaker
- Recommendation in Offline Stores: A Gamification Approach for Learning the Spatiotemporal Representation of Indoor Shopping
- Type Linking for Query Understanding and Semantic Search
  - Huawei が書いている。
- Interpretable Personalized Experimentation
  - Meta が書いている。
- Training Large-Scale News Recommenders with Pretrained Language Models in the Loop
- Scale Calibration of Deep Ranking Models
  - Google が書いている
- Multilingual Taxonomic Web Page Classification for Contextual Targeting at Yahoo
