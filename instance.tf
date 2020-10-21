resource "aws_security_group" "StandartServer" {
  name   = "SSH/HTTP/HTTPS"
  vpc_id = aws_vpc.main.id

  ingress {
    description = "HTTP from World"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from World"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from World"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http/https/ssh"
  }

}


resource "aws_instance" "Server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  count                  = 1
  vpc_security_group_ids = [aws_security_group.StandartServer.id]
  key_name               = "Frankfurt-AWS"
  subnet_id              = "${aws_subnet.public_subnets.id}"
  user_data              = file("user_data.sh")
  tags = {
    Name = "${var.env}-Server"
  }
}