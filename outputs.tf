##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
  value       = "${aws_instance.nginx.public_dns} for ${local.common_name_prefix}"
  description = "Public DNS of the NGINX EC2 instance"
}