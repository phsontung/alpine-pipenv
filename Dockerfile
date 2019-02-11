FROM python:3.7-alpine
LABEL maintainer="Tung Pham <phsontung@gmail.com>"

ENV APP_DIR /app

RUN mkdir ${APP_DIR}
WORKDIR ${APP_DIR}

COPY requirements.txt ${APP_DIR}

RUN apk add --no-cache postgresql-libs && \
    apk add --update supervisor &&\
    apk add --no-cache --virtual .build-deps gcc g++ musl-dev postgresql-dev jpeg-dev zlib-dev &&\
    pip install --no-cache-dir -r requirements.txt &&\
    rm  -rf /tmp/* /var/cache/apk/*
# apk del .build-deps gcc musl-dev g++ postgresql-dev jpeg-dev zlib-dev

ADD supervisord.conf /ect/

CMD ["python3"]
