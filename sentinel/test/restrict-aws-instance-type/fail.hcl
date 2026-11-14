mock "tfplan/v2" {
  data = {
    resource_changes = [
      {
        type="aws_instance"
        mode="managed"
        change = {
          actions = ["create"]
          after = {
            instance_type = "t2.micro" #it is not allowed to use t2.micro instance type, only t3.micro is allowed
            metadata_options = [
              {
                http_tokens = "optional" #it is not allowed to use optional for http_tokens, only required is allowed
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
    main = false
  }
}