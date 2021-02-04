resource "aws_launch_template" "template" {
  name_prefix   = "template"
  image_id      = data.aws_ssm_parameter.linuxAmi.value
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.sg-id]
  user_data = filebase64("${path.module}/scripts/setup.sh")

  iam_instance_profile {
    name = var.instance-profile-name
  }
}

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.subnet-ids
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}