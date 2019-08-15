A simple terraform project to be used along with instructions to setup Terraform and to test it

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_access\_key | AWS Access Key | string | n/a | yes |
| aws\_secret\_key | AWS Secret Key | string | n/a | yes |
| key\_name | Key Pair to be used to for the EC2 instance | string | n/a | yes |
| private\_key\_path | Path to the private key used to SSH into the EC2 instance | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_instance\_public\_dns | Public DNS of the NGINX EC2 instance |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->