---
title: "Twitter の検索システム、Earilybirdの論文を読む"
date: 2023-04-29T00:30:07+09:00
lang: ja
author: Shunya Ueta
tags:
  - search
  - paper
---

前回の記事の続き[^twitter-series-1st]で、Twitter の検索システムシリーズ第 2 弾です。

## Earlybird とは?

Twitter の検索システムであり、 Apache Lucene をベースにした、リアルタイム検索システム。論文は[ここ](https://notes.stephenholiday.com/Earlybird.pdf) で、Blog 記事は [The Engineering Behind Twitter’s New Search Experience](https://blog.twitter.com/engineering/en_us/a/2011/the-engineering-behind-twitter-s-new-search-experience)は 2011 年に公開されている。

- Web 検索はある程度成熟してきた分野だが、SNS のリアルタイム検索はまだ 2011 年当時いまだ未成熟で未開拓な分野
  - Twitter で新たに開発したのが、 Earlybird と呼ばれるリアルタイム検索に特化した検索エンジン
    - Lucene の NRT 機能が導入され始めたのが、2011 年の終わり頃なので、このときには恐らく GA ではないから、恐らく独自に作成した? [Changing Bits: Near\-real\-time readers with Lucene's SearcherManager and NRTManager](https://blog.mikemccandless.com/2011/11/near-real-time-readers-with-lucenes.html)
    - この論文の貢献点
      - Web 検索とのインデックス構造の違い
      - ロックフリーの single-writer, multi reader の 並行性モデル
    - 1 億人の Active User, 毎日 2.5 億件のツイート
    - query latency 50ms, 10s 以内に検索可能になる
  - リアルタイム検索の考慮すべき事項
    - 低いレイテンシー、高速なクエリ評価
    - データ挿入の即時性(web 検索はそこまでの即時性は必要ない)
    - 並行した read, write
    - freshness signal(いつ作られたかというシグナルがとても重要)
      - 現在 web でも有用な signal になっているが、当時はそこまで重要ではなかった
  - 関連事項
    - 分散検索アーキテクチャ
      - 面白そうな論文がめっちゃあるけど、紹介しきれないので割愛。
    - クエリ評価
      - 2 stage
        - 1st: cheap BM25, PageRank, quality score など
        - 2nd: expensive 1st の結果を候補にして、(基本的には機械学習による)Re-Ranking
    - その他
      - 多種多様なドメインを扱うのは大変(画像、動画、ニュース、単なるツイートなど)
        - 例えば news はそのニュースの内容を知った上で ranking する必要があるし、ドメインごとに特性が異なる。それらを統合していくのも課題点
  - Earlybird 概要
    - ![](/posts/2023-04-29-0030/images/earlybird-fig-1.png)
    - 3 signals
      - 統計的シグナル: 何文字か、いつ投稿されたかなど、インデックスされた瞬間に把握している情報
      - 反響シグナル (Resonance signal): リツイート数
      - Searcher の情報
    - score_sort と created_sort が毎回計算されて Blender(BFF)に返す
      - この時、searcher のローカルソーシャルグラフに基づいて score を計算している。これがソーシャル検索のキモ
    - Java で作った理由
      - Lucene を使いたい
      - Twitter の Java 文化に合う
      - Java の並行処理は理解しやすい
      - 結果的に C/C++ に匹敵するパフォーマンスを出せている(と考えている)
    - ソーシャル検索の宿命として、常に検索されるし常に indexing され続けている
      - つまり圧倒的な並行処理を実現する必要がある
    - multiple index segment(12 個)
      - 各々のセグメントは、大体 840 万のツイートを格納
      - 一つのセグメントが write され、その他のセグメントは read only になるように設計されている(模様、コード読もう)
        - active index: writable
        - non-active index: read-only
    - 32bit integer のポスティングリストとして設計
      - 24bit: document id
      - 8bit: term position(140 文字なので 8bit で十分)
    - Earlybird は高速なインデキシング処理のために、インデックスを圧縮せずそのまま保存している。

## 感想

これでだいたい概要をつかめたので、次は GitHub で公開されているコード[^OSS-twitter-search]を読んでみます。

にしても、Twiter はマイクロブログという宿命か、ドキュメントの数、クエリ、増え方は EC と違って本当に桁違いです。
ここらへんのドメインが違えば、考えることが全く違ってくるのが検索システムの面白いところの一つですね~

独自で検索エンジン作らざるを得なかった状況に追い込まれて、見事に成し遂げているのはすごいですね。
メンテンスとか大変そうですが...

## 余談

ChatGPT が活用された論文読解支援サービスを試しに使ってみたら、ものすごく良かった。

[ChatPDF \- Chat with any PDF\!](https://www.chatpdf.com/) で、論文を見てみると、英語しか対応してなさそうだけど、日本語でプロンプトを打つと日本語で返された。おま国ではないのが ChatGPT の良いところだと思います。

![ChatPDF](/posts/2023-04-29-0030/images/chatpdf.png)

https://www.chatpdf.com/c/lAAdzSaHgv8EbomIStV51 ファイルごとに誰からも閲覧可能な URL が生成されるみたいです。ここから見れます。

ChatPDF での質問

> 最も画期的な点はなんですか?
>
> この PDF ファイルで最も画期的な点は、Twitter のリアルタイム検索サービスを支える強力な検索エンジンである Earlybird の設計に関する詳細な説明が含まれていることです。Earlybird は、高速なコンテンツ取り込みと低レイテンシーのクエリ評価を両立するために、最適化された読み取り専用インデックス形式とアクティブな「書き込みフレンドリー」ブロック割り当てインデックスの 2 種類のインデックスを使用しています。また、単一ライター、複数リーダーモデルを採用しており、メモリバリアを使用して一貫性を強制します。これらの設計により、Earlybird は Twitter のリアルタイム検索サービスで要求される要件を満たすことができます。詳細については、ページ 1 のセクション I（イントロダクション）およびページ 9 のセクション IX（結論）をご覧ください。

だけど、その後に [SCISPACE](https://typeset.io/) というサービスを教えてもらい、触ってみたところ ChatPDF の完全なる上位互換だった。
返答を完全に日本語に固定できたり、予め論文に対して行う定型的な質問がプロンプトとして用意されている。
また、左ペインにアップロードした PDF が表示されて、ドラッグアンドドロップで選択した範囲の文章に対して要約させたり、説明させたりできるのはすごい便利です。

![scispace](/posts/2023-04-29-0030/images/scispace.png)

- [The Engineering Behind Twitter’s New Search Experience](https://blog.twitter.com/engineering/en_us/a/2011/the-engineering-behind-twitter-s-new-search-experience) 2011-05-31 公開

[^twitter-series-1st]: [Twitter の検索システムを学ぶ - 概要編](/posts/2023-04-17-2252)
[^OSS-twitter-search]: https://github.com/twitter/the-algorithm/tree/main/src/java/com/twitter/search
