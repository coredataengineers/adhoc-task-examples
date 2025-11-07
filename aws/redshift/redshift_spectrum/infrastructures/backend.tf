terraform {
  backend "s3" {
    bucket       = "cde-state-file"
    key          = "dev/dev.tfstate"
    use_lockfile = true
    region       = "eu-north-1"
  }
}
