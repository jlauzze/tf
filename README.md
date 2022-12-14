# TF Demo for Red Canary
The demo I chose from nginx's demo portion of their repo is: https://github.com/nginxinc/NGINX-Demos/tree/master/nginx-hello


# How to deploy infrastructure

## Setup remote state
* Go to tf > modules> remote-state directory and `terraform init`
* Do a `terraform apply` to create your S3 bucket and DynamoDB state lock.
* Go to `tf > service > nginx > base.tf` and make sure that the terraform backend configuration matches the bucket, key and DynamoDB table you setup in the remote state directory.

## Deploy Ngnix Solution
* Add your public IP cidr range to the ingress rule in `tf > service > nginx > sg.tf`
* Run a `terraform apply` from `tf > service > nginx`.

## Scale up Horizontally
* If you should want to reconfigure the scale of the number of instances in the ASG/Target group, modify the map variable in `tf > service > nginx > variables.tf`

````
variable "group_size" {
  description = "ASG sizing per env"
  type        = map(number)
  default = {
      min_size         = 1,
      max_size         = 3,
      desired_capacity = 2
  }
}
````

## Cleanup
* Don't forget to destroy all of your resources! Nobody likes the surprise AWS bill.
* Run a `terraform destory` in the same directories that applied.
  * First in `tf > service > nginx`.
  * Then, `tf > remote-state`.