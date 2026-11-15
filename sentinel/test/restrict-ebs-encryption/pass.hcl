mock "tfplan/v2" {
  data = {
    resource_changes = [
      {
        address = "aws_ebs_volume.database",
        type    = "aws_ebs_volume",
        mode    = "managed",
        change  = {
          actions = ["create"],
          after   = {
            encrypted = true,
            size      = 20
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