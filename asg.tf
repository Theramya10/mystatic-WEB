resource "aws_launch_template" "web" {
  name_prefix   = "web-template"
  image_id      = "ami-12345678"
  instance_type = "t2.large"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.allow_all.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              aws s3 cp s3://my-static-website/index.html /var/www/html/index.html
              systemctl restart httpd
              EOF
  )
}

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier  = [aws_subnet.public_subnet.id]
  desired_capacity     = 2
  min_size            = 1
  max_size            = 3
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
}
