# Mock data representing a valid EC2 instance configuration
mock "tfplan/v2" {
  data = {
    resource_changes = [
      {
        address = "aws_instance.web",
        type    = "aws_instance",
        mode    = "managed",
        change  = {
          actions = ["create"],
          after   = {
            instance_type = "t3.micro",
            metadata_options = [
              {
                http_tokens = "required",
                http_endpoint = "enabled"
              }
            ]
          }
        }
      }
    ]
  }
}

# Asserts that the main rule evaluates to true
test {
  rules = {
    main = true
  }
}