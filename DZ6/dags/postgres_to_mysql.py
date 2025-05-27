from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import pandas as pd
import sqlalchemy

def pg_to_mysql():
    pg = sqlalchemy.create_engine("postgresql://postgres:postgres@postgres:5432/target_db")
    mysql = sqlalchemy.create_engine("mysql+pymysql://root:root@mysql:3306/source_db")
    df = pd.read_sql("SELECT * FROM customers", con=pg)
    df.to_sql("customers", con=mysql, if_exists='replace', index=False)

with DAG(
    "postgres_to_mysql",
    start_date=datetime(2024, 1, 1),
    schedule_interval='@hourly',
    catchup=False,
    tags=['example'],  # можно добавить теги для удобства
) as dag:
    replicate_task = PythonOperator(
        task_id="replicate_pg_to_mysql",
        python_callable=pg_to_mysql
    )