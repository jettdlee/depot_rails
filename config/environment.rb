# Load the Rails application.
require_relative 'application'

Rails.application.configure do
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        address: "jlee@yozu.co.uk",
        port: 587,
        authentication: "plain",
        user_name: "test",
        password: "test1",
        enable_starttle_auto: true
    }

end



# Initialize the Rails application.
Rails.application.initialize!
