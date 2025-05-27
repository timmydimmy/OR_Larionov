from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import pandas as pd
import sqlalchemy

def load_csv_to_mysql():
    df = pd.read_csv('/opt/airflow/data/customers.csv', sep=';')
    engine = sqlalchemy.create_engine("mysql+pymysql://root:root@mysql:3306/source_db")
    df.to_sql("customers", con=engine, if_exists='replace', index=False)

with DAG(
    dag_id="load_csv_to_mysql",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,
) as dag:
    load_task = PythonOperator(
        task_id="load_csv",
        python_callable=load_csv_to_mysql
    )