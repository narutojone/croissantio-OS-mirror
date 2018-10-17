class ExpMailer < ActionMailer::Base
  default from: "app30093560@heroku.com"

  def sample_email(body)
    @body = body
    mail(to: 'maxime@croissant.io', subject: 'Experiment Request')
  end
end