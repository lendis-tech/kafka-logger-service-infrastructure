locals {
  tags = {
    Terraform   = "true"
    Environment = var.environment
    Owner       = "Lendis"
    Group       = "kafka-logger-service"
  }
}

locals {
  account_id = var.environment == "staging2" ? "753081957624" : var.environment == "development" ? "710196519714" : "918914055277"
  inline_policies = [{
    name = "allow-write-logs"
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Resource" : [
            "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current_identity.account_id}:log-group:*",
            "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current_identity.account_id}:log-group:*:*"
          ],
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams"
          ]
        }
      ]
    })
  }]
}
