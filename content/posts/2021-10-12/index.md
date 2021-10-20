---
title: "Airflow でDAGを任意のタイミングで一度だけ実行する方法"
date: 2021-10-12T00:07:05+09:00
lang: ja
author: Shunya Ueta
tags:
- airflow
---

Airflow で作成したDAGを自動で定期実行せずに、あえて手動実行で一度だけ実行したい場合もある。

`DAG`のオプションを以下のように設定する。

1. `schedule_interval` を "@once" に設定することで、一度だけDAGが実行される
2. `is_paused_upon_creation` を `True` に設定することで、DAGが作成時に自動的に実行されず、DAGが停止状態で作成される。
デフォルトでは`False`となっており、自動実行される。

```python
from airflow import DAG

with DAG(
    dag_id="sellerscore_initial_batch",
    # NOTE: dosen't need to repeat
    schedule_interval="@once",
    # NOTE: we have to manually start the this DAG
    is_paused_upon_creation=True,
) as dag:
```


## Reference
- [Airflow: schedule_interval = '@once'](https://stackoverflow.com/questions/65742424/airflow-schedule-interval-once)
- [Docs - airflow.models.dag](https://airflow.apache.org/docs/apache-airflow/stable/_api/airflow/models/dag/index.html?highlight=is_paused#airflow.models.dag.DagModel.is_paused_at_creation)