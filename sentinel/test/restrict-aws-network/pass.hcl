mock "tfplan/v2" {
  data = {
    resources = {
      aws_security_group = {
        web_sg = {
          name = "web-tier-sg"
          change = {
            after = {
              name = "web-tier-sg"
              ingress = [
                {
                  from_port   = 80
                  to_port     = 80
                  protocol    = "tcp"
                  cidr_blocks = ["0.0.0.0/0"]
                },
                {
                  from_port   = 22
                  to_port     = 22
                  protocol    = "tcp"
                  cidr_blocks = ["109.255.0.1/32"]
                }
              ]
            }
          }
        }
      }
    }
  }
}

test {
  rules = {
    main = true
  }
}