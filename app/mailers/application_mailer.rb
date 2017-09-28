class ApplicationMailer < ActionMailer::Base
  default from: ActionMailer::Base.smtp_settings[:from]
  layout 'mailer'
end
