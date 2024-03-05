---
title: "Community Over Code North America 2023 にて Lucene 関係で気になった発表まとめ"
date: 2024-03-05T23:23:56+09:00
lang: ja
author: Shunya Ueta
tags:
  - lucene
  - search
---

特に Uber 検索基盤の話と、Amazon の benchmarking, 正規表現検索が楽しそう

## Lessons Learned from Benchmarking Amazon’s E-commerce Search Engine

> The search engine on Amazon’s retail website runs on Lucene. It makes billions of products available to customers in less than 1 second per query. At this scale, every wasted millisecond comes at a large cost, so performance tests have to be thorough. Last year, we took inventory of our benchmarks, quantified the noise and bias we were seeing, introduced measurements for the statistical significance of results, and addressed sources of inconsistency (e.g.: caching, index geometry). We aren’t done, but this is a step in the right direction – benchmarks that are accurate, precise, and quick enough to remain useful. This talk will tell that story and help you move in the same direction. ([Slides](https://communityovercode.org/wp-content/uploads/2023/10/sun_performance_vodita-stefan-vodita.pptx))

Amazon の検索エンジンのベンチマーキングについての発表

## Search at Uber over Apache Lucene

> In this talk, we’ll give an overview of the Search platform at Uber, and share how we built a scalable and high-performance platform over Apache Lucene. We’ll highlight several business-critical use cases at Uber powered-by the search platform such as UberEats Discovery and Maps search. We will discuss the unique challenges from these use cases such as strong data freshness and geospatial search requirements. Next, we’ll present the overall architecture of the search platform, built on top of Apache Lucene, and explain how it addresses the challenges via a Base/Snapshot/Live (BSL) fashion of index structure. Lastly, we’ll share several ongoing interesting efforts that leverage new features from Lucene such as HNSW for vector search. ([Slides](https://communityovercode.org/wp-content/uploads/2023/10/sat_search_search-at-uber-over-apache-lucene-yupeng-fu.pdf))

Uber で Apache Lucene を使ってどのように検索基盤を作成しているか

## Introducing Multi-valued Vector Fields in Apache Lucene

> Since the introduction of native vector-based search in Apache Lucene happened, many features have been developed, but the support for multiple vectors in a dedicated KNN vector field remained to explore. Having the possibility of indexing (and searching) multiple values per field unlocks the possibility of working with long textual documents, splitting them into paragraphs, and encoding each paragraph as a separate vector: a scenario that is often encountered by many businesses. This talk explores the challenges, the technical design and the implementation activities that happened during the work for this contribution to the Apache Lucene project. The audience is expected to get an understanding of how multi-valued fields can work in a vector-based search use case and how this feature has been implemented.

Lucene の複数の値を持つベクトルフィールドの紹介
複数に分割することで、長すぎるドキュメントに対しても分割してベクトルを作成することで扱うことが可能になった

## Fighting Adversarial Regular Expressions in Apache Lucene

> Regular expressions are a compact and powerful approach for matching strings and are well supported in Lucene using RegexpQuery. However, such queries can be surprisingly costly, leading to a possible denial of service (ReDoS) vulnerability in search services built on Lucene.  
> This talk will first briefly introduce how Lucene executes RegexpQuery using a pre-determinized finite state automaton or DFA matching approach. This yields fast query execution, but Lucene must guard against the determinization pre-step taking too much work and reject the query, preventing such costly regular expressions from being used in Lucene at all. Next I’ll describe a recent Lucene bug that led to an adversarial ReDoS query impacting an OpenSearch user [1] and how we fixed and optimized it. I’ll present the ongoing development efforts to execute the RegexQuery directly using a non-deterministic finite state automaton (NFA) instead, guided by the method described in Russ Cox’s paper [2]. Finally I’ll walk through the pros and cons of these two execution methods for Lucene’s RegexpQuery so that future Lucene users can understand and reduce the risk and impact of ReDoS attacks in their search applications.  
> [1] [https://github.com/opensearch-project/OpenSearch/issues/687](https://github.com/opensearch-project/OpenSearch/issues/687)  
> [2] [https://swtch.com/~rsc/regexp/regexp1.html](https://swtch.com/~rsc/regexp/regexp1.html) ([Slides](https://communityovercode.org/wp-content/uploads/2023/10/sat_search_patrickzhai-patrick-zhai.pdf))

Lucene での正規表現検索の改善と NFA を使った 正規表現クエリの実装のアイデアを紹介
