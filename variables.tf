##################################################################################
# VARIABLES
##################################################################################

variable "aws_access_key" {
  description = "AWS Access Key"
}
variable "aws_secret_key" {
  description = "AWS Secret Key"
}

variable "private_key_path" {
  description = "Path to the private key used to SSH into the EC2 instance"
}

variable "key_name" {
  description = "Key Pair to be used to for the EC2 instance"
}