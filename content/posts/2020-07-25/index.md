---
title: "How to write stdin UnitTest using Pytest"
date: 2020-07-25T03:18:14+09:00
draft: true
lang: en
tags:
- Python
- Pytest
---

If you want to write UnitTest when using `stdin` in Python.
Pytest provide `setattr` function in `monkeypatch`

```python
from io import StringIO
import sys


def divide():
    input = sys.stdin.readline
    return list(input())


def gather():
    input = sys.stdin.readline
    return sum(list(map(int, input().split())))


def test_divide(monkeypatch):
    monkeypatch.setattr('sys.stdin', StringIO('abc'))
    assert divide() == ['a', 'b', 'c']


def test_gather(monkeypatch):
    monkeypatch.setattr('sys.stdin', StringIO('1 2 3'))
    assert gather() == 6
```

## Reference

- [Monkeypatching/mocking modules and environments](https://docs.pytest.org/en/latest/monkeypatch.html#simple-example-monkeypatching-functions)
- [I  want to use stdin in a pytest test](https://stackoverflow.com/questions/38723140/i-want-to-use-stdin-in-a-pytest-test)
- https://gist.github.com/GenevieveBuckley/efd16862de9e2fe7adfd2bf2bef93e02
