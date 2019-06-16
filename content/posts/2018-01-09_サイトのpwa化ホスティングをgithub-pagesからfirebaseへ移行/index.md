---
title: "サイトのPWA化、ホスティングをGithub PagesからFirebaseへ移行"
author: "Shunya Ueta"
date: 2018-01-09T18:59:59.969Z
lastmod: 2019-06-16T18:17:31+09:00

description: ""

subtitle: "PWAとFireBaseを試してみたかった"
tags:
 - Firebase 
 - Pwa 
 - Github Pages 

image: "/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/1.png" 
images:
 - "/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/1.png" 
 - "/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/2.png" 
 - "/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/3.png" 
 - "/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/4.png" 
 - "/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/5.png" 


aliases:
    - "/change-to-firebase-hosting-from-githubpages-cloudflare-daf1ca4022c5"
---

PWAとFireBaseを試してみたかった



![image](/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/1.png)

firebase init で現れる画面、テンション上がる

Github Pages + CloudFlareで独自ドメインの [shunyaueta.com](https://shunyaueta.com/) をホスティングしてたんですが、Firebaseでホスティングできると聞いてFirebaseに移行しました。

PWAにしたのは完全に趣味です。

### TL;DR;

*   Web Appを作ってる人はmanifest.jsonを設置するだけでもAndroidの使用感が改善されそう
*   独自ドメインでお手軽にSSLホスティングしたいならFirebase hostingめっちゃおすすめです(1GBのホスティングは無料)
*   FireBase HostingだけだとFirebase本来の旨味は味わえません

### PWA

1年前ですが、簡潔にPWAの事が書かれています

[プログレッシブウェブアプリ詳解 ─ 過去・現在・未来](https://html5experts.jp/agektmr/20527/)




![image](/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/2.png)





![image](/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/3.png)

左: PWA化以前 右: PWA化以降

ServiceWorkerとmanifest.json,あとは&lt;meta name=”theme-color”&gt;を指定するとPWAのスコアが100点になる 🎉



![image](/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/4.png)

manihest.jsonによるホームアイコン作成誘導

Faviconの各画像の生成は下記のサイトが便利でした。要求される解像度毎の画像(Favicon,Home icon, Apple home icon)が生成されてmahifest.jsonも同梱されます。(画像の圧縮率も選べる)

[Favicon Generator for all platforms: iOS, Android, PC/Mac...](https://realfavicongenerator.net/)


後は、

[Learn how to build a PWA in 5 minutes](https://medium.com/dev-channel/learn-how-to-build-a-pwa-in-under-5-minutes-c860ad406ed)


を参考に最小実装で実現しました。(Web通知は無意味だから止めました)

CSSはSkeltonを採用しました。(css only実装でjsがなくてシンプルで良い)

[dhg/Skeleton](https://github.com/dhg/Skeleton)


**Web Appやってる人は、実装コスト1時間程度で済むので皆 manifest.jsonを設置するべき!!!**

> [](https://twitter.com/agektmr/status/894753854373351424)
kitamuraさんの受け売りです



Web App Manifestについては下記の記事が分かりやすいです。

[Web App ManifestでWebアプリをインストール可能に - Qiita](https://qiita.com/horo/items/ff665e4a6613e7684f8f)


というか皆Chromeの中の人の記事だった(どうりで詳しいわけですね…)

### ホスティング

Github Pages+CloudFlare(独自ドメイン運用)でSSL認証されたWeb Pageのホスティングを実現していました。

FireBaseでは、[FireBase Hosting](https://firebase.google.com/docs/hosting/)を使うことで独自ドメインでもデフォルトでhttpsでWebサイトがホスティングされます(最高)



![image](/posts/2018-01-09_サイトのpwa化ホスティングをgithub-pagesからfirebaseへ移行/images/5.png)

やり方は以下を参考

[Deploy Your Site | Firebase](https://firebase.google.com/docs/hosting/deploying)


めっちゃ簡単にデブロイできます…!!

#### 成果物

[Shunya Ueta | Engineer](https://shunyaueta.com/)


#### 所感

今回は静的かつ小規模なWebサイトをPWA化したので、恩恵殆ど無いですがまともなWebAppだと恩恵めっちゃ受けると思います。(Twitter Liteや日経電子版のwebサイトなど)

[How we built Twitter Lite](https://blog.twitter.com/engineering/en_us/topics/open-source/2017/how-we-built-twitter-lite.html)





[いまさら聞けないPWAとAMP - Qiita](https://qiita.com/edwardkenfox/items/4c0b9550ffa48c1f0445)
