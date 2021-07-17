---
title: "How to concat image using skimage"
date: 2019-06-17T00:07:33+09:00
lang: en
tags:
  - python
  - imageprocessing
---

When you need to concat same size image to make figure.

skimage & numpy combination is too powerfull to concat images.

This is sample script.

```python
from skimage import data, io
import numpy as np

img = skimage.data.astronaut()
imgs= [img for i in range(10)]

skimage.io.imsave("sample_h.png",np.hstack(imgs))
skimage.io.imsave("sample_v.png",np.vstack(imgs))
```

After that you can get below images.

- ![concat holiznal](/posts/2019-06-17/images/sample_h.png)
- ![concat vertical](/posts/2019-06-17/images/sample_v.png)

Via Gist:
https://gist.github.com/hurutoriya/fedf059ad3db5c67b16d8d5dd6d3df70
