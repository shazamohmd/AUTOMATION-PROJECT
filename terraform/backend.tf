terraform {
  backend "s3" {
    bucket = "state0bucket"
    key    = "statefile"
    region = "us-east-1"
  }
}