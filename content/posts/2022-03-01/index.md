---
title: "Web 検索とデータマイニングのトップカンファレンス WSDM2022 で気になった研究"
date: 2022-03-01T20:47:53+09:00
lang: ja
author: Shunya Ueta
tags:
  - search
  - conference
  - paper
---

WSDM は web 検索とデータマイニングのトップカンファレンスの一つです。検索好きなら見てて楽しい論文がたくさん公開されており、毎年採択された研究を楽しみに見ています。

今回 [WSDM2022](https://www.wsdm-conference.org/2022/) が `2022/02/21` - `2022/02/25` に開催されたので気になった発表をメモ。

今までこういう気になったトピックなどは Joplin にメモして公開していなかったが、公開しても差し支えはないなと思ったので Blog 記事として公開していってみる。

自分の興味関心トピックは今は基本的に検索関連と機械学習の実践事例なので、それに沿った選出になっています。

## Industry Day

https://www.wsdm-conference.org/2022/industry-day-schedule/

- Challenges in Data Production for AI with Human-in-the-Loop, Dmitry Ustalov (Toloka)
- Scalable Attribute Extraction at Instacart, Shih-Ting Lin (Instacart)
- Graph Neural Networks for the Global Economy with Microsoft DeepGraph, Jaewon Yang, Alex Samylkin, Baoxu Shi (LinkedIn, Microsoft)
- Near real time AI personalization for notifications at LinkedIn, Ajith Muralidharan (LinkedIn)
- Invited Talk: Rethink e-Commerce Search

## Workshops

https://www.wsdm-conference.org/2022/wsdm-workshops/

- [Personalization and Recommendations in Search (PaRiS)](https://paris2022.github.io/www/index.html)
  - 資料公開されていない...? まだ、終わったばかりなので後から公開されるかもしれない。
- [Interactive and scalable information retrieval methods for e-commerce](https://isir-ecom.github.io/)
  - 検索のシステム面に特化したワークショップ。今公開された論文を読んでいるが、自分の好みのドンピシャでどれも最高に面白い。検索エンジニアならめっちゃテンションあがると思います。ROSE という Amazon 検索のキャッシュシステムの解説記事を書いているので書き終えたらまた公開します。

## Accepted Papers

https://www.wsdm-conference.org/2022/accepted-papers/

- Joint Learning of E-commerce Search and Recommendation with A Unified Graph Neural Network, Kai Zhao (Alibaba Group)\*; Yukun Zheng (Alibaba inc.); Tao Zhuang (Alibaba Group); Xiang Li (Alibaba Group); Xiaoyi Zeng (Alibaba Group)
- External Evaluation of Ranking Models under Extreme Position-Bias, Yaron Fairstein (Technion); Elad Haramaty (Amazon); Arnon Lazerson (Amazon)\*; Liane Lewin-Eytan (Amazon)
- On Sampling Collaborative Filtering Datasets, Noveen Sachdeva (UC San Diego)\*; Carole-Jean Wu (Facebook AI Research); Julian McAuley (UCSD)
- Efficient Reachability Query with Extreme Labeling Filter. Zhixiang Su (Nanyang Technological University)\*; Di Wang (Nanyang Technological University); Xiaofeng Zhang (Harbin Institute of Technology (Shenzhen)); Lizhen Cui (ShanDong University); Chunyan Miao (NTU)
- Wikipedia Reader Navigation: When Synthetic Data is Enough, Akhil Arora (EPFL)\*; Martin Gerlach (Wikimedia Foundation); Tiziano Piccardi (EPFL); Alberto Garcia-Duran (EPFL); Robert West (EPFL)
- Differential Query Semantic Analysis: Discovery of Explicit Interpretable Knowledge from E-Com Search Logs, Sahiti Labhishetty (University of Illinois Urbana-Champaign); ChengXiang Zhai (University of Illinois at Urbana-Champaign)\*; Min Xie (Instacart); Lin Gong (WalmartLabs); Rahul Sharnagat (WalmartLabs); Satya Chembolu (WalmartLabs)
- ANTHEM: Attentive Hyperbolic Entity Model for Product Search, Nurendra Choudhary (Virginia Tech)\*; Nikhil Rao (Amazon); Sumeet Katariya (Amazon); Karthik Subbian (Amazon); Chandan K Reddy (Virginia Tech)
