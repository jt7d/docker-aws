FROM alpine:3.2

# --pre temporary for https://github.com/aws/aws-cli/issues/1339
RUN \
  mkdir -p /aws /root/.aws && \
  apk -Uuv add groff less python py-pip && \
  pip install --pre awscli boto botocore requests s3cmd && \
  apk --purge -v del py-pip && \
  rm /var/cache/apk/*

WORKDIR /aws

ENTRYPOINT ["aws"]
