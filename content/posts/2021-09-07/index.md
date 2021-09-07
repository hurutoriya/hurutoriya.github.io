---
title: "gcloud commands で PubSub に jsonファイルをメッセージとして公開 (Pusblish) する"
date: 2021-09-07T12:22:16+09:00
lang: ja
author: Shunya Ueta
tags:
- gcp
---

gcloud commands で PubSub に jsonファイルをメッセージとして公開 (Pusblish) する

`jq` コマンドが必要になるが、一番簡単に実現できるのは

```bash
$ gcloud pubsub topics publish ${PUBSUB_TOPIC_NAME} --message "$(cat ${FILE_NAME} | jq -c)"
```

`jq` コマンドの `-c` オプションは compact-output を意味している。デフォルトだと pretty-prints になってしまう。
それを避けるために`-c`オプションを使用している。

## ref

- [Publishing messages to topics](https://cloud.google.com/pubsub/docs/publisher)
- [Read a txt file JSON data to publish the messages in Cloud Pub Sub](https://stackoverflow.com/questions/55513746/read-a-txt-file-json-data-to-publish-the-messages-in-cloud-pub-sub)
