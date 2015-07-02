FROM alpine:3.2

RUN \
  mkdir -p /aws /root/.aws && \
  apk -Uuv add groff less python py-pip && \
  pip install awscli boto boto3 botocore requests s3cmd && \
  apk --purge -v del py-pip && \
  rm /var/cache/apk/*

WORKDIR /aws

ENTRYPOINT ["aws"]
