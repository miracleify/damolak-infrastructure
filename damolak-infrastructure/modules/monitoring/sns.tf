resource "aws_sns_topic" "critical" {
  name = "${var.environment}-critical-alerts"
}

resource "aws_sns_topic" "general" {
  name = "${var.environment}-general-alerts"
}


resource "aws_sns_topic_subscription" "critical_email" {
  topic_arn = aws_sns_topic.critical.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_sns_topic_subscription" "general_email" {
  topic_arn = aws_sns_topic.general.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_lambda_function" "slack_notifier" {
  count = var.enable_slack ? 1 : 0

  filename         = "${path.module}/lambda/slack.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda/slack.zip")

  function_name = "${var.environment}-slack-alert"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  environment {
    variables = {
      SLACK_WEBHOOK_URL = var.slack_webhook_url
    }
  }
}


resource "aws_sns_topic_subscription" "critical_slack" {
  count     = var.enable_slack ? 1 : 0
  topic_arn = aws_sns_topic.critical.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.slack_notifier[0].arn
}


resource "aws_lambda_permission" "allow_sns" {
  count = var.enable_slack ? 1 : 0

  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.slack_notifier[0].function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.critical.arn
}