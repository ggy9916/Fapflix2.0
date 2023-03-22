FROM python:3.11.2-alpine as builder

RUN apk update && \
    apk add musl-dev libpq-dev gcc

COPY requirements.txt .
RUN pip install -r requirements.txt

FROM python:3.11.2-alpine

ENV PYTHONUNBUFFERED=1 

RUN apk update && \
    apk add ffmpeg

COPY --from=builder /usr/local/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY ./smol /srv/data/smol
WORKDIR /srv/data/smol

RUN ["chmod", "+x", "/srv/data/smol/startup.sh"]
ENTRYPOINT [ "/srv/data/smol/startup.sh" ]