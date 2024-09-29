resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [
    "A5E82B8D8E827B6395C24982B90E59B95E4B7D84",
  ]
}

