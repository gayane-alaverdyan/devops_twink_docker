provider "aws" {
  region = "eu-central-1"
}
resource "aws_instance" "g_instance" {
   ami                    = "ami-0d359437d1756caa8"
   instance_type          = "t2.micro"
   vpc_security_group_ids = ["${aws_security_group.ec2-security-group.id}"]
   key_name = "test-key"
   user_data =file("install_docker.sh")
   tags = {
      Name = "docker_ec2"

   }
}

resource "aws_security_group" "ec2-security-group" {
  name   = "docker_ec2-security-group"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#terraform destroy -target aws_instance.g_instance
