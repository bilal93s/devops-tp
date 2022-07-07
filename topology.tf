resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }
}

resource "aws_subnet" "my_subnet" {
  cidr_block        = "10.0.93.0/24"
  availability_zone = "eu-west-1a"
  vpc_id            = aws_vpc.my_vpc.id


  tags = {
    Name = "belatoui.bilal"
    User = "belatoui.bilal"
    TP   = "TP2"
  }
}

resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_security_group" "my_security_group" {
  name_prefix = "belatoui.bilal"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "belatoui.bilal"
    User = "belatoui.bilal"
    TP   = "TP2"
  }
}

resource "aws_security_group_rule" "my_security_group_rule_out_http" {
  type              = "egress"
  to_port           = 80
  protocol          = "tcp"
  from_port         = 80
  security_group_id = aws_security_group.my_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "my_security_group_rule_out_https" {
  type              = "egress"
  to_port           = 443
  protocol          = "tcp"
  from_port         = 443
  security_group_id = aws_security_group.my_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "my_security_group_rule_http_in" {
  type              = "ingress"
  to_port           = 80
  protocol          = "tcp"
  from_port         = 80
  security_group_id = aws_security_group.my_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "web" {
  ami                         = "ami-02297540444991cc0"
  subnet_id                   = aws_subnet.my_subnet.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["sg-0f372fb30a584ea05"]
  associate_public_ip_address = true

  tags = {
    Name = "belatoui.bilal"
    User = "belatoui.bilal"
    TP   = "TP2"
  }
}