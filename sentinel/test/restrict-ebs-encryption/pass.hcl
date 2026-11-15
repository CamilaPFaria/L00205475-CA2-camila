mock "tfplan/v2" {
  data = {
    resource_changes = [
      {
        type = "aws_ebs_volume"
        change = {
          after = {
            encrypted = true
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