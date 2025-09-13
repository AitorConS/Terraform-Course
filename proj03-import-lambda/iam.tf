import {
  to = aws_iam_role.lambda_execution_role
  id = "manually-created-lamda-role-s07m56x6"
}

import {
  to = aws_iam_policy.lambda_execution
  id = "arn:aws:iam::181179258370:policy/service-role/AWSLambdaBasicExecutionRole-7faa8c64-8449-41aa-9d6b-c35954799f97"
}

resource "aws_iam_policy" "lambda_execution" {
  name = "AWSLambdaBasicExecutionRole-7faa8c64-8449-41aa-9d6b-c35954799f97"
  path = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = "logs:CreateLogGroup"
      Effect   = "Allow"
      Resource = "arn:aws:logs:eu-west-1:181179258370:*"
      }, {
      Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["${aws_cloudwatch_log_group.lambda.arn}:*"]
    }]
    Version = "2012-10-17"
  })

}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution.arn
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  name = "manually-created-lamda-role-s07m56x6"
  path = "/service-role/"
}
