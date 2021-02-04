output "vpc-id" {
    value = aws_vpc.vpc.id
}

output "subnet-ids" {
  value = aws_subnet.public-subnet.*.id
}