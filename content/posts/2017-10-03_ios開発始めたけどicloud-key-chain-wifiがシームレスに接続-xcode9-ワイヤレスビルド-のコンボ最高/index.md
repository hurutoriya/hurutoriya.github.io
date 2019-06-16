---
title: "iOS開発始めたけど、icloud key chain :WiFiがシームレスに接続 ✕ Xcode9 :ワイヤレスビルド のコンボ最高"
author: "Shunya Ueta"
date: 2017-10-03T11:48:55.866Z
lastmod: 2019-06-16T18:15:50+09:00

description: ""

subtitle: "最近iOSの開発を始めたんですが、昔に比べるとかなり快適になっきてるなと感動したので覚書"
tags:
 - 日本語 
 - iOS 
 - Xcode 

image: "/posts/2017-10-03_ios開発始めたけどicloud-key-chain-wifiがシームレスに接続-xcode9-ワイヤレスビルド-のコンボ最高/images/1.png" 
images:
 - "/posts/2017-10-03_ios開発始めたけどicloud-key-chain-wifiがシームレスに接続-xcode9-ワイヤレスビルド-のコンボ最高/images/1.png" 


aliases:
    - "/ios%E9%96%8B%E7%99%BA%E5%A7%8B%E3%82%81%E3%81%9F%E3%81%91%E3%81%A9-icloud-key-chain-wifi%E3%81%8C%E3%82%B7%E3%83%BC%E3%83%A0%E3%83%AC%E3%82%B9%E3%81%AB%E6%8E%A5%E7%B6%9A-xcode9-%E3%83%AF%E3%82%A4%E3%83%A4%E3%83%AC%E3%82%B9%E3%83%93%E3%83%AB%E3%83%89-%E3%81%AE%E3%82%B3%E3%83%B3%E3%83%9C%E6%9C%80%E9%AB%98-7ba01a36b960"
---

![image](/posts/2017-10-03_ios開発始めたけどicloud-key-chain-wifiがシームレスに接続-xcode9-ワイヤレスビルド-のコンボ最高/images/1.png)

便利

最近iOSの開発を始めたんですが、昔に比べるとかなり快適になっきてるなと感動したので覚書

表題のそのまんまです。

**icloud key chain :** 同一のApple IDでログインしてると icloud key chainでWiFiのネットワーク設定が同期されます。(e.g. iPhoneであるWiFi Σに接続するとiPadやMacも自動的にWiFi Σに接続される)

[Frequently asked questions about iCloud Keychain](https://support.apple.com/en-us/HT204085)


**Xcode 9 Wireless Build** : Xcode 9からUSB接続なしで、同一LAN内であればワイヤレスビルドができるようになった。(*初期にワイヤレスビルドの設定は必要)

[How to use Wireless Debugging on Xcode 9](https://medium.com/swiftist/wireless-debugging-xcode-b6e98e26e022)


この２つが組み合わさることで、

1.  MacでWiFiに接続→iPhone, iPadも同じWiFiに自動的に接続される
2.  同一WiFiに接続されるので、Xcodeのワイヤレスビルドも空気のように行える

**最高!!!**

というわけでiOS開発始めたんですが、分からない所にぶち当たりまくる所存なので、詰まった時に救ってくれるメンターを探してます。

逆に僕はComputer Vision, Machine Leaning 関係の事は教えられるので、iOSで困ったことを教えてくれる代わりに、それらの知見を共有します。

以下自分のiOS開発の回顧録

### 6年前(2011)

高専4年生(2011年)の準卒業研究（研究と呼べる代物ではない)でiOSアプリを初めてちょこっと触ったんですが、そのときは先生のMac miniを使って開発していたんですが(たしか **Snow Leopard**)、授業以外でプログラミングをしたことがない自分にとって Interface builderや Xcodeは全然分からなくて辛さが充満していた。

といってもiOSの開発経験がこれで付いたかというとそんなことはない

### **4年前(2013)**

@exilias がバリバリのiOS Developerでハッカソンに参加した時に、自分も一つのビューの実装を補助して準優勝した。

そのときにストーリボードを知って、「おお〜便利になったんだなぁ」と感動した。

といってもiOSの開発経験がこれで付いたかというとそんなことはなかった(2回目)

### 3年前(2014)

ベンチャー企業でiOS 開発経験者がだれもいないなか、マンガアプリのプロトタイプを作るバイトを任され、サーバーの漫画の画像を取得して左右のフリックで読めるアプリを作ってた。

といってもiOSの開発経験がこれで付いたかというとそんなことはなかった(2回目)

ココらへんで気がついたけど**ある一定以上のレベルでスキルを習得したい場合は、メンターの存在と時間の投資**が不可欠だなと思った。

### 今(2017)

ある程度の時間を投資してiOS11の機能をフルに使ったアプリを作成中。以下の点を抑えつつプロトタイプならさくっと作れるくらいのスキルは今回で付けときたい

*   **iOS開発のメンターを探す**
*   **時間を投資**
