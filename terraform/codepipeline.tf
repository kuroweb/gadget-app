# ################
# # CodePipeline #
# ################

# #__________ CoreBuild __________#
# data "aws_iam_policy_document" "codebuild" {
#   statement {
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "s3:PutObject",
#       "s3:GetObject",
#       "s3:GetObjectVersion",
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#       "ecr:GetAuthorizationToken",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:GetRepositoryPolicy",
#       "ecr:DescribeRepositories",
#       "ecr:ListImages",
#       "ecr:DescribeImages",
#       "ecr:BatchGetImage",
#       "ecr:InitiateLayerUpload",
#       "ecr:UploadLayerPart",
#       "ecr:CompleteLayerUpload",
#       "ecr:PutImage",
#       "ssm:GetParameters",
#       "kms:Decrypt"
#     ]
#   }
# }
# module "codebuild_role" {
#   source     = "./modules/iam_role"
#   name       = "codebuild"
#   identifier = "codebuild.amazonaws.com"
#   policy     = data.aws_iam_policy_document.codebuild.json
# }
# resource "aws_codebuild_project" "codebuild" {
#   name         = "codebuild"
#   service_role = module.codebuild_role.iam_role_arn

#   source {
#     type = "CODEPIPELINE"
#   }

#   artifacts {
#     type = "CODEPIPELINE"
#   }

#   environment {
#     type            = "LINUX_CONTAINER"
#     compute_type    = "BUILD_GENERAL1_SMALL"
#     image           = "aws/codebuild/standard:2.0"
#     privileged_mode = true
#   }
# }
# #__________ CodeTest ___________#
# resource "aws_codebuild_project" "codetest" {
#   name         = "codetest"
#   service_role = module.codebuild_role.iam_role_arn

#   source {
#     type = "CODEPIPELINE"
#     buildspec = "testspec.yml"
#   }

#   artifacts {
#     type = "CODEPIPELINE"
#   }

#   environment {
#     type            = "LINUX_CONTAINER"
#     compute_type    = "BUILD_GENERAL1_SMALL"
#     image           = "aws/codebuild/standard:5.0"
#     privileged_mode = true
#   }
# }

# #__________ CorePipeline __________#
# data "aws_iam_policy_document" "codepipeline" {
#   statement {
#     effect    = "Allow"
#     resources = ["*"]

#     actions = [
#       "s3:PutObject",
#       "s3:GetObject",
#       "s3:GetObjectVersion",
#       "s3:GetBucketVersioning",
#       "codebuild:BatchGetBuilds",
#       "codebuild:StartBuild",
#       "ecs:DescribeServices",
#       "ecs:DescribeTaskDefinition",
#       "ecs:DescribeTasks",
#       "ecs:ListTasks",
#       "ecs:RegisterTaskDefinition",
#       "ecs:UpdateService",
#       "iam:PassRole",
#     ]
#   }
# }
# module "codepipeline_role" {
#   source     = "./modules/iam_role"
#   name       = "codepipeline"
#   identifier = "codepipeline.amazonaws.com"
#   policy     = data.aws_iam_policy_document.codepipeline.json
# }
# resource "aws_codepipeline" "codepipeline" {
#   name     = "codepipeline"
#   role_arn = module.codepipeline_role.iam_role_arn

#   stage {
#     name = "Source"

#     action {
#       name             = "Source"
#       category         = "Source"
#       owner            = "ThirdParty"
#       provider         = "GitHub"
#       version          = 1
#       output_artifacts = ["Source"]

#       configuration = {
#         Owner                = var.GITHUB_USER
#         Repo                 = var.GITHUB_REPO
#         Branch               = var.GITHUB_BRANCH
#         PollForSourceChanges = false
#         OAuthToken           = var.GITHUB_TOKEN
#       }
#     }
#   }

#   stage {
#     name = "Test"

#     action {
#       name             = "Test"
#       category         = "Test"
#       owner            = "AWS"
#       provider         = "CodeBuild"
#       version          = 1
#       input_artifacts  = ["Source"]
#       output_artifacts = ["Test"]

#       configuration = {
#         ProjectName = aws_codebuild_project.codetest.id
#       }
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#       name             = "Build"
#       category         = "Build"
#       owner            = "AWS"
#       provider         = "CodeBuild"
#       version          = 1
#       input_artifacts  = ["Source"]
#       output_artifacts = ["Build"]

#       configuration = {
#         ProjectName = aws_codebuild_project.codebuild.id
#       }
#     }
#   }

#   stage {
#     name = "Deploy"

#     action {
#       name            = "Deploy-API"
#       category        = "Deploy"
#       owner           = "AWS"
#       provider        = "ECS"
#       version         = 1
#       input_artifacts = ["Build"]

#       configuration = {
#         ClusterName = aws_ecs_cluster.gadget-ecs-cluster.name
#         ServiceName = aws_ecs_service.gadget-api-ecs-service.name
#         FileName    = "api_imagedefinitions.json"
#       }
#     }
#     action {
#       name            = "Deploy-FRONT"
#       category        = "Deploy"
#       owner           = "AWS"
#       provider        = "ECS"
#       version         = 1
#       input_artifacts = ["Build"]

#       configuration = {
#         ClusterName = aws_ecs_cluster.gadget-ecs-cluster.name
#         ServiceName = aws_ecs_service.gadget-front-ecs-service.name
#         FileName    = "front_imagedefinitions.json"
#       }
#     }
#   }

#   artifact_store {
#     location = aws_s3_bucket.artifact.id
#     type     = "S3"
#   }
# }

# #__________ Webhook __________#
# resource "aws_codepipeline_webhook" "webhook" {
#   name            = "webhook"
#   target_pipeline = aws_codepipeline.codepipeline.name
#   target_action   = "Source"
#   authentication  = "GITHUB_HMAC"

#   authentication_configuration {
#     secret_token = var.WEBHOOK_TOKEN
#   }

#   filter {
#     json_path    = "$.ref"
#     match_equals = "refs/heads/{Branch}"
#   }
# }
# provider "github" {
#   organization = "kuromitsu0104"
#   token = var.GITHUB_TOKEN
# }
# resource "github_repository_webhook" "codepipeline" {
#   repository = "gadget-app"

#   configuration {
#     url          = aws_codepipeline_webhook.webhook.url
#     secret       = var.WEBHOOK_TOKEN
#     content_type = "json"
#     insecure_ssl = false
#   }

#   events = ["push"]
# }
