Rails.application.configure do
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.delivery_method = :file if Rails.env.development?
  config.action_mailer.delivery_method = :test if Rails.env.test?
  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "gmail.com",
    user_name:            ENV["GMAIL_USERNAME"],
    password:             ENV["GMAIL_PASSWORD"],
    authentication:       :plain,
    enable_starttls_auto: true
  }
end
