resource "aws_iam_role" "github_actions_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.github_assume_role_policy.json
}

locals {
  policy_names = [
    "AmazonEC2FullAccess",
    "AmazonRoute53FullAccess",
    "AmazonS3FullAccess",
    "IAMFullAccess",
    "AmazonVPCFullAccess",
    "AmazonSQSFullAccess",
    "AmazonEventBridgeFullAccess"
  ]
}

resource "aws_iam_role_policy_attachment" "github_actions_policies" {
  for_each   = toset(local.policy_names)
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}
