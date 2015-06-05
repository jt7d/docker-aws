# docker-aws
Docker image for AWS tools

AWS CLI plus Python libraries boto, botocore, and requests.

For CLI do:

    docker run jt7d/aws ec2 --region us-east-1 describe-regions

(the instance you are running on must have the necessary IAM permissions).  If you need to pass in credentials, this might be one way to do so:

    docker run --env AWS_DEFAULT_REGION=us-east-t --env AWS_ACCESS_KEY_ID=AKIA... --env AWS_SECRET_ACCESS_KEY=... jt7d/aws ec2 describe-regions

For simple Python AWS scripts, you might use this as a base container.  Using Requests, you can access instance meta-data thus:

    import requests
    instance-id = requests.get("http://169.254.169.254/latest/meta-data/instance-id").content

In a CoreOS unit file, you might include lines like this around a web app:

    ExecStartPost=/usr/bin/docker run jt7d/aws --region us-east-1 elb register-instances-with-load-balancer --load-balancer-name ${ELB_NAME} --instances ${INSTANCE_ID}

    ExecStop=/usr/bin/docker run jt7d/aws --region us-east-1 elb deregister-instances-from-load-balancer --load-balancer-name ${ELB_NAME} --instances ${INSTANCE_ID}
