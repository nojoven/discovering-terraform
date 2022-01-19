resource "aws_autoscaling_group" "web-server" {
  name     = "nginx-asg"
  max_size = 5
  min_size = 2
  # health_check_grace_period = 300
  # health_check_type         = "ELB"
  desired_capacity = 4
  force_delete     = true
  # placement_group           = aws_placement_group.test.id
  launch_configuration = aws_launch_configuration.web-server-launch-config.name
  vpc_zone_identifier  = ["subnet-09295117ef889629f", "subnet-0a79828d3a728148e"]

  tag {
    key                 = "Name"
    value               = "Ngnix-web-server-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      load_balancers, target_group_arns
    ]
  }
}


resource "aws_launch_configuration" "web-server-launch-config" {
  name          = "web_config"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data     = <<-EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install nginx -y
sudo service nginx start
EOF
}