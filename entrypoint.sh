#!/bin/sh

python manage.py makemigrations

python manage.py migrate --no-input

exec gunicorn --bind 0.0.0.0:8000 backend.wsgi:application

# Execute the main process (passed as CMD)
exec "$@"
