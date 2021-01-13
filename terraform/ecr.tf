#########
#  ECR  #
#########

#__________  api  __________#
resource "aws_ecr_repository" "gadget-api" {
  name = "gadget-api"
}
resource "aws_ecr_lifecycle_policy" "gadget-api-policy" {
  repository = aws_ecr_repository.gadget-api.name

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last 30 release tagged images",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["latest"],
          "countType": "imageCountMoreThan",
          "countNumber": 30
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
EOF
}

#__________ front __________#
resource "aws_ecr_repository" "gadget-front" {
  name = "gadget-front"
}
resource "aws_ecr_lifecycle_policy" "gadget-front-policy" {
  repository = aws_ecr_repository.gadget-front.name

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last 30 release tagged images",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["latest"],
          "countType": "imageCountMoreThan",
          "countNumber": 30
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
EOF
}