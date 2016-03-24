Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true

  config.paperclip_defaults = {
  	storage: :s3,
  	s3_region: ENV['AWS_REGION'],
  	s3_credentials: {
  	bucket: ENV['AWS_BUCKET_NAME'],
  	access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  	secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  	}
   }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { host: 'localhost:3000'}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: "587",
    domain: "gmail.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV['USER_NAME'],
    password: ENV['PASSWORD']
  }

end
