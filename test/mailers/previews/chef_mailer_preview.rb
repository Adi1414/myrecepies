# Preview all emails at http://localhost:3000/rails/mailers/chef_mailer
class ChefMailerPreview < ActionMailer::Preview
    
    def sample_mail_preview
      ChefMailer.sample_email(Chef.first)
    end

end
