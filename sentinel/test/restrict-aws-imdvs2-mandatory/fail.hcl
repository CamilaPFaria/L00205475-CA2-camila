# Mock data representing a non-compliant EC2 instance configuration
mock "tfplan/v2" {
  data = {
    resource_changes = [
      {
        address = "aws_instance.non_compliant_web",
        type    = "aws_instance",
        mode    = "managed",
        change  = {
          actions = ["create"],
          after   = {
            instance_type = "t3.micro",
            metadata_options = [
              {
                http_tokens = "optional"
              }
            ]
          }
        }
      }
    ]
  }
}

# Asserts that the main rule evaluates to false
test {
  rules = {
    main = false
  }
}