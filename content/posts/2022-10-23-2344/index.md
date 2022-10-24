---
title: "Elasticsearchの近似近傍探索を使って、ドラえもんのひみつ道具検索エンジンを作ってみた"
date: 2022-10-23T23:44:13+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2022-10-23-2344/images/01.gif"
  caption: "デモアプリの動画"
tags:
  - elasticsaerch
  - python
  - huggingface
  - machinelearning
  - search
---

Elasticsearch 8 系から使用可能になった近似近傍探索[^es-knn]を使って、ドラえもんのひみつ道具の自然言語検索ができる検索エンジンを作ってみた。

デモ動画のように、検索したいひみつ道具を説明する文章することで近しいひみつ道具が検索されます。

コードは GitHub に公開してあるので、興味のある方は手元で、動かして遊ぶことが出来ます。
`poetry` と `Docker` さえあれば動くようになっています。

[hurutoriya/doraemon\-himitsu\-dogu\-search: Doraemon Himitsu Dogu Japanese semantic search based on Elascticsearch ANN](https://github.com/hurutoriya/doraemon-himitsu-dogu-search)

システムの概要図はこんな感じ

![sysytem design](/posts/2022-10-23-2344/images/02.png)

## 所感

- ドラえもんのひみつ道具のデータセットを今回１から、作ったがパースがめんどくさくてここが一番手間がかかった。が、工夫しないと出来なかったので、一番楽しいところでもあった。
- 文章の特徴抽出は、[sonoisa/sentence\-bert\-base\-ja\-mean\-tokens\-v2 · Hugging Face](https://huggingface.co/sonoisa/sentence-bert-base-ja-mean-tokens-v2)を使わせていただき、驚くほど簡単に実現できた。
  - 実際はもっと精度を高めるには、fine tune などがいいのだろうが、システム側を作ることに注力したかったので今回は割愛
- デモアプリの構築は streamlit を使って 20m くらいで作れたので、相変わらず便利すぎて愛用している。今回の検索エンジンは CLI から実行もできるが、こうやってデモアプリがあったほうがそれっぽくて気持ちいい。
- インデキシング時にトーカナイザーのことなど全く考えずに特徴ベクトルだけインデキシングして、それで検索が成り立つというのは新鮮。閾値設定しなければゼロヒット問題にも直面しないので、できることの幅は広がりそう。
- Elasticsearch の近似近傍探索は、今回ベクトル同士の近似近傍探索しかやっていないが、それもインデキシング、クエリ部分は公式ドキュメントを見れば事足りたので変にハマることはなかった。

クエリ部分はこれだけで書けた。

```python
query = {
		"knn": {
				"field": "vector",
				"query_vector": sentence_embeddings[0],
				"k": 10,
				"num_candidates": 100,
		},
		"fields": ["name", "description"],
}
result = es.search(index=INDEX_NAME, body=query)
```

ぶっちゃけて言えば、この規模で近似近傍探索のみやるなら検索エンジンを使わずとも Python 内でインメモリ探索して完結して動くと思うので Elasticsearch を使う意義を考えざるをえないが、自分が触ってみたかったのでやってみた。
そのおかげで色々学べたことが多いので、手を動かしてよかった。

---

これで、近似近傍探索周りで遊べるパイプライン+アプリが出来たので暇が出来たら色々試してみたいなと思っている。
例えば、

- 近似近傍探索探索部分は、ベクターデータベースの [Milvus](https://milvus.io/)でも実現できる内容になっているが、Elasticsearch の真価であるフィルタリングや従来の検索手法と組み合わせる[^es-combine]ことが出来ていないのでやってみたい。
- 特徴抽出のパイプラインは出来たので、もっと大規模なドキュメントを取り扱って課題にぶち当たると楽しそう
- [Vespa](https://vespa.ai/) や[Qdrant](https://qdrant.tech/)、[Milvus](https://milvus.io/) など他のライブラリでも近似近傍探索を使った検索をやれる

[^es-combine]: Elastocsearch 8.4 からは従来の検索手法と近似近傍探索を組み合わせることが可能に! [Elasticsearch 8.4 introduces a hybrid search by Mayya Sharipova](https://www.linkedin.com/posts/mayya-sharipova-a40a0256_k-nearest-neighbor-knn-search-edit-activity-6970855618479865857-oLqB/?utm_source=pocket_mylist) > Elasticsearch 8.4 introduces a hybrid search: ability to combine results from knn search with traditional search features (queries, aggs etc) and all this under a single familiar \_search API.
[^es-knn]: [k\-nearest neighbor \(kNN\) search \| Elasticsearch Guide \[master\] \| Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/master/knn-search.html)
