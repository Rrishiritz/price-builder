FROM python:3-alpine

MAINTAINER Peter Fisher

COPY ./app/requirements.txt /app/requirements.txt

WORKDIR /app

RUN apk add --update \
  && pip install --upgrade pip  \
  && pip install -r requirements.txt \
  && rm -rf /var/cache/apk/*

RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update -qq && \
    apt-get install -qqy docker-ce && \
    usermod -aG docker jenkins && \
    chown -R jenkins:jenkins $JENKINS_HOME/

COPY ./app /app

CMD python app.py run -h 0.0.0.0

