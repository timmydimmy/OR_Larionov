from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import pandas as pd
import sqlalchemy

def mysql_to_pg():
    mysql = sqlalchemy.create_engine("mysql+pymysql://root:root@mysql:3306/source_db")
    pg = sqlalchemy.create_engine("postgresql://postgres:postgres@postgres:5432/target_db")
    df = pd.read_sql("SELECT * FROM customers", con=mysql)
    df.to_sql("customers", con=pg, if_exists='replace', index=False)

with DAG(
    "mysql_to_postgres",
    start_date=datetime(2024, 1, 1),
    schedule_interval='@hourly',
    catchup=False,
) as dag:
    PythonOperator(
        task_id="replicate_mysql_to_pg",
        python_callable=mysql_to_pg
    )