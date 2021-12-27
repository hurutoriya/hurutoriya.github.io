---
title: "eコマースの検索と推薦についてのサーベイ論文である 'Challenges and research opportunities in eCommerce search and recommendations' を社内勉強会で発表した"
date: 2021-07-10T23:20:58+09:00
lang: ja
author: Shunya Ueta
tags:
  - search
  - translation
---

SIGIR eCom を探索していたら発見したサーベイ論文の "Challenges and research opportunities in eCommerce search and recommendations"が面白かったので、社内の勉強会で発表してきた。

和訳すると、「e コマースの検索と推薦における挑戦と研究トピック」で、e コマースにおける検索と推薦の課題が明瞭に書かれていて非常に面白い論文でした。
自分もまだ検索エンジニアとして日が浅いので、手持ちのパターンを増やせるように日々勉強していますが、この論文のおかげでかなり解像度が上がった。

<iframe src="//www.slideshare.net/slideshow/embed_code/key/sOhCWPToy6AIL1" width="595" height="485" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/shunyaueta/introducing-challenges-and-research-opportunities-in-ecommerce-search-and-recommendations" title="Introducing &quot;Challenges and research opportunities in eCommerce search and recommendations&quot;" target="_blank">Introducing &quot;Challenges and research opportunities in eCommerce search and recommendations&quot;</a> </strong> from <strong><a href="https://www.slideshare.net/shunyaueta" target="_blank">Shunya Ueta</a></strong> </div>

個人的に面白かったのは、

- そもそも、顧客が商品を検索するというタスクの奥深さと面白さが知れる
- Query Understanding は、非構造なクエリを構造化されたクエリに変換するのが究極的な目標
- Learn to Rank(LtR)の実践的な課題点として、LtR 適用時に、Native Ranker とのギャップが発生して非連続な検索結果を返してしまうことがある
- 実際のクエリから、購入される商品はクエリと商品が関連性が高いとは限らないのでモデルを学習させる際には要注意
  - Amazon での実例として
    - クエリ「ダイヤモンドリング」に対して LtR を適用すると、実際のクエリとそれに紐づくランキングシグナルから学習すると、「ダイヤモンドリング」というクエリで、「ジルコニウムリング」が大量に購買されていたので LtR では、「ダイヤモンドリング」というクエリに対して、「ジルコニウムリング」を表示するようになってしまった
  - これは、学習データを全く見ないで適用するとそうなりそうだけど、広範囲に影響を及ぼす LtR の QA は非常に骨が折れそう
  - Ref: [Amazon Search: The Joy of Ranking Products](https://www.amazon.science/publications/amazon-search-the-joy-of-ranking-products)

スライド作成元の Markdown ファイルは[hurutoriya/deck](https://github.com/hurutoriya/deck/blob/main/2021-07-07_challenges-and-research-opportunities-in-eCommerce%20search-and-recommendations/deck.md)はこちらです。
スライド内のリンクに簡単にアクセスできます。

e コマースでの検索に改善したいけど何したらいいかわからんという人は、とりあえずこれ見れば OK という論文だったので読めてよかった

## 余談

Matching & Ranking の章までを解説したけど、それでも 45m 喋りっぱなしで最後のほうがかなり駆け足になってしまった。
また、英語での発表になったけど、やはり熟れたわかりやすい発表レベルに達するには、まだまだだなぁ感じた。精進せねば

今回スライド作成に [Marp](https://marp.app/) を使いましたが、VS Code 上でスラスラとかけつつ読みやすくテンションの上がるデザインに簡単にできて感動しました。これからも愛用したいなと思います。

年末くらいに、検索エンジニアとして 9 ヶ月経過するので、役になった学習リソースなどをまとめたい
