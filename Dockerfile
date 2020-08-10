FROM python:3
ARG DJANGO_PROJECT=my_project
ENV PYTHONUNBUFFERED 1
RUN mkdir /usr/src/${DJANGO_PROJECT}
WORKDIR /usr/src/${DJANGO_PROJECT}
COPY requirements.txt /usr/src/${DJANGO_PROJECT}/
RUN pip install -r requirements.txt
COPY . /usr/src/${DJANGO_PROJECT}/
