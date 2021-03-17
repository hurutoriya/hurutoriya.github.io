---
title: "サイトのPWA化、ホスティングをGithub PagesからFirebaseへ移行"
date: 2018-01-09T18:59:59.969Z
lastmod: 2019-06-16T18:17:31+09:00
lang: ja
tags:
  - Firebase
  - PWA
  - Github Pages
---

PWA と FireBase を試してみたかった

![image](/posts/2018-01-09/images/1.png)

firebase init で現れる画面、テンション上がる

Github Pages + CloudFlare で独自ドメインの [shunyaueta.com](https://shunyaueta.com/) をホスティングしてたんですが、Firebase でホスティングできると聞いて Firebase に移行しました。

PWA にしたのは完全に趣味です。

### TL;DR;

- Web App を作ってる人は manifest.json を設置するだけでも Android の使用感が改善されそう
- 独自ドメインでお手軽に SSL ホスティングしたいなら Firebase hosting めっちゃおすすめです(1GB のホスティングは無料)
- FireBase Hosting だけだと Firebase 本来の旨味は味わえません

### PWA

1 年前ですが、簡潔に PWA の事が書かれています

[プログレッシブウェブアプリ詳解 ─ 過去・現在・未来](https://html5experts.jp/agektmr/20527/)

![image](/posts/2018-01-09/images/2.png)

![image](/posts/2018-01-09/images/3.png)

左: PWA 化以前 右: PWA 化以降

ServiceWorker と manifest.json,あとは&lt;meta name=”theme-color”&gt;を指定すると PWA のスコアが 100 点になる 🎉

![image](/posts/2018-01-09/images/4.png)

manihest.json によるホームアイコン作成誘導

Favicon の各画像の生成は下記のサイトが便利でした。要求される解像度毎の画像(Favicon,Home icon, Apple home icon)が生成されて mahifest.json も同梱されます。(画像の圧縮率も選べる)

[Favicon Generator for all platforms: iOS, Android, PC/Mac...](https://realfavicongenerator.net/)

後は、

[Learn how to build a PWA in 5 minutes](https://medium.com/dev-channel/learn-how-to-build-a-pwa-in-under-5-minutes-c860ad406ed)

を参考に最小実装で実現しました。(Web 通知は無意味だから止めました)

CSS は Skelton を採用しました。(css only 実装で js がなくてシンプルで良い)

[dhg/Skeleton](https://github.com/dhg/Skeleton)

**Web App やってる人は、実装コスト 1 時間程度で済むので皆 manifest.json を設置するべき!!!**

> [](https://twitter.com/agektmr/status/894753854373351424)
> kitamura さんの受け売りです

Web App Manifest については下記の記事が分かりやすいです。

[Web App Manifest で Web アプリをインストール可能に - Qiita](https://qiita.com/horo/items/ff665e4a6613e7684f8f)

というか皆 Chrome の中の人の記事だった(どうりで詳しいわけですね…)

### ホスティング

Github Pages+CloudFlare(独自ドメイン運用)で SSL 認証された Web Page のホスティングを実現していました。

FireBase では、[FireBase Hosting](https://firebase.google.com/docs/hosting/)を使うことで独自ドメインでもデフォルトで https で Web サイトがホスティングされます(最高)

![image](/posts/2018-01-09/images/5.png)

やり方は以下を参考

[Deploy Your Site | Firebase](https://firebase.google.com/docs/hosting/deploying)

めっちゃ簡単にデブロイできます…!!

#### 成果物

[Shunya Ueta | Engineer](https://shunyaueta.com/)

#### 所感

今回は静的かつ小規模な Web サイトを PWA 化したので、恩恵殆ど無いですがまともな WebApp だと恩恵めっちゃ受けると思います。(Twitter Lite や日経電子版の web サイトなど)

[How we built Twitter Lite](https://blog.twitter.com/engineering/en_us/topics/open-source/2017/how-we-built-twitter-lite.html)

[いまさら聞けない PWA と AMP - Qiita](https://qiita.com/edwardkenfox/items/4c0b9550ffa48c1f0445)
