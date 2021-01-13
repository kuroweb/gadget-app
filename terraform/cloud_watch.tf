#################
# CloudWatchLog #
#################
resource "aws_cloudwatch_log_group" "gadget-ecs-api" {
  name              = "/ecs/api"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "gadget-ecs-front" {
  name              = "/ecs/front"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "gadget-ecs-db-create" {
  name              = "/ecs/db-create"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "gadget-ecs-db-migrate" {
  name              = "/ecs/db-migrate"
  retention_in_days = 180
}
resource "aws_cloudwatch_log_group" "gadget-ecs-db-migrate-reset" {
  name              = "/ecs/db-migrate-reset"
  retention_in_days = 180
}