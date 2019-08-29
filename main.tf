provider "abc" {
  region = "${var.aws_region}"
}
terraform {
backend "s3" {
encrypt = true
bucket = "jenkins-state"
region = "us-west-2"
key = "terraform.tfstate"
##dynamodb_table = "terraform-state-lock-dynamo-np"
 }
}

resource "aws_alb" "jenkins_alb" {
  name            = "${var.aws_alb_name}"
  internal        = "${var.load_balancer_internal}"
  security_groups = "${var.aws_instance_vpc_security_group_id}"
  subnets         = "${var.subnets}"
  idle_timeout    = "${var.idle_timeout}"
tags {
  name = "${var.key}"
  }
lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route53_record" "route" {
  zone_id = "${var.route53_zone_id}"
  name    = "jenkins.test.west2"
  type    = "A"

  alias {
    name                   = "${aws_alb.jenkins_alb.dns_name}"
    zone_id                = "${aws_alb.jenkins_alb.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_alb_target_group" "alb" {
  count     = "${var.alb_target_group_count}"
  name      = "${var.alb_target_group_name}"
  port      = "${var.alb_target_group_port}"
  protocol  = "${var.alb_target_group_protocol}"
  vpc_id    = "${var.vpc_id}"
tags {
  name = "${var.key}"
  }
lifecycle {
    create_before_destroy = true
  }
}


resource "aws_alb_target_group_attachment" "alb" {
  target_group_arn = "${aws_alb_target_group.alb.arn}"
  target_id        = "${aws_instance.web.id}"
  port             = "${var.target_group_attachment_port}"
lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.jenkins_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.alb.arn}"
  }
}
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.key.public_key_openssh}"
}
resource "aws_instance" "web" {
  ami           = "${var.aws_instance_ami}"
  instance_type = "${var.aws_instance_instance_type}"
  key_name      = "${aws_key_pair.generated_key.key_name}"
  vpc_security_group_ids = "${var.aws_instance_vpc_security_group_id}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
#  disable_api_termination = "true"
#  instance_initiated_shutdown_behavior = "stop"
  monitoring    = "${var.aws_instance_monitoring}"
  subnet_id     = "${var.aws_instance_subnet_id}"
  iam_instance_profile  = "${var.aws_instance_iam_instance_profile}"
  user_data = "${file("userdata.sh")}"
  root_block_device {
  volume_size = "${var.aws_instance_volume_size}"
  volume_type = "${var.aws_instance_volume_type}"
  delete_on_termination = "${var.delete_on_termination}"
  }
 tags {
    Name = "${var.aws_instance_tags}"
#    Owner = "${var.aws_instance_owner}"
    Label = "${var.aws_instance_label}"
  }
lifecycle {
    create_before_destroy = true
  }
}
