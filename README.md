# TF Demo for Red Canary
The demo I chose from nginx's demo portion of their repo is: https://github.com/nginxinc/NGINX-Demos/tree/master/nginx-hello


# How to deploy infrastructure

## Setup remote state
* Go to tf > modules> remote-state directory and `terraform init`
* Do a `terraform apply` to create your S3 bucket and DynamoDB state lock.
* Go to `tf > service > nginx > base.tf` and make sure that the terraform backend configuration matches the bucket, key and DynamoDB table you setup in the remote state directory.

## Deploy Ngnix Solution
* Run a `terraform apply` from `tf > service > nginx`.

## Cleanup
* Don't forget to destroy all of your resources! Nobody likes the surprise AWS bill.
* Run a `terraform destory` in the same directories that applied.
  * First in `tf > service > nginx`.
  * Then, `tf > remote-state`.