# Setup AWS Region
variable "AWS_REGION" {
  default = "us-east-1" //N.Virginia
}

# Setup Default Instance Type
variable "TFC_INSTANCE_TYPE" {
  default = "t2.micro"
}

# Setup VPC CIDR Prefix
variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

# Setup CIDR Prefix in Use 
variable "vpc_cidr_prefix" {
  default = "10.1."
}

# Setup Availability Zones 
variable "av_zones" {
  default = ["a", "b", "c"]
}

# Setup Default Route
variable "default_route" {
  type        = string
  description = "Default Route from and to internet"
  default     = "0.0.0.0/0"
}


# Setup already Created Fre Launch Template
variable "tfc_app_launch_script" {
  default = <<EOF
  #!/bin/bash
  cd /home/ubuntu/frontend
  sudo -u ubuntu pm2 serve build 3000 --spa --name AppFrontend
  sudo -u ubuntu pm2 save 
  EOF
}

# Setup already Created Bke Launch Template
variable "tfc_bke_launch_script" {
  default = ""
}
# APP AMI ID
variable "tfc_app_ami" {
  default = "ami-0f2c126811ca75d0c"
}

# BKE AMI ID
variable "tfc_bke_ami" {
  default = "ami-037f342acee5b762d"
}

# DB PASSWORD
variable  "db_password" {
  default = "Gaby1997!"
}