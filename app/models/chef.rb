class Chef < ApplicationRecord
has_many :messages, dependent: :destroy
has_many :recipes, dependent: :destroy
 validates :chefname , presence: true, length: {maximum: 30}
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
 validates :email, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX}
before_save {self.email = email.downcase}
has_secure_password
validates :password, presence: true, length: {minimum: 5} , allow_nil: true
has_many :comments
has_many :likes, dependent: :destroy

before_create :confirmation_token

def email_activate
    self.confirmed = true
    self.confirm_code = nil
    save!(:validate => false)
end


def send_password_reset
  generate_token(:reset_password_token)
  self.reset_password_sent_at = Time.zone.now
  save!
   ChefMailer.forgot_password(self).deliver_now# This sends an e-mail with a link for the user to reset the password
end
# This generates a random password reset token for the user
def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while Chef.exists?(column => self[column])
end

private
def confirmation_token
    if self.confirm_code.blank?
       self.confirm_code = SecureRandom.urlsafe_base64.to_s
    end
end



end