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
        },
        db_sg = {
          name = "db-tier-sg"
          change = {
            after = {
              name = "db-tier-sg"
              ingress = [
                {
                  from_port   = 5432
                  to_port     = 5432
                  protocol    = "tcp"
                  cidr_blocks = []
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