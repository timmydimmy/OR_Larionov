from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import json
import logging

default_args = {
    'start_date': datetime(2024, 1, 1),
}

with DAG(
    dag_id='ivanov_hw1_json_flatten',
    schedule_interval=None,
    default_args=default_args,
    catchup=False,
    description='Преобразование JSON в линейную структуру',
) as dag:

    def flatten_json():
        raw_json = {
            "pets": [
                {
                    "name" : "Purrsloud",
                    "species" : "Cat",
                    "favFoods" : ["wet food", "dry food", "<strong>any</strong> food"],
                    "birthYear" : 2016,
                    "photo" : "https://learnwebcode.github.io/json-example/images/cat-2.jpg"
                },
                {
                    "name" : "Barksalot",
                    "species" : "Dog",
                    "birthYear" : 2008,
                    "photo" : "https://learnwebcode.github.io/json-example/images/dog-1.jpg"
                },
                {
                    "name" : "Meowsalot",
                    "species" : "Cat",
                    "favFoods" : ["tuna", "catnip", "celery"],
                    "birthYear" : 2012,
                    "photo" : "https://learnwebcode.github.io/json-example/images/cat-1.jpg"
                }
            ]
        }

        flattened = []
        for pet in raw_json["pets"]:
            if "favFoods" in pet:
                for food in pet["favFoods"]:
                    flattened.append({
                        "name": pet["name"],
                        "species": pet["species"],
                        "birthYear": pet["birthYear"],
                        "photo": pet["photo"],
                        "favFood": food
                    })
            else:
                flattened.append({
                    "name": pet["name"],
                    "species": pet["species"],
                    "birthYear": pet["birthYear"],
                    "photo": pet["photo"],
                    "favFood": None
                })

        for row in flattened:
            logging.info(row)

    flatten_task = PythonOperator(
        task_id='flatten_json',
        python_callable=flatten_json
    )