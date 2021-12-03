---
title: "k8s デプロイ時に `MatchExpressions:[]v1.LabelSelectorRequirement(nil)}: field is immutable` エラーが出た際に対処方法"
date: 2021-12-02T16:48:54+09:00
author: Shunya Ueta
tags:
- k8s
---

k8s で manifest file を編集して実行したら以下のようなエラーが出て実行できなかった。

>  Exception ( Monitor Deploy )
Deploy failed: The Deployment “---” is invalid: spec.selector: Invalid value: v1.LabelSelector{MatchLabels:map[string]string{“app”:“---”}, MatchExpressions:[]v1.LabelSelectorRequirement(nil)}: field is immutable

調べてみたところ、

> once deployed the label selectors of kubernetes service can not be updated until you decide to delete the existing deployment

ref: [MatchExpressions:[]v1.LabelSelectorRequirement(nil)}: field is immutabl #508](https://github.com/kubernetes/client-go/issues/508#issuecomment-589296590)

らしく、一度デプロイされたk8s service の label selector は、既存のdeployment を削除しないとアップデートは不可能らしい。

なので、`field is immutable`というエラー文は正しいわけですね。

そのdeployment を削除しても良い状態なら、以下のコマンドを実行後再度デプロイすれば、k8s service のlabel selector は実行されます。

```bash
kubectl delete deploy <deployment-name>
```

もしくは、k8s service のlabel selectorの変更を諦めて既存のまま運用するのがもう一つの正解でしょうか。


## References

- [MatchExpressions:[]v1.LabelSelectorRequirement(nil)}: field is immutabl #508](https://github.com/kubernetes/client-go/issues/508#issuecomment-589296590)
- [Invalid spec selector after upgrading helm template](https://stackoverflow.com/questions/53998259/invalid-spec-selector-after-upgrading-helm-template)