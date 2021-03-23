FROM python:3.8-slim

ENV APP_HOME /app
WORKDIR $APP_HOME

RUN apt-get update \
    && apt-get -y install git

RUN pip install --upgrade pip
RUN pip install pipenv
COPY ./Pipfile .
RUN pipenv install --skip-lock --system --dev

COPY . .

ENV PORT 8080

ENV PYTHONUNBUFFERED TRUE

CMD exec gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 0 core.wsgi:application