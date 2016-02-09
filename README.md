# docker-aws
Docker image for AWS tools

AWS CLI plus Python libraries boto, boto3, botocore, and requests.
Docker version tag corresponds to the AWS CLI version (1.10.2).

For CLI do:

    docker run jt7d/aws ec2 --region us-east-1 describe-regions

(the instance you are running on must have the necessary IAM permissions).  If you need to pass in credentials, this might be one way to do so:

    docker run --env AWS_DEFAULT_REGION=us-east-1 --env AWS_ACCESS_KEY_ID=AKIA... --env AWS_SECRET_ACCESS_KEY=... jt7d/aws ec2 describe-regions

To copy a logfile from the container host to s3 you could do something like this:

    docker run --rm --name=s3cp --volume=/var/log/directory/name:/tmp/logfiles \
      jt7d/aws s3 cp /tmp/logfiles/log-`date +%Y%m%d -d yesterday`  s3://mylogbucket/logs/docker

For simple Python AWS scripts, you might use this as a base container.  Using Requests, you can access instance meta-data thus:

    import requests
    instance-id = requests.get("http://169.254.169.254/latest/meta-data/instance-id").content

In a CoreOS unit file, you might include lines like this around a web app:

    ExecStartPost=/usr/bin/docker run jt7d/aws --region us-east-1 elb register-instances-with-load-balancer --load-balancer-name ${ELB_NAME} --instances ${INSTANCE_ID}

    ExecStop=/usr/bin/docker run jt7d/aws --region us-east-1 elb deregister-instances-from-load-balancer --load-balancer-name ${ELB_NAME} --instances ${INSTANCE_ID}
