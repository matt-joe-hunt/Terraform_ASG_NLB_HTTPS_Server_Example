output "sg-id" {
    value = aws_security_group.asg_sg.id
    description = "Id of the Security Group created in this module for the ASG"
}