---
title: "自然言語処理トップ国際会議の System Demonstrations について"
date: 2022-04-04T23:48:58+09:00
lang: ja
author: Shunya Ueta
tags:
  - nlp
---

仕事でご縁ができた方と、自然言語処理(NLP)領域での国際会議で Industry track に相当する文化って何かありますかねとお聞きした話が面白かったので文章にしておく。

この領域を知ったきっかけとしては、CyberAgent さんの記事[^ca]を読んだ際に知ったのだが、自然言語処理領域のトップカンファレンスの ACL[^acl], NAACL[^naacl], EMNLP[^emnlp]などでは Industry Track ではなく、 System Demonstration という部門が用意されているらしい。

例えば、Industry Track で有名所だと KDD の Applied Data Science Track[^kdd] や RecSys の Industry Talk[^rec] があります。
それらと比較して異なる点としては、

> What problem does the proposed system address?
>
> Why is the system important and what is its impact?
>
> What is the novelty in the approach/technology on which this system is based?
>
> Who is the target audience?
>
> How does the system work?
>
> How does it compare with existing systems?
>
> How is the system licensed?
>
> _Call for System Demonstrations_ > https://2021.emnlp.org/call-for-papers/demos

と上記の問いに答えられるような内容が System Demonstration に該当する。
すごくざっくりいうと、

- Industry Track(KDD, Recsys など): 現実世界での実応用をしてこういう学びがあった
- System Demonstration (ACL, NAACL, EMNLP など): NLP に関わる人に便利な道具を作った

と、発生した背景が違いそうですね。

Industry Track は、理論と実践の剥離を防ぐため。

System Demonstration は、NLP 周りのソフトウェアの OSS 公開の動機づけやコミュニティの成長にもつながるので良い仕組みだなと思いました。論文化できるのも、また嬉しいですね。

[^kdd]: [Call for Applied Data Science Track Papers KDD2022](https://kdd.org/kdd2022/cfpAppliedDS.html)
[^rec]: [Call for Industry Talk Proposals recsys 2022](https://recsys.acm.org/recsys21/call/#content-tab-1-7-tab)
[^ca]: [自然言語処理分野のトップカンファレンス「EMNLP 2021」の System Demonstration Track にて論文採択 ー モバイル端末用の効率的なアノテーションツールを提案 ー](https://www.cyberagent.co.jp/news/detail/id=26746)
[^acl]: ACL’21: https://aclanthology.org/volumes/2021.acl-demo/
[^naacl]: NAACL’21: https://aclanthology.org/volumes/2021.naacl-demos/
[^emnlp]: EMNLP’21: https://aclanthology.org/volumes/2021.emnlp-demo/
