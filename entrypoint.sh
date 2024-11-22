#!/bin/sh
# Run database migrations

python manage.py makemigrations

python manage.py migrate --no-input

# Run any other initialization tasks here

exec gunicorn --bind 0.0.0.0:8000 backend.wsgi:application


# Execute the main process (passed as CMD)
exec "$@"
