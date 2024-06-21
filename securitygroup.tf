resource "aws_security_group" "eks_control_plane_sg" {
  name        = "eks_control_plane_sg"
  description = "Security group for Amazon EKS control plane"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [
            "10.0.0.0/8", 
            "10.0.0.0/16",
            "10.0.0.0/24",
            "192.168.0.0/24"
        ]
      },
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [
            "10.0.0.0/8", 
            "10.0.0.0/16",
            "10.0.0.0/24",
            "192.168.0.0/24"
        ]
      },
      {
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        cidr_blocks = [
            "10.0.0.0/8", 
            "10.0.0.0/16",
            "10.0.0.0/24",
            "192.168.0.0/24"
        ]
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "eks_control_plane_sg"
  }
}
