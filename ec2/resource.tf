resource "aws_instance" "public-instance-1" {
 ami           = var.ami_id
 instance_type = var.instance_type
 associate_public_ip_address = true
 subnet_id = var.publicsubnet1-id
 vpc_security_group_ids = [var.securitygroupid]
 key_name = "key"
 tags = {
    Name = "public-instance1"
  }
 provisioner "local-exec" {
  when = create
   command = "echo public_ip1  ${self.public_ip} >> ./ip.txt"
 }
 provisioner "remote-exec" {
    inline = var.provisioner_data
     connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("./ec2/key.pem")
      host = self.public_ip
    }
  }
}

resource "aws_instance" "public-instance-2" {
 ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = var.publicsubnet2-id
  vpc_security_group_ids = [var.securitygroupid]
  key_name = "key"
  tags = {
    Name = "public-instance2"
  }
  provisioner "local-exec" {
    when = create
   command = "echo public_ip2  ${self.public_ip} >> ./ip.txt"
 }
 connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("./ec2/key.pem")
      host = self.public_ip
    }

 provisioner "remote-exec" {
    inline =  var.provisioner_data 
  }
}

resource "aws_instance" "private-instance1" {
 ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address = false
  subnet_id = var.privatesubnet1-id
  vpc_security_group_ids = [var.securitygroupid]
  tags = {
    Name = "private-instance1"
  }
  
  user_data = file("ec2/nginx.sh")

}

resource "aws_instance" "private-instance2" {
 ami           = var.ami_id
  instance_type = var.instance_type
  associate_public_ip_address = false
  subnet_id = var.privatesubnet2-id
  vpc_security_group_ids = [var.securitygroupid]
  tags = {
    Name = "private-instance2"
  }
  
  user_data = file("ec2/nginx.sh")
}