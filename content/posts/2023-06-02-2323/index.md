---
title: "Elasticsearch 8.8 のリリース内容が盛りだくさんで興味深い"
date: 2023-06-02T23:23:58+09:00
lang: ja
author: Shunya Ueta
tags:
  - search
  - elasticsearch
  - machinelearning
---

表題のとおり、Elasticsearch 8.8 のリリース内容が興味深かったので記事にしておきます。

リリースノートはこちら

- [Elasticsearch 8\.8 introduces out\-of\-the\-box semantic search \| Elastic Blog](https://www.elastic.co/jp/blog/whats-new-elasticsearch-8-8-0)
- [What’s new in 8\.8 \| Elasticsearch Guide \[8\.8\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/8.8/release-highlights.html)

個人的に気になったのが、

- Elastic Learned Sparse EncodeR (ELSER) をリリース
  - ELSER は Elastic が独自に開発した、機械学習モデルで、従来はユーザーが検索のために適宜 fine tune したりモデルを自前で用意するなど、気軽にハイブリッド検索を試すことは難しいのが現状だった。
    - それを解決するために提供されるのが ELSER で、Elastic Cloud のプレミアムを契約していればボタンポチッで利用可能になるらしい。
      - NOTE: これは Elastic Cloud を使う理由になるので、良い機能開発ですね。素晴らしい。
  - 検索の関連性ベンチマークでも BM25 と比べるとスコアはほぼすべてのデータセットで優位な成果を出している。(この結果を出すの素晴らしいですね)
    [Improving information retrieval in the Elastic Stack: Introducing Elastic Learned Sparse Encoder, our new retrieval model \| Elastic Blog](https://www.elastic.co/jp/blog/may-2023-launch-information-retrieval-elasticsearch-ai-model)
  - 実際問題、自前でモデルを作成して、調整してというのはかなり手間がかかるので、Elastic Cloud さえ契約しておけば、ゼロコストでセマンティック検索を試せるというのはかなり魅力的に見えます。しかもモデルの利用に当たってライセンスの心配が不要。これ重要ですね。
  - 詳細はこちらの記事にかかれています。[Introducing Elastic Learned Sparse Encoder: Elastic’s AI model for semantic search \| Elastic Blog](https://www.elastic.co/jp/blog/may-2023-launch-sparse-encoder-ai-model)
- Elasticsearch のベクトル検索の最大次元数が 2048 次元に!
  - [Increase max number of vector dims to 2048 by mayya\-sharipova · Pull Request \#95257 · elastic/elasticsearch](https://github.com/elastic/elasticsearch/pull/95257)
  - OpenAI API で提供されるベクトルの次元数は 1024 次元以上で、Lucene 側の制約によって扱うことができなかった[^luceneann]が、多くの要望によって 2048 次元まで拡張されたとのこと。これは良い意味で Elasticsearch っぽくないというか、かなり意外な動きで驚きました。競合の OpenSearch はすでに OpenAI API を扱えるので、その点をなんとかしたいという意欲が感じ取れて非常に好感触です。
- Reciprocal Rank Fusion (RRF) [^RRF]という複数のランキングを統合する手法がビルトインで利用可能に

  - 利用用途としては、BM25 のランキングとベクトル検索でのランキングを統合したいときが挙げられる。過去の自分のブログ記事でもハイブリッド検索(BM25 とベクトル検索の融合)[^hybrid]を試したが、各ランキングスコアの統合はどうすればいいか正直分からなかったので、こんな手法があるなんて知らなかったので非常に面白い
  - `NOTE` 2023/06/03 追記。@takuya-a さんが教えてくれたがこの RRF も Elastic Cloud のプラチナプラン契約者のみ使える機能らしいです。(元は @johtani さんが、PR の内容を確認して、それを @takuya-a さんに教えてくれたとのこと)
    確かに共有してもらった、PR の行を見てみると、`License.OperationMode.PLATINUM`が引数に使われていました。(OSS とは...??)
    https://github.com/elastic/elasticsearch/pull/93396/files#diff-f114b9c6a904654185114e728e20cc230425a57054f160bfbfcb63f8dc27b67fR26

    ```java
    public static final LicensedFeature.Momentary RANK_RRF_FEATURE = LicensedFeature.momentary(
        null,
        "rank-rrf",
        License.OperationMode.PLATINUM
    );
    ```

    Elastic Cloud の新機能なのか、OSS の Elasticsearch の新機能なのか不明瞭なのは混乱するので、リリースノートにも明確に記述してほしいところですね。実際今回 @takuya-a さんに教えてもらえるまで完全に誤解していました。
    ライセンス縛りするなら、Elasticsearch Stateless みたいに OSS にしないほうがいいじゃないのかなと思いました。でも Open にはしてくれることで、例えば OpenSearch にすぐに移植できる利点とかはありそうです。

[^luceneann]: 前にこの議論について解説記事を書きました。 今でも Lucene のメーリングリストで激論が繰り広げられています。 [現在 Lucene の KNN ベクトルの最大次元数は 1024 次元 だが、それを 2048 次元に変更できないかという議論](/posts/2023-03-26-2208)
[^RRF]: https://plg.uwaterloo.ca/~gvcormac/cormacksigir09-rrf.pdf
[^hybrid]: [Elasticsearch 8.4 から利用可能な従来の検索機能と近似近傍探索を組み合わせたハイブリッド検索を試す](/posts/2022-10-29-2337)
