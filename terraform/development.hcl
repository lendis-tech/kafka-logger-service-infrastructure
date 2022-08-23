bucket         = "lendis-helm-chart-development-terraform-state-bucket"
key            = "kafka-logger-service-development/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "lendis-helm-chart-development-terraform-state-lock-table"