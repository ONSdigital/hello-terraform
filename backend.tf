terraform {
  backend "s3" {
    bucket = "igt0uj-terraform-state"
    key = "project-name/terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "igt0uj-terraform-locks"
    encrypt = true
  }
}