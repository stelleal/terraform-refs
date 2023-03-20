resource "aws_amplify_app" "app_frontend" {
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
            - aws codeartifact login --tool npm --repository npm --domain my-domain --region us-east-1 --namespace @my-namespace
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

resource "aws_amplify_branch" "staging_branch" {
  app_id      = aws_amplify_app.app_frontend.id
  branch_name = "staging"

  framework = "Next.js - SSR"
  stage     = "DEVELOPMENT"

  enable_auto_build = true

  #   environment_variables = {
  #     NEXT_APP_API_SERVER = "https://api.example.com"
  #   }
}