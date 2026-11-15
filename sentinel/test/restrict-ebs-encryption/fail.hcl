mock "tfplan/v2" {
  data = {
    resources = {
      aws_ebs_volume = {
        database_volume = {
          name = "db-volume"
          change = {
            after = {
              encrypted = false
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