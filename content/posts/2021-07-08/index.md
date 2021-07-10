---
title: "Streamlit でアップロードしたファイルのパスを取得して、特定の処理をする"
date: 2021-07-08T22:40:37+09:00
lang: en
author: Shunya Ueta
tags:
- Python
- Streanlit
---

## モチベーション

[Streamlit](https://streamlit.io/) はPython code のみで簡単かつ高速にWebアプリを作成できる強力なパッケージ。
Streamplit で作られたWebアプリ経由でファイルをアップロードして、そのファイルを処理したい際の具体的な実現方法がなかったので備忘録がてら残しておく。

## PDFファイルをアップロードして、画像に変換するWebアプリ

具体的に例を交えつつ説明する。
Streamlit を使って、PDFファイルをアップロードしてアップロードされたPDFファイルを画像化するアプリを作成する。
今回は、[Belval/pdf2image](https://github.com/Belval/pdf2image) というPDFパッケージを使用する。
このパッケージは処理したいPDFのファイルパスを要求するインターフェースなので今回の実例に沿っていてわかりやすい。
ローカルマシンは MacOS を想定しており、`pdf2image` は[poppler](https://poppler.freedesktop.org/) の事前インストールが必須。

### 完成形のスクリーンショット

![get the uploaded file path in Streamlit](/posts/2021-07-08/images/streamlit.png)


GitHubでもコードを公開しておきました。

 [hurutoriya/streamlist-file-uploader-example](https://github.com/hurutoriya/streamlist-file-uploader-example)

デモ動画はこちら

[Demo Movie in Youtube](https://youtu.be/ILGVapirwlg)

###  Makefile 

Makefile は依存パッケージを事前インストールするために採用

```makefile
install:
	brew install poppler
	poetry install
run:
	poetry run streamlit run streamlit_pdf_uploader/main.py
```

### Poetry for package management

環境構築はpoetry を使っています。

```toml
[tool.poetry]
name = "streamlit-pdf-uploader"
version = "0.1.0"
description = ""
authors = [""]

[tool.poetry.dependencies]
python = "^3.8"
streamlit = "^0.84.0"
watchdog = "^2.1.3"
pdf2image = "^1.16.0"

[tool.poetry.dev-dependencies]
pytest = "^5.2"

[build-system]
requires = ["poetry-core>=1.0.0"]
build-backend = "poetry.core.masonry.api"
```


### Streamlit Python file

```python
import base64
import tempfile

import streamlit as st
from pdf2image import convert_from_path

from pathlib import Path

def show_pdf(file_path:str):
    """Show the PDF in Streamlit
    That returns as html component

    Parameters
    ----------
    file_path : [str]
        Uploaded PDF file path
    """

    with open(file_path, "rb") as f:
        base64_pdf = base64.b64encode(f.read()).decode("utf-8")
    pdf_display = f'<embed src="data:application/pdf;base64,{base64_pdf}" width="100%" height="1000" type="application/pdf">'
    st.markdown(pdf_display, unsafe_allow_html=True)


def main():
    """Streamlit application
    """

    st.title("PDF file uplodaer")
    uploaded_file = st.file_uploader("Choose your .pdf file", type="pdf")

    if uploaded_file is not None:
        # Make temp file path from uploaded file
        with tempfile.NamedTemporaryFile(delete=False) as tmp_file:
            st.markdown("## Original PDF file")
            fp = Path(tmp_file.name)
            fp.write_bytes(uploaded_file.getvalue())
            st.write(show_pdf(tmp_file.name))

            imgs = convert_from_path(tmp_file.name)

            st.markdown(f"Converted images from PDF")
            st.image(imgs)


if __name__ == "__main__":
    main()

```

## Conclusion

これで、Streamlit 上でファイルをアップロードして、そのアップロードされたファイルに対する処理ができます。
画像や音声など色々応用先があるので便利そう。
動作が遅いという欠点はあれど、これだけ簡単にGUIをPython のみで構築できるのは驚き。
Protly Dashも2年ほど前に使ったことがあるけど、UIのライフサイクルやHTMLを結構意識しないとかけなかったので辛かった記憶があるので、なおさら感動している。

## Reference

- [Showing PDF file on StreamlitSharing that’s in github directory](https://discuss.streamlit.io/t/showing-pdf-file-on-streamlitsharing-thats-in-github-directory/11955)
- [Problem in reading a “db” object using file uploader](https://discuss.streamlit.io/t/problem-in-reading-a-db-object-using-file-uploader/3064/10)