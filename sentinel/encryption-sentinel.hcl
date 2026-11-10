main = rule {
    all plan.resource_changes as _, rc {
        rc.values.encypted is true
        rc.change.after.region is "eu-west-1" or
        rc.change.after.region is "eu-central-1"
    }
}