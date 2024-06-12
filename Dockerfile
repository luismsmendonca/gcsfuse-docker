FROM debian:bookworm-slim

LABEL maintainer "Luis Mendonca <luismsmendonca@gmail.com>"
LABEL description "gcsfuse"

RUN \
  apt-get update && \
  apt-get install -y curl lsb-release  && \
  export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s` && \
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.asc] https://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list  && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.asc && \
  apt-get update && \
  apt-get install -y gcsfuse && \
  apt-get clean

ENV BUCKET_NAME my-bucket
ENV GOOGLE_APPLICATION_CREDENTIALS /etc/gcloud/service-account.json

CMD gcsfuse --foreground -o allow_other $BUCKET_NAME /mnt
