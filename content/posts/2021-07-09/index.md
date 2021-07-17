---
title: "How to get the uploaded file path and processing its file in  Streamlit"
date: 2021-07-09T22:40:37+09:00
lang: en
author: Shunya Ueta
tags:
- python
- streanlit
---

## Motivation

[Streamlit](https://streamlit.io/) is a powerful tools to quickliy build the demo application.
If we use Streamlit file upload feature via WebBrowser  then we need to its file path to process the uploaded file.
So I will introduce how to get uploaed file path in Streamlit.

## Example

We buid the PDF File upload feature  in Streamlit and its PDF file convert to image.
We use [Belval/pdf2image](https://github.com/Belval/pdf2image) which is a populer PDF converting tool. It needs to file path to apply the module feature. we assume local machine is the MacOS then we need to install the [poppler](https://poppler.freedesktop.org/) to use `pdf2image`,


### Demo app screenshot and open sourced code

![get the uploaded file path in Streamlit](/posts/2021-07-09/images/streamlit.png)


We also publised a code example at [hurutoriya/streamlist-file-uploader-example](https://github.com/hurutoriya/streamlist-file-uploader-example)

[Demo Movie in Youtube](https://youtu.be/ILGVapirwlg)

###  Makefile 

It worked task runner to install the dependency and run the app.

```makefile
install:
	brew install poppler
	poetry install
run:
	poetry run streamlit run streamlit_pdf_uploader/main.py
```

### Poetry for package management

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

[Streamlit](https://streamlit.io/) is a powerful tools to quickliy build the demo application.
You leand about how to get the uploade file path from Streamlit in this post.

## Reference

- [Showing PDF file on StreamlitSharing that’s in github directory](https://discuss.streamlit.io/t/showing-pdf-file-on-streamlitsharing-thats-in-github-directory/11955)
- [Problem in reading a “db” object using file uploader](https://discuss.streamlit.io/t/problem-in-reading-a-db-object-using-file-uploader/3064/10)