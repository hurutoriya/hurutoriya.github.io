---
title: "自分なりの機械学習エンジニアスキル構成論"
date: 2020-09-21T00:13:08+09:00
lang: ja
tags:
- machinelearning
- essay
---

機械学習エンジニアとして働き始めて2年7ヶ月が経過した。

機械学習エンジニアというロールは会社によって期待される内容が異なってくるが、今の会社で働いてきた経験に基づき自分の中の機械学習エンジニアスキル構成論を整理してみる。

## TL; DR

- 人によって考える理想のスキル論は違うので他の人の持論を聞いてみたい
- テクいことをやりたい気持ちはあるが、地道なやるべきことがたくさんあるのがこの世界

## 自分の中で機械学習エンジニアにとって大事なスキル

- Software Engineer 40%
  - 機械学習サービス実装スキル
- Product Manager 30%
  - 機械学習プロジェクト自体を成功に導くスキル
- Data Scientist 30%
  - データに基づき、意思決定し改善していくスキル

## Machine Learning Engineer as Software Engineer

なぜSWEの比率が一番上なのか？

どれだけ良いモデルができたとしてもそれが活用されるシステムがなければ成果を出せないからです

- データを活用してインパクトの大きい課題を解決するための、サービスを実装して、運用して改善していく
- どの方法がベストか考えた上で、それを実現していく

例えば、R&Dスタイルでモデル開発と実装者を完全に分ける組織構造もあると思いますが、このスタイルはいろんな会社のお話を聞く限りは、組織構造がよほど洗練されていないとうまく稼働しないじゃないかなと思っている

[Full Cycle Developers at Netflix](https://netflixtechblog.com/full-cycle-developers-at-netflix-a08c31f83249)では、システム開発のライフサイクルである

__design, development, test, deploy, operate, support__

を1チームが一気通貫で責任を持つスタイルをNetflixが提唱している。

今所属している会社もMicro Serviceでの開発に注力していて、まさにFull Cycleスタイルで機械学習サービス開発を行っている。
個人的に機械学習プロジェクトとこの方式の相性の良いところは、例えば、職能ごとにモデル開発、システム開発と運用を行うメンバーを分割すると、

- モデルを作ってデプロイはしたが運用は他人任せになってしまい継続的な改善が回しづらい
- 役割が分離されていることで、モデルの詳細を完全に把握できないので実際のトラブル発生時に対応が困難
- 運用を考えてモデルがデザインされていないので運用者にしわ寄せがくる

などアンチパターンが数多く存在する

Micro Serviceでの開発は上記の課題を解決して、作って終わりではなく自分たちでシステムデザインからサポートまで行うことで、そのサービスの継続的な改善に責任と自由を手にして開発することできる
また、プロジェクトデザインの段階からシステム開発・運用を念頭に動くことができるので、やってみてうまく動かないなどの不確実性を大きく減少させる

## Machine Learning Engineer as Product Manager

機械学習プロジェクトは、POCなどで検証を行いプロジェクトが始まりますが最初の壁である

- 機械学習で解ける余地のある大きなインパクト(やる価値)のある問題

をまず自分たちのサービスで発見する必要があります。(正直コレが一番難しい)

[CourseraでHow Google does Machine Learning の講義を修了した](https://shunyaueta.com/posts/2020-04-18/)の講義でもGoogleでの機械学習プロジェクトのマネジメントについて言及されていますが、

- そもそもデータがない
- Human In The Loopを導入していない(継続的なデータの自浄作用が存在しない) 

などそれらの要素が欠けるだけで簡単にプロジェクトは失敗します。

上記の講義でまず取り掛かるべき機械学習プロジェクトというのは、

> 現実世界で適用可能な機械学習というのは、自動化の技術です。
> 今まで人間が手作業で行っていた作業がログとして残っていて、そのデータを活用してそれらの作業を徐々に自動化していきます。

結論からして金言ですね、銀の弾丸など存在しない、機械学習エンジニアとして、テクいことはやりたいがその前にやるべき地道なことが無限にあるんです(切実)

また、システム開発要素以外にもデータ収集・活用の要素が入ってくるのでステークホルダーとの協力が必要不可欠です。
MVPとして小さな成功を高速に積み重ねていくことで、組織内での機械学習への理解・信頼が高まっていきます。

個人的に機械学習プロジェクトと非常に相性が良いなと思っているのが、[リーン・スタートアップ](https://amzn.to/3mysnVD)の考え方です。

その結果データ分析で判明した考察から、

- 既存のUIのこの部分を改善したい
- 今は取れていないデータを構造化した状態で保存するようにしたい

など優先度が上がりづらい提案も受け入れやすくなる土壌になっていきます。

日に日に、データの整備やワークフローの改善なども重要ポイントなので、コンサルティングとしての能力は凄い重要だと感じる

### ネット上で閲覧できる有用な機械学習プロジェクトマネジメントの日本語資料

- nishio さんの[機械学習キャンバス0.1](https://www.slideshare.net/nishio/01-68382174)
- [@yurfuwa](https://twitter.com/yurfuwa) さんの[AI Project Management Anti Pattern](https://speakerdeck.com/yurfuwa/ai-project-management-anti-pattern)
- [ブレインパッドにおける機械学習プロジェクトの進め方](https://www.slideshare.net/BrainPad/ss-149214163)

## Machine Learning Engineer as Data Scientist

施策の効果検証、機械学習の知識、実験デザイン、データ分析などを活用して、プロジェクトの方向性、同改善していくべきかそれらをどう検証していくかがこの部分です。

***

ちょっと疲れてきたのでこのへんで。

機械学習エンジニアになった直後には、こんな抄訳記事も

[[抄訳] Data engineers vs. data scientists](https://shunyaueta.com/posts/2018-04-24/)

もあって当時は感銘を受けたが、今になって振り返るとかなり視座が変わったと思う

経験を積む中で自分の中の軸が出来上がってきた証拠だと信じたい

え、仕事で機械学習をやっているのに[仕事ではじめる機械学習](https://amzn.to/3hIjyF2)を読んだことがない？
神書籍なので、今すぐ買いましょう!
