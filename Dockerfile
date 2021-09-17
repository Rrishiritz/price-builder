FROM python:alpine3.7
WORKDIR /app
COPY requirements.txt requirements.txt
RUN apk add --update \
  && pip install --upgrade pip  \
  && pip install -r requirements.txt \
  && rm -rf /var/cache/apk/*
COPY . .
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]