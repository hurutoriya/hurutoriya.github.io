---
title: "Label Studio を kubernetes にデプロイする"
date: 2022-06-03T20:44:01+09:00
lang: ja
author: Shunya Ueta
tags:
  - annotation
  - kubernetes
---

前回 Label Studio の紹介記事[^labelstudio-past-post]を書きましたが、自分以外にもチーム全体で Label Studio を使いたいという要望があったので Web アプリとして labelstudio をホストしました。
意外と簡単に k8s 上でホストできたので、その方法を公開しておく。

Label Studio の運用方法は、 Docker イメージが提供されているので、それを使用するのが最も簡単です。

CloudRun を使ってサーバーレスで動かす方法[^labelstudio-cloudrun]もありますが、今回は k8s 上に Label Studio の Docker イメージをデプロイして、運用することになりました。

k8s のマニフェストファイルは、公式リポジトリ[^labelstudio-k8s]を参考に作成しました。

```yaml
apiVersion: v1
kind: Service
metadata:
  name: labelstudio
  namespace: development
spec:
  ports:
    - name: http
      port: 8080
      protocol: TCP
  selector:
    app: labelstudio
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: labelstudio-data-pvc
  namespace: development
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: labelstudio
  name: labelstudio
  namespace: development
spec:
  replicas: 1
  selector:
    matchLabels:
      app: labelstudio
  template:
    metadata:
      labels:
        app: labelstudio
    spec:
      containers:
        - image: heartexlabs/label-studio:v1.4.1
          imagePullPolicy: Always
          name: labelstudio
          ports:
            - containerPort: 8080
          stdin: true
          tty: true
          volumeMounts:
            - mountPath: /label-studio/data
              name: labelstudio-data-vol
      imagePullSecrets:
        - name: secret
      volumes:
        - name: labelstudio-data-vol
          persistentVolumeClaim:
            claimName: labelstudio-data-pvc
```

あとは、以下のコマンドを打てば、Label Studio の Pod にポートフォワードされるので、

```bash
> kubectl -n development port-forward svc/labelstudio 8080:8080
```

http://localhost:8080/

にアクセスすれば、k8s 上でホストされる Label Studio にアクセスが可能になります。

本当は、Google App Engine でホストしたかったんですが、GAE の Docker はマウント機能が使えず、永続層に DB を SQLite で保存する Labelstudio では採用することができませんでした。残念

逆にデモアプリでお世話になる Streamlit は GAE でポンッとデプロイできるから、気軽に Web アプリとしてホストできるから良いですね。[^streamlit-gae]

[^labelstudio-past-post]: [OSS のアノテーションツール Label Studio を使って、快適にアノテーションする](/posts/2022-01-09/)
[^labelstudio-cloudrun]: [【AI Shift Advent Calendar 2021】Label Studio の GCP 上でのデプロイ \| 株式会社 AI Shift](https://www.ai-shift.co.jp/techblog/2422)
[^labelstudio-k8s]: [Add kubernetes files to allow easy deployment by boogheta · Pull Request \#1067 · heartexlabs/label\-studio](https://github.com/heartexlabs/label-studio/pull/1067)
[^streamlit-gae]: https://discuss.streamlit.io/t/gcp-app-engine-integration/11322/3
