mock "tfplan/v2" {
  data = {
    resource_changes = [
      {
        change = {
          after = {
            region = "us-east-1"
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