#FROM python:3
#ENV PYTHONUNBUFFERED 1
#RUN mkdir /usr/src/app
#WORKDIR /usr/src/app
#COPY requirements.txt /usr/src/app
#RUN pip install -r requirements.txt
#COPY . /usr/src/app

FROM python:3
ENV PYTHONUNBUFFERED 1
RUN mkdir /usr/src/${DJANGO_PROJECT_NAME}
WORKDIR /usr/src/${DJANGO_PROJECT_NAME}
COPY requirements.txt /usr/src/${DJANGO_PROJECT_NAME}/
RUN pip install -r requirements.txt
COPY . /usr/src/${DJANGO_PROJECT_NAME}
