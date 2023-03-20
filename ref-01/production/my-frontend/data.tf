data "aws_iam_role" "amplify_role" {
  name = "amplify_iam_role_policy"
}

output "amplify_role" {
  value = data.aws_iam_role.amplify_role
}
