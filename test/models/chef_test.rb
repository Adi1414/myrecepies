require 'test_helper'
class ChefTest < ActiveSupport::TestCase

def setup
 @chef = Chef.new(chefname: "Aditi", email: "aditi@gmail.com", password: "jewel", password_confirmation: "jewel")
end


test "should have valid chefname" do
      assert @chef.valid?
end

test "should have value in chefname" do
   @chef.chefname = ''
   assert_not @chef.valid?
end


test "name should be less than 30 chars" do
   @chef.chefname = "a"*31
   assert_not @chef.valid?
end


test "should have value in email" do
   @chef.email = ''
   assert_not @chef.valid?
end


test "email should not be too long" do
   @chef.email = "a"*245 + "@example.com"
   assert_not @chef.valid?
end

test "email should accept correct format" do
   valid_emails = %w[user@ex.com AF@yahoo.com M.First@yahoo.com jo+s@co.uk.org]
   valid_emails.each do |check|
   	   @chef.email = check
       assert @chef.valid?, "#{check.inspect} should be valid"
   end

end	

test "should reject invalid address" do
     invalid_emails = %w[m@example aD@ex,com ar.nam@gn. joe@bar+foo.com]
     invalid_emails.each do |check|
         @chef.email = check
         assert_not @chef.valid? , "#{check.inspect} should be invalid"
     
     end
end

test "should have unique email and case insentative" do
  duplicate_chef = @chef.dup
  duplicate_chef.email = @chef.email.upcase
  @chef.save
  assert_not duplicate_chef.valid?

end

test "email should be lowercase before hitting db" do
   mixed_email = "AdTnH@eX.com"
   @chef.email = mixed_email
   @chef.save
   assert_equal mixed_email.downcase, @chef.reload.email
end

test "should have password and password_confirmation" do
  @chef.password = ""
  @chef.password_confirmation = ""
  assert_not @chef.valid?
end

test "should have atleast 5 chars in password" do
  @chef.password = "x"*4
  assert_not @chef.valid?
end

 test "associated recipes should be destroyed" do
    @chef.save
    @chef.recipes.create!(name: "testing delete",description: "testing delete function")
    assert_difference 'Recipe.count', -1 do
    @chef.destroy
    end
  end

end








