# Testing Terraform responses to pauses

As I initially reported in https://github.com/hashicorp/terraform/issues/19557, I was experiencing issues where Terraform
would stop returning any stdout responses from the remote server. I identified a potential cause that the remote process
was not returning anything to `stdout`, therefore causing the remote process to stop responding. This is a simple Terraform
project that I created to test that theory.

# Required parameters

* `aws_access_key`
* `aws_secret_key`
* `user_name`

If no private/public key data is provided to terraform (i.e. by default), the key will be pulled from `~/.ssh/id_rsa*`
