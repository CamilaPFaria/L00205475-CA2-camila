mock "tfplan/v2" {
  data = {
    resource_changes = [
      {
        type = "aws_ebs_volume"
        change = {
          after = {
            encrypted = false
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