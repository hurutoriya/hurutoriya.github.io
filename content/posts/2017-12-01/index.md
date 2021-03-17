---
title: "Machine Learning that Matters (ICML2012) を読んだ"
date: 2017-12-01T07:55:12.617Z
lastmod: 2019-06-16T18:16:08+09:00
lang: ja
tags:
  - Machine Learning
  - Paper
  - Data Science
---

機械学習の研究してる人は全員読んだ方がいい。そう断言できるぐらい良い内容が書かれています。 ICML2012 で発表された最近の機械学習に関する研究の問題点を論じた論文。

![image](/posts/2017-12-01/images/1.png)

Summaly

「あなたは現実世界で役立つデータに対して機械学習の研究を行っていますか?」

著者は NASA の JPL(ジェット推進研究所)、カリフォルニア工科大学に所属する Kiri L.

[Kiri L. Wagstaff](http://www.wkiri.com/)

発表動画を探してみたんですが、ICML2012 で発表した際のビデオはサーバのクラッシュにより喪失したとのこと。

> _The video for my controversial ICML 2012 talk is no longer available (lost in a server crash). However, you can read the original paper: Machine Learning that Matters (pdf, 6 pages, 234K) and see the slides from a subsequent invited AAAI talk: Challenges for Machine Learning Impact on the Real World (1.6M). PowerPoint は下記リンク先に配布されています。_[_http://www.wkiri.com/research/papers/wagstaff-MLmatters-slides-AAAI.pptx_](http://t.umblr.com/redirect?z=http%3A%2F%2Fwww.wkiri.com%2Fresearch%2Fpapers%2Fwagstaff-MLmatters-slides-AAAI.pptx&t=MWJjOWZiMjU4ZDE4MjA3YzkzNWIyMTlmMmQxMzU2YTIyYjRiZGE4NSxFcWFNc3VFOA%3D%3D&b=t%3A7D8PTMepfNiraqMxnsn59A&p=http%3A%2F%2Fhurutoriya.tumblr.com%2Fpost%2F122944523966%2Fmachine-learning-that-matters-icml2012-%E8%AA%AD%E3%82%93%E3%81%A0&m=1)

時間のある人は是非原著論文を呼んでみてください!

### 概要

最近の機械学習は問題を社会・科学世界から持ち込むための深刻なギャップがある。 データセットに明確な制約をかけた物を私達は調査し、それを評価指標のために利用する。 データセットがある問題領域に戻って考えよう。 機械学習が持つインパクト(影響)を増加するためは私達の研究で何を変えればいいだろう？ 我々は機械学習の問題について焦点と議論を交わす。

大事なところは全て下記の記事が抑えてくれてるので、時間の無駄だと思うので訳すのはやめます。

＊下記の記事がキッカケでこの論文を知りました。 日本語で詳しくこの論文が紹介されていて、この記事を読めば大事な事が僕のメモよりはるかに分かりやすく書かれています。

[Machine Learning that Matters(ICML 2012) 読んだ - 糞ネット弁慶](http://d.hatena.ne.jp/repose/20120603/1338715703)

### コメント

機械学習に関する意味ある応用と理論[¹] というよりも、科学と工学の研究の違いについて、考える後押しをくれた論文でした。 大学院で科学寄りの講義を受けていると、「じゃあ、工学の意味ってなんだろう?」と考える事が多くなりました。

今まで見聞きした中で工学の説明で一番しっくりきたのは、昔東大工学部のサイトに掲載されていた下記の言葉です。

「工学とは意思を実現する学問である」

他にこの論文について取り上げられている記事。 [優秀な研究者がエンジニアに流れているのは日本だけじゃないのかも](http://t.umblr.com/redirect?z=http%3A%2F%2Fd.hatena.ne.jp%2Fmyopomme%2F20120606%2F1338993847&t=MmY0YTdmNjdmMmVmOWQ4NGFkYmZlZDI4NDc0ZDVhODgzOTIxMWNhMyxFcWFNc3VFOA%3D%3D&b=t%3A7D8PTMepfNiraqMxnsn59A&p=http%3A%2F%2Fhurutoriya.tumblr.com%2Fpost%2F122944523966%2Fmachine-learning-that-matters-icml2012-%E8%AA%AD%E3%82%93%E3%81%A0&m=1)

上記の記事の統計学者ブラッドリー・エフロンが述べている言葉は、じんわりと自分に染み渡ってきました。

> _計算機科学の世界には、我々がデータを計算機に入れさえすれば正しい答えが出てくるのだという誤解が向けられている。いまやさまざまな分野で、例えば天文学などがそうだが、多くの部分を計算機とシミュレーションに負うようになってきていて、彼らは自然そのものではなく、シミュレーションなどを見て議論をするようになっている。これは我々統計学者の状況と同じだ。彼らはどんどん二次科学に近付いている。これは、彼らも私たちと同じトラブルに見舞われていること意味する。「何が正しくて何が間違っているのか」。私はたまに思うのだが、科学の歴史の中で、まず目に見える簡単な問題から解かれていった。そこには確率も統計も必要がなかった。科学はそういう簡単な問題をどんどん征服していっているのではないかとも思える。今科学は非常に複雑な問題について研究をし始めている。「自然の中の科学」と「自然を越えた科学」の両方がある中で、我々は２番目のものに向かっているのではないだろうか。_

引用しか残っておらず、本体記事の方は消えているのが残念です。
