resource "aws_amplify_app" "mp_amazon" {
  name                     = "my-frontend"
  repository               = "https://github.com/Foo/repository"
  platform                 = "WEB_COMPUTE"
  access_token             = var.github_access_token
  iam_service_role_arn     = data.aws_iam_role.amplify_role.arn
  enable_branch_auto_build = true

  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - yarn install
        build:
          commands:
            - yarn run build
      artifacts:
        baseDirectory: .next
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT
}

resource "aws_amplify_branch" "main_branch" {
  app_id      = aws_amplify_app.mp_amazon.id
  branch_name = "main"

  framework = "Next.js - SSR"
  stage     = "PRODUCTION"

  enable_auto_build = true

  #   environment_variables = {
  #     NEXT_APP_API_SERVER = "https://api.example.com"
  #   }
}

resource "aws_amplify_domain_association" "my_domain" {
  app_id      = aws_amplify_app.mp_amazon.id
  domain_name = "domain.com"

  # https://subdomain.domain.com
  sub_domain {
    branch_name = aws_amplify_branch.main_branch.branch_name
    prefix      = "subdomain"
  }
}
