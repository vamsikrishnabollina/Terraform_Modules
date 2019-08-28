variable "aws_region" {
  default = "us-west-2"
}

#variable "public_key_path" {
#  description = "Enter the path to the SSH Public Key to add to AWS."
#  default = "/Users/smallidi/Downloads/bastion-common-keydevops.pem"
#}

variable "key_name" {
  description = "Key name for SSHing into EC2"
  default = "service_studio_keypair_test"
}

variable "aws_alb_name" {
  default = "jenkins-ss"
}

variable "load_balancer_internal" {
  default     = true
}

variable "subnets" {
  type        = "list"
  default     = ["subnet-060db3623bc0e8125","subnet-079ded6c6c785cac5"]
}

#variable "security_groups" {
 # type        = "list"
  #default     = ["sg-973f13e9"]
#}

variable "idle_timeout" {
  default     = 200
}

variable "alb_target_group_name" {
  default = "jenkins-ss"
}

variable "alb_target_group_count" {
  default = 1
}

variable "alb_target_group_port" {
  default = "80"
}

variable "alb_target_group_protocol" {
  default = "HTTP"
}

#variable "vpc_id" {
 # default = "vpc-bfe8c9c6"
#}


variable "key" {
  default = "Jenkins_SS"
}

variable "alb_listener_count" {
 default = 1
}



#variable "target_group_type" {
#  default = "forward"
#}

variable "target_group_attachment_port" {
  default = "8080"
}

variable "aws_instance_ami" {
  default = "ami-01ed306a12b7d1c96"
}

variable "aws_instance_instance_type" {
  default = "t2.xlarge"
}


variable "associate_public_ip_address" {
  default = false
}

variable "aws_instance_monitoring" {
  default = true
}

variable "aws_instance_subnet_id" {
  default = "subnet-0113442f71f43f1fd"
}

variable "aws_instance_vpc_security_group_id" {
  type = "list"
  default = ["sg-0efa4804f6d6c9f75"]
}

variable "aws_instance_iam_instance_profile" {
  default = "EC2_Jenkins"
}

variable "aws_instance_volume_size" {
 default = 100
}

variable "aws_instance_volume_type" {
 default = "gp2"
}

variable "delete_on_termination" {
 default = false
}

variable "aws_instance_tags" {
  default = "jenkins-ss"
}

#variable "aws_instance_owner" {
#  default = "ownername"
#}

variable "aws_instance_label" {
  default = "jenkins-ss"
}

variable "vpc_id" {
   default = "vpc-044324579b704af59"
}

variable "aws_security_group_name" {
   default = "SG-JenkinsSS-internal"
}

variable "security_group_description" {
  default = "creating security group"
}

variable "ingress_from_port1" {
  default = "80"
}

variable "ingress_to_port1" {
  default = "80"
}
variable "protocol" {
 default = "tcp"
}

variable "tags_RWC" {
  default = "RWC"
}
variable "route53_zone_id" {
  default = "Z2XX60WS0NVLLK"
}

variable "route53_name" {
  default = "dummy"
}
