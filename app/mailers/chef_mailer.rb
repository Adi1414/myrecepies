class ChefMailer < ApplicationMailer

default from: "from@example.com"

  def sample_email(chef)
    @chef = chef
    mail(to: @chef.email, subject: 'Sample Email')
  end

  def forgot_password(chef)
	  @chef = chef
	  
	  mail(to: chef.email, subject: 'Reset password instructions')
  end
end
