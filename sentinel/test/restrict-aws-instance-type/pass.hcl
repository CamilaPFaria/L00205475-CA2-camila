#Example of test from tutorial: https://developer.hashicorp.com/terraform/tutorials/policy/sentinel-testing
mock "tfplan/v2" {
  data = {
    resource_changes = [
      {
        type="aws_instance"
        mode="managed"
        change = {
          actions = ["create"]
          after = {
            instance_type = "t3.micro" 
            metadata_options = [
              {
                http_tokens = "required" #it is not allowed to use optional for http_tokens, only required is allowed
              }
            ]  
          }
        }
      }
    ]
  }
}

test {
  rules = {
    main = true
  }
}