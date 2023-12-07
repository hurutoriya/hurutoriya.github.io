---
title: "GitHub PagesのDNSをCloudflareに移行時にERR_TOO_MANY_REDIRECTS が出た際の対処方法"
date: 2023-12-07T22:35:33+09:00
lang: ja
author: Shunya Ueta
tags:
  - cloudflare
  - github
---

来月に Google Domain の有効期限が切れるので、エイヤと Cloudflare に乗り換えてみた。作業自体は 30 分程度で完了して簡単だった。

移行直後は問題なかったが、翌朝 `ERR_TOO_MANY_REDIRECTS` というエラーが返されるようになった。

## 解決方法

Cloudflare の SSL/TLS セクションでお客様の SSL/TLS 暗号化モードを Full に変更する[^ref]。初期設定は Flexible でそれが原因でリダイレクトループが発生する模様

[^ref]: [dns \- How to fix ERR_TOO_MANY_REDIRECTS on custom github pages domain? \- Stack Overflow](https://stackoverflow.com/questions/50145231/how-to-fix-err-too-many-redirects-on-custom-github-pages-domain)
