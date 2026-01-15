provider "aws" {
    region = "ap-south-1"
    access_key = ""
    secret_key = ""

}

resource "aws_instance" "ec2" {
    ami = "ami-02b8269d5e85954ef"
    instance_type = "t2.micro"
    security_groups = ["default"]
    key_name = "new-key"
    root_block_device {
        volume_size = 15
        volume_type = "gp3"
        delete_on_termination = "true"
    }
    tags = {
        name = "demo_server_terraform"
    }
}

output "PublicIp" {
  value = "aws_instance.ec2.public_ip"
}

