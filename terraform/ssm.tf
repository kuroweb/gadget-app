####################
# SSMパラメータストア #
####################
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "DB_HOST" {}
variable "DB_NAME" {}
variable "DB_USERNAME" {}
variable "DB_PASSWORD" {}
variable "S3_REGION" {}
variable "S3_BUCKET" {}
variable "API_BASE_URL" {}
variable "BROWSER_BASE_URL" {}
variable "API_KEY" {}
variable "AUTH_DOMAIN" {}
variable "DATABASE_URL" {}
variable "PROJECT_ID" {}
variable "STORAGE_BUCKET" {}
variable "MESSAGE_SENDER_ID" {}
variable "GITHUB_TOKEN" {}
variable "GITHUB_USER" {}
variable "GITHUB_REPO" {}
variable "GITHUB_BRANCH" {}
variable "WEBHOOK_TOKEN" {}
variable "AWS_DEFAULT_REGION" {}
variable "AWS_ACCOUNT_ID" {}
variable "API_IMAGE" {}
variable "API_IMAGE_TAG" {}
variable "FRONT_IMAGE" {}
variable "FRONT_IMAGE_TAG" {}

#__________ 共通 __________#
resource "aws_ssm_parameter" "access-key-id" {
  name = "access-key-id"
  value = var.AWS_ACCESS_KEY_ID
  type = "SecureString"
  description = "AWS_ACCESS_KEY_ID"
}
resource "aws_ssm_parameter" "secret-access-key" {
  name = "secret-access-key"
  value = var.AWS_SECRET_ACCESS_KEY
  type = "SecureString"
  description = "AWS_SECRET_ACCESS_KEY"
}

#__________ API __________#
resource "aws_ssm_parameter" "db-host" {
  name = "db-host"
  value = var.DB_HOST
  type = "SecureString"
  description = "DB_HOST"
}
resource "aws_ssm_parameter" "db-name" {
  name = "db-name"
  value = var.DB_NAME
  type = "SecureString"
  description = "DB_NAME"
}
resource "aws_ssm_parameter" "db-username" {
  name = "db-username"
  value = var.DB_USERNAME
  type = "SecureString"
  description = "DB_USERNAME"
}
resource "aws_ssm_parameter" "db-password" {
  name = "db-password"
  value = var.DB_PASSWORD
  type = "SecureString"
  description = "DB_PASSWORD"
}
resource "aws_ssm_parameter" "s3-region" {
  name = "s3-region"
  value = var.S3_REGION
  type = "SecureString"
  description = "S3_REGION"
}
resource "aws_ssm_parameter" "s3-bucket" {
  name = "s3-bucket"
  value = var.S3_BUCKET
  type = "SecureString"
  description = "S3_BUCKET"
}

#__________ FRONT __________#
resource "aws_ssm_parameter" "api-base-url" {
  name = "api-base-url"
  value = var.API_BASE_URL
  type = "SecureString"
  description = "API_BASE_URL"
}
resource "aws_ssm_parameter" "browser-base-url" {
  name = "browser-base-url"
  value = var.BROWSER_BASE_URL
  type = "SecureString"
  description = "BROWSER_BASE_URL"
}
resource "aws_ssm_parameter" "api-key" {
  name = "api-key"
  value = var.API_KEY
  type = "SecureString"
  description = "API_KEY"
}
resource "aws_ssm_parameter" "auth-domain" {
  name = "auth-domain"
  value = var.AUTH_DOMAIN
  type = "SecureString"
  description = "AUTH_DOMAIN"
}
resource "aws_ssm_parameter" "database-url" {
  name = "database-url"
  value = var.DATABASE_URL
  type = "SecureString"
  description = "DATABASE_URL"
}
resource "aws_ssm_parameter" "project-id" {
  name = "project-id"
  value = var.PROJECT_ID
  type = "SecureString"
  description = "PROJECT_ID"
}
resource "aws_ssm_parameter" "storage-bucket" {
  name = "storage-bucket"
  value = var.STORAGE_BUCKET
  type = "SecureString"
  description = "STORAGE_BUCKET"
}
resource "aws_ssm_parameter" "message-sender-id" {
  name = "message-sender-id"
  value = var.MESSAGE_SENDER_ID
  type = "SecureString"
  description = "MESSAGE_SENDER_ID"
}

#__________ CodePipeline _________#
resource "aws_ssm_parameter" "default-region" {
  name = "default-region"
  value = var.AWS_DEFAULT_REGION
  type = "SecureString"
  description = "AWS_DEFAULT_REGION"
}
resource "aws_ssm_parameter" "account-id" {
  name = "account-id"
  value = var.AWS_ACCOUNT_ID
  type = "SecureString"
  description = "AWS_ACCOUNT_ID"
}
resource "aws_ssm_parameter" "github-token" {
  name = "github-token"
  value = var.GITHUB_TOKEN
  type = "SecureString"
  description = "GITHUB_TOKEN"
}
resource "aws_ssm_parameter" "github-user" {
  name = "github-user"
  value = var.GITHUB_USER
  type = "SecureString"
  description = "GITHUB_USER"
}
resource "aws_ssm_parameter" "github-repo" {
  name = "github-repo"
  value = var.GITHUB_REPO
  type = "SecureString"
  description = "GITHUB_REPO"
}
resource "aws_ssm_parameter" "github-branch" {
  name = "github-branch"
  value = var.GITHUB_BRANCH
  type = "SecureString"
  description = "GITHUB_BRANCH"
}
resource "aws_ssm_parameter" "webhook-token" {
  name = "webhook-token"
  value = var.WEBHOOK_TOKEN
  type = "SecureString"
  description = "WEBHOOK_TOKEN"
}
resource "aws_ssm_parameter" "api-image" {
  name = "api-image"
  value = var.API_IMAGE
  type = "SecureString"
  description = "API_IMAGE"
}
resource "aws_ssm_parameter" "api-image-tag" {
  name = "api-image-tag"
  value = var.API_IMAGE_TAG
  type = "SecureString"
  description = "API_IMAGE_TAG"
}
resource "aws_ssm_parameter" "front-image" {
  name = "front-image"
  value = var.FRONT_IMAGE
  type = "SecureString"
  description = "FRONT_IMAGE"
}
resource "aws_ssm_parameter" "front-image-tag" {
  name = "front-image-tag"
  value = var.FRONT_IMAGE_TAG
  type = "SecureString"
  description = "FRONT_IMAGE_TAG"
}