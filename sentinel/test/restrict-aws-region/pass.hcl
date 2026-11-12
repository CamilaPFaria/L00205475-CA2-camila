#Example of test from tutorial: https://developer.hashicorp.com/terraform/tutorials/policy/sentinel-testing
mock "tfplan/v2" {
  data = {
    resource_changes = [
      {
        change = {
          after = {
            region = "eu-west-1"
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