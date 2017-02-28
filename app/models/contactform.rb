class Contactform < MailForm::Base
 attribute :name, :validate => true
 attribute :company, :validate => true
 attribute :message, :validate => true
 attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
 attribute :phone, :validate => true
 attribute :budget, :validate => true
 attribute :services, :validate => true
 attribute :nickname, :captcha => true

  def headers
    {
    :subject => "Growthbakery Contactform",
    :to => "maxime@growthbakery.com",
    :from => %("#{name}"<#{email}>)
    }
  end
end
