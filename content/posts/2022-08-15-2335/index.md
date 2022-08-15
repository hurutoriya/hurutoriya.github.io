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
  - 検索のための深層学習によるレリバンスモデルの関するハンズオンチュートリアル。Jupyter notebook を通して手を動かしながら学習できる。

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
  - 現実世界のデータって全部紙なので、それを構造化してデジタル化するってものすごく大変だけどやりきった先に競合優位性が発生するのととんでもない価値を生むと思うのでこの領域は気になっている。
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

## Posters

論文関係は数が多いので、見出しだけで面白そうだなと思った論文をリスト化した。
時間がある時にこのリストから選んでみたい。

### Applied Data Science Track Posters

https://kdd.org/kdd2022/adsPosterAssignments.html

- DuARE: Automatic Road Extraction with Aerial Images and Trajectory Data at Baidu Maps
- AutoShard: Automated Embedding Table Sharding for Recommender Systems
- Affective Signals in a Social Media Recommender System
- Looper: an end-to-end ML platform for product decisions
- A Meta Reinforcement Learning Approach for Predictive Autoscaling In the Cloud
- Rax: Composable Learning-to-Rank using JAX
- Persia: An Open, Hybrid System Scaling Deep Learning-based Recommenders up to 100 Trillion Parameters
- Persia: An Open, Hybrid System Scaling Deep Learning-based Recommenders up to 100 Trillion Parameters
- Sparx: Distributed Outlier Detection at Scale
- No One Left Behind: Inclusive Federated Learning over Heterogeneous Devices
- Profiling Deep Learning Workloads at Scale using Amazon SageMaker
- NENYA: Cascade Reinforcement Learning for Cost-Aware Failure Mitigation at Microsoft 365
- Improving Relevance Modeling via Heterogeneous Behavior Graph Learning in Bing Ads
- Multi-Aspect Dense Retrieval
- Amazon SageMaker Model Monitor: A System for Real-Time Insights into Deployed Machine Learning Models
- CommerceMM: Large-Scale Commerce MultiModal Representation Learning with Omni Retrieval
- Automatic Generation of Product-Image Sequence in E-commerce
- Semantic Retrieval at Walmart
- ItemSage: Learning Product Embeddings for Shopping Recommendations at Pinterest
- Alexa Teacher Model: Pretraining and Distilling Multi-Billion-Parameter Encoders for Natural Language Understanding Systems
- Device-Cloud Collaborative Recommendation via Meta Controller
- Human-in-the-Loop Large-Scale Predictive Maintenance of Workstations
- Recommendation in offline stores: A gamification approach for learning the spatiotemporal representation of indoor shopping

### Research Posters

https://kdd.org/kdd2022/researchPosterAssignments.html

- Evaluating Knowledge Graph Accuracy Powered by Optimized Human-machine Collaboration
- HyperLogLogLog: Cardinality Estimation With One Log More
- Learning Backward Compatible Embeddings - 気になっていた、埋め込み空間に後方互換性をもたせる論文は上記リンクのリストにはなかったが、[予稿集](https://kdd.org/kdd2022/toc.html)
  ページには掲載されていた。うーむ、ページ構造がわからない。
