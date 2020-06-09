class ChefMailer < ApplicationMailer

default from: "from@example.com"

  def sample_email(chef)
    @chef = chef
    mail(to: @chef.email, subject: 'Sample Email')
  end

end
