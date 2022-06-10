---
title: "Amazon検索ランキングに取り組む楽しさ at MLconf SF 2016"
date: 2021-12-26T22:52:06+09:00
lang: ja
author: Shunya Ueta
cover:
  image: "/posts/2021-12-26/images/1.png"
  caption: "Amazon の検索改善事例"
ShowToc: true
tags:
  - search
  - machinelearning
  - amazon
  - translation
---

1 日遅れてしまいましたが、[情報検索・検索技術 Advent Calendar 2021](https://adventar.org/calendars/6430) 25 日目の記事です。

ついにアドベントカレンダー最終日を迎えました!
今年はまだ検索領域のアドベントカレンダーが作られていないからということで、勢いで`情報検索・検索技術 Advent Calendar 2021`を作りましたが、多くの方に投稿に協力していただきありがとうございました。

社内勉強会の発表でネタを探しており、2016 年と少し昔の情報ですが、Amazon の製品検索において、どのようにランキングを行っているかの公演動画が非常に面白かったので、勉強がてら残したメモを記事として公開します。

今回の口頭発表は [MLconf](https://mlconf.com/) という開発者会議(非学会・非アカデミック)で発表されています。
自分が知る限り、MLconf は機械学習黎明期から高品質な発表が継続されて発信されており、非常に素晴らしいカンファレンスの一つ。
国際会議には投稿されていないが、実応用の観点からしてとても学びの多い発表がとても多いです。
機械学習の応用を考えている場合、世界の最先端事例を知ることができるので非常におすすめです。

---

## Referemces

> Sorokina, D., & Cantu-Paz, E. (2016, July). Amazon search: The joy of ranking products. In Proceedings of the 39th International ACM SIGIR conference on Research and Development in Information Retrieval (pp. 459-460).

- [Amazon Search: The joy of ranking products in amazon science](https://www.amazon.science/publications/amazon-search-the-joy-of-ranking-products)
- [Youtube](https://youtu.be/NLrhmn-EZ88)

## メモ

自分の私的な意見は `NOTE:` で書いておきます。

### Search Ranking Models

- 1Model = 1 context: 一つのモデルで一つの国の 1 カテゴリをサポート
  - 日本の書籍カテゴリで 1 モデル、フランスの家電領域で更に一つのモデル
  - モデルの軽量化と精度向上のためにコンテキストごとの最適化されたモデル作成を許している
- 現在、100 以上の機械学習モデルを利用している
  - GBDT ベースのモデルや、pairwise ランキングモデルなど
  - モデルはだいたい 200 以上の tree で構成されている
- 150 種類以上の特徴量が利用可能だが、それぞれのモデルが利用しているのは 30 以下
  - 映画では、`days_since_release` がとても重要だが、他のカテゴリではそうではない

### Training Labels

- 学習データを顧客の行動ログから作成する
- 利用可能なポジティブラベルとして
  - クリックされたか?
  - カートに入れられたか?
  - 購入されたか?
  - 消費されたか?
- ネガティブなラベルとしては
  - 無視された結果
    - 検索結果には表示されたが、何も行動が起こされていない製品
  - 検索結果から、そもそも表示されなかったページからランダムサンプリング
    - ページネーションにより表示されなかったページからサンプリングを行う(slide が消えていて見えなかったので論文から補足)。
      - `NOTE:` アルゴリズムバイアスを加速させるような気もした。表示されなかったが良い商品をどうやって救い出すかも大事な観点。

### Mixing Click and Purchase Targets

![](/posts/2021-12-26/images/1.png)

- 何を目的変数とすべきか? クリックなのか、それとも購入か?
  - おそらく購入されたかどうかでしょう、なぜなら我々の最終目標は製品を売ることなので
  - しかし、いつでも購入がゴールというわけではない... 例をお見せします
- Keyword: iPhone
  - 最もクリックされたもの
    - iPhone7。700 ドル以上もするのでクリックはされますが購入されません
  - 最も購入されたもの
    - 一番購入されたものは何でしょうか? 最安価な iPhone モデルでしょうか?
    - 正解は... 8 ドルの Lightning to USB Cable です...!
  - もし購入されたことのみを目的変数にしてしまった場合、iPhone と検索して Lightning Cable しか表示されなくなり、検索機能が壊れてしまいます。

![](/posts/2021-12-26/images/2.png)

- これがクリックと購入を混在させたモデルの検索結果になります
  - iPhone 5S は iPhone モデルシリーズで最も安く最も購入され、その後に 最もクリックされる iPhone7 その後に Lightning Cable が表示されています
  - これによって、異なる顧客の意図を汲み取った検索結果を提供できるようになりました

## Fast Feature Evaluation

- 2 段階の特徴量選択
  - 1.  `150→50`: ランダムな特徴集合よりも良い結果を出した特徴を選択
  - 2.  `50→20`: 後方除去、前方選択により枝刈り
- ツリーのアンサンブルにおける特徴量のスコアリング
  - 全てのツリーは特徴量のスコアリングアルゴリズムを持っている
  - 課題点として 2 値と連続値の特徴量は比較ができない
- `is_prime_benefit` は Amazon Video で最も重要な特徴量である
  - しかし、特徴量選択では、いつもランダムな連続値の特徴量にスコアは低くなっている。何故?
- アンサンブルツリーはランダムな分割を多く実行する
  - 単一のツリーの分散は最終段階では平均化される
- 連続値の特徴量は更に可能な分割を提供する
  - よって、ランダムな分割で多く選ばれる
  - それによりスコアリングが高くなる
- それらを避けるには正規化の処理が重要になる
- 異なる一様分布の値から 6 つのランダムな特徴量を作成・追加を行い、ビデオ領域で実験を行った
  - 本来なら全ては意味のない特徴量なので、全ては同一の低いスコアリングがされるべきである

![](/posts/2021-12-26/images/3.png)

- しかし実験の結果、乱数の値に伴って対数的にスコアリングが変化していることがわかった
- 正規化された特徴量スコアでのバギングツリーを我々は利用している
  - 上記の手法は OSS として公開しています
    - https://github.com/dariasor/TreeExtra
- 上記の手法を適用後、スコアリングが最も高くなったのは `is_prime_benefit` 特徴量になりました
- All Product Search
- `green` と検索を行うと以下の結果が出てくる

![](/posts/2021-12-26/images/4.png)

## Components of the Blending Score

- Fashion, Home&Kichen, Health カテゴリの商品が出てきます。どのように各カテゴリのスコアを計算しているのか?
- Query Category score
  - 一般的なクエリ: クリック数、カートに追加したか、購入したか?
  - 稀なクエリ: クエリの trigrams , bigrams, unigrams でのクリック数
- Hunger score: 飢えのスコア(動的なスコア)
  - 重要なカテゴリはこの Hunger Score が高くなりやすく設定
  - 他のカテゴリが選択されるたび Hunger Score が高くなり、それがカテゴリ選出のスコアリングでは重要になる
- In-category relevance score for each product
  - relevency が高い製品は選ばれやすくなる
  - このスコアは異なるカテゴリ間でも比較可能なものにしなければならない
- All Product Search - Blending
- `green` というキーワードに対しての Blending Score の具体例
- ![](/posts/2021-12-26/images/5.png)
  - Fashion, Kitchen, Books カテゴリの中からどのように各カテゴリの商品が選出されるか?
  - 各カテゴリの Query Score は、Fashion, Kitchen, Books の順番に高い
  - 初期の全ての Hunger score は 0。白 → 灰色 → 黒と Hunger score が高くなる
- ![](/posts/2021-12-26/images/6.png)
  - まずはじめに、各カテゴリの Top1 製品の F1, K1, B1 を比較して、F1 が QueryScore に基づき最もスコアが高い F1 が選出される。
- ![](/posts/2021-12-26/images/7.png)
  - Fashion が選択されたので、Kitchen と Books の Hunger Score が高くなり、Hunger Score がより高い K1 が選出
- ![](/posts/2021-12-26/images/8.png)
  - Fashion カテゴリは重要なので Hunger Score がより早く高くなりやすい。Query Score と合わせて、三番目には F2 が選出
- ![](/posts/2021-12-26/images/9.png)
  - Books カテゴリの Hunger Score がとても高くなっているので、ついに B1 が 4 番目には選出される
- ![](/posts/2021-12-26/images/10.png)
  - 上記の考えで各カテゴリ間でスコアを比較して検索結果に混ぜていく

## Match Set

- Match set は、クエリに対して返された結果の集合
- Match set は 2 つのパターンの製品を含む
  - 例: `zootopia` というクエリで、70538 個の mache set が返ってきた
  - 1.  Textual matches
    - クエリに対して、Query understanding 後に Product description とマッチした製品
    - ![](/posts/2021-12-26/images/11.png)
  - 2.  Behavioral matches
    - そのクエリで検索後に、クリック、カートに追加、購入した商品の集合
    - 今回の場合は、`zootopia` で検索後にクリック、カートに追加、購入した製品を指す。
    - ![](/posts/2021-12-26/images/12.png)
    - どのように非 text-match が発生するか
      - 1.  `zootopia` で検索
        - ![](/posts/2021-12-26/images/13.png)
      - 2.  その後クリックはせずに、`inside out`で検索を行い製品をクリック
        - ![](/posts/2021-12-26/images/14.png)
      - 3.  この 1-2 を同一セッションとして Behaivioral feature として扱う
        - ![](/posts/2021-12-26/images/15.png)
      - 4.  3 の特徴量を取り入れることで、非 text-match の製品を match set に取り込む
        - ![](/posts/2021-12-26/images/16.png)

## Cold Start

- 新しい Harry Porrer の書籍が利用可能になります!
  - 私達はこの書籍がベストセラーになることを知っていますが...
- Behaivioral feature がまだ存在しない
  - どれくらいクリックされるかは我々は知らない
- 古い書籍は多くの signal を持っているので、新しい書籍は下のランクに位置づけられる
  - ![](/posts/2021-12-26/images/17.png)
  - 求めている書籍が検索結果の下にあるのは顧客は不幸です。
  - Business チームもこの異常事態を伝えてきます
  - ジョークですが、非公式の指標として、「今すぐこれを直してください」の要求の数が低ければ低いほどよいです
- Day 0: 全ての behaivioral features は 0
  - 時間特徴量がここでは助けになる(新製品にたいして Boost を行い、ランクを上にする)
  - ここで顧客が製品に対してクリックを行い、signal が溜まっていきます
- Day 1: Behaivioral features はまだ更新されていない
  - クリック情報を持っているが、検索エンジンにはまだ反映されていない
  - 強靭なインフラが、新製品に対して signal の蓄積を迅速に反映させていく
- Day 7: Behavioral features はゆっくりと蓄積されていくようになる。
  - signal が十分にたまり、新製品としての時間特徴量の boost はここでは取り扱われなくなる
  - ここから、適用されるスコアリングの公式が固定される
- 殆どの人が Cold start は Day 0 に対してのみ考慮するが、Day0-7 まで考える必要がある
- 時間経過にともなって、スコアリングをどう行っているか
  - 理解が浅いのでここは省略します。だれか解説してくれると嬉しい

## Non relevence Sort

- big keyward では match set がとても巨大になります
  - 例: `tv` というキーワードに対して家電カテゴリで 102,4635 の結果が存在する。
  - relevance sort は適切な検索結果が返ってくるが...
  - Customer review での平均でソートを行うと
    - relevance がぐちゃぐちゃになってしまう。もちろんカスタマーレビューはありがたい機能ですが...
      - ![](/posts/2021-12-26/images/18.png)
  - 改善方法
    - `tv` というキーワードに対して 500 の製品タイプが Amazon catalog で存在する
    - {query, product type} のペアでスコアを計算する
      - どの product type が特定のクエリにおいて最もクリック、カートに追加、購入されたか
    - 特定のキーワードでフィルターを行い、指定の product type の製品のみを表示するにした
      - keyboard→ キーボード製品
      - USB→ フラッシュメモリ、ネットワークデバイス、入力デバイス
      - TV→ テレビタイプ
    - これによって Customer review の平均でソートを行っても relevance が保たれるようになった
      - `tv`で customer review の平均で sort を行った際に 991 個の製品のみが表示され、relevance が向上した
      - ![](/posts/2021-12-26/images/19.png)

### 蛇足

この論文は、過去に読んだサーベイ論文で面白そうとメモしておいたのがきっかけで知ることができた。サーベイ論文の紹介記事はこちら

[e コマースの検索と推薦についてのサーベイ論文である 'Challenges and research opportunities in eCommerce search and recommendations' を社内勉強会で発表した](/posts/2021-07-10/)
