[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

# Django

```bash
virtualenv django_web_app
source django_web_app/bin/activate
python -m pip install -r requirements.txt

python manage.py startapp my_new_app_module

python manage.py makemigrations
python manage.py showmigrations
python manage.py migrate

make a connection to DB
python manage.py dbshell

python3 manage.py runserver 0.0.0.0:8000
deactivate
```
