---
title: "ソフトウェア開発における Upstream と Downstream の意味"
date: 2020-04-27T23:55:42+09:00
lang: ja
tags:
  - development
---

- Upstream
  - Upstream はそのシステムが依存しているジョブ
  - Upstream のデザインが変わることで、システムも影響をうける
- Downstream
  - Downstream はそのシステムが影響を与える影響を与える部分

例えば、Web Application などでは、データベースは Downstream となる

e.g. `Web service→ Databese` という流れでデータが作成される

## References

- https://reflectoring.io/upstream-downstream/
- https://softwareengineering.stackexchange.com/questions/71080/what-does-downstream-upstream-design-mean/83686
- https://en.wikipedia.org/wiki/Upstream_(software_development)
- https://en.wikipedia.org/wiki/Downstream_(software_development)
