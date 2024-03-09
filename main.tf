provider "aws" {
  region = "us-east-1" # Change to your desired region
}

resource "aws_key_pair" "example_keypair" {
  key_name   = "example-keypair"
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key file
}

resource "aws_instance" "web" {
  ami           = "ami-07d9b9ddc6cd8dd30" # Change to desired AMI
  instance_type = "t2.micro"
  tags = {
    Name = "web-server"
  }

  key_name = aws_key_pair.example_keypair.key_name  # Associate the EC2 instance with the key pair

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo ufw allow 3000",
      "sudo ufw allow 22",
      "sudo apt install docker.io -y",
      "sudo systemctl start docker",
      "sudo usermod -a -G docker $USER",
      "sudo systemctl enable docker",
      "sudo docker pull josephifekwe97/my-web-app",
      "sudo docker pull josephifekwe97/new-node-app3 ",
      "sudo docker run -d -p 3000:3000 --name ci-cd-web-app josephifekwe97/new-node-app3 "
      
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")  # Path to your private key file
      host        = self.public_ip         # Use the public IP of the instance
    }
  }
}

resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Allow HTTP traffic"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}



# Adding Docker configuration file
# resource "aws_s3_bucket_object" "docker_config" {
#   bucket = "DockerCRED-00023"
#   key    = "config.json"
#   source = file("~/.docker/config.json")
#   etag   = filemd5("~/.docker/config.json")
# }


