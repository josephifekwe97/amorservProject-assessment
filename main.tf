provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = <<-EOT
      ssh -o StrictHostKeyChecking=no ec2-user@${self.public_ip} \
        'docker pull my-web-app:${BUILD_NUMBER} && docker run -d -p 3000:3000 my-web-app:${BUILD_NUMBER}'
    EOT
  }
}
