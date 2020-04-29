---
title: "Tensorboard を わずか2行で Jupyter Notebook上で表示"
date: 2019-09-25T23:16:07+09:00
lang: ja
tags:
  - Jupyter
  - Python
  - Pytorch
---

Pytorch 1.2 からは公式に Tensorboard がサポートされている

Tensorboard とは、学習の状況を可視化できる TensorFlow Family の一種

Jupyte Notebook 上で学習状況を確認したい場合に Tensorboard をそのまま表示して確認できれば楽なので、試してみる

sample code: https://pytorch.org/docs/stable/tensorboard.html

```python
import torch
import torchvision
from torch.utils.tensorboard import SummaryWriter
from torchvision import datasets, transforms

# Writer will output to ./runs/ directory by default
writer = SummaryWriter()

transform = transforms.Compose([transforms.ToTensor(), transforms.Normalize((0.5,), (0.5,))])
trainset = datasets.MNIST('mnist_train', train=True, download=True, transform=transform)
trainloader = torch.utils.data.DataLoader(trainset, batch_size=64, shuffle=True)
model = torchvision.models.resnet50(False)
# Have ResNet model take in grayscale rather than RGB
model.conv1 = torch.nn.Conv2d(1, 64, kernel_size=7, stride=2, padding=3, bias=False)
images, labels = next(iter(trainloader))

grid = torchvision.utils.make_grid(images)
writer.add_image('images', grid, 0)
writer.add_graph(model, images)
writer.close()
```

その結果を Jupyter 上で確認したい場合、以下のマジックコマンドを実行する

- https://www.tensorflow.org/tensorboard/r2/tensorboard_in_notebooks

```bash
%load_ext tensorboard
%tensorboard  --logdir runs
```

結果を 1 画面で完結して見せたい場合に便利そう

![tensorboard in jupyter notebook](/posts/2019-09-25/images/1.png)

完了!
