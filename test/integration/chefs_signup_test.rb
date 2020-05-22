require 'test_helper'

class ChefsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
 
 test "should get signup path" do
  get signup_path
  assert_response :success
end

test "reject invalid chef" do
  get signup_path
  assert_template 'chefs/new'
  assert_no_difference 'Chef.count' do
    post chefs_path, params: {chef: {chefname: "", email: "aditi@gmail.com", password: "", password_confirmation: "jewel"}}
  end 
 assert_template 'chefs/new'
 assert_select 'h2.panel-title'
 assert_select 'div.panel-body'
end

test  "accept valid values" do
  get signup_path
  assert_template 'chefs/new'
  assert_difference 'Chef.count',1 do
    post chefs_path, params: {chef: {chefname: "Aditi", email: "aditi@gmail.com", password: "jewel", password_confirmation: "jewel"}}
  end
   # assert_redirected_to @chef
    follow_redirect!
     assert_template 'chefs/show'
    assert_not flash.empty?
end


end
