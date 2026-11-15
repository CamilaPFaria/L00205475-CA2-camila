mock "tfplan/v2" {
  data = {
    resources = {
      aws_instance = {
        web_server = {
          name = "web-server"
          change = {
            after = {
              ami           = "ami-0c55b159cbfafe1f0"
              instance_type = "t3.micro"
              root_block_device = [
                {
                  volume_size = 20
                  encrypted   = false
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
    main = false
  }
}