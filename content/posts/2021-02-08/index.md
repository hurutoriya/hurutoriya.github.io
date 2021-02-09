---
title: "pip 実行時に sys.stderr.write(f\"ERROR: {exc}
\") とエラーが出てpipを実行できないときの対処方法"
date: 2021-02-08T23:29:12+09:00
lang: ja
tags:
- Python
---

新しいマシンで`pip`をセットアップして実行しようとすると

```bash
>> pip
Traceback (most recent call last):
  File "/usr/local/bin/pip", line 11, in <module>
    load_entry_point('pip==21.0', 'console_scripts', 'pip')()
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/pkg_resources/__init__.py", line 489, in load_entry_point
    return get_distribution(dist).load_entry_point(group, name)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/pkg_resources/__init__.py", line 2843, in load_entry_point
    return ep.load()
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/pkg_resources/__init__.py", line 2434, in load
    return self.resolve()
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/pkg_resources/__init__.py", line 2440, in resolve
    module = __import__(self.module_name, fromlist=['__name__'], level=0)
  File "/Library/Python/2.7/site-packages/pip-21.0-py2.7.egg/pip/_internal/cli/main.py", line 60
    sys.stderr.write(f"ERROR: {exc}")
```

というエラーが出た。

デフォルトのPython の実行ランタイムが2.x 系で、のでそれに起因するエラーだった。
pipをPython2系でおそらくインストールしており、pip21に更新後はPython3.6 からの機能であるf-stringが利用され始めたことが起因らしい

## 対処方法

既存のpipを削除した上で、

```bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
```

でpipが実行できるようになりエラーが解消された

## Appendix

- [pip install failing on python2](https://stackoverflow.com/questions/65866417/pip-install-failing-on-python2)
