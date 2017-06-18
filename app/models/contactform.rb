class Contactform < MailForm::Base
 attribute :name
 attribute :company
 attribute :message, validate: true
 attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
 attribute :phone
 attribute :url
 attribute :budget
 attribute :services
 attribute :nickname, captcha: true

  def headers
    {
    subject: "Growthbakery Contactform",
    to: "maxime@growthbakery.com",
    from: %("#{name}"<#{email}>)
    }
  end
end
