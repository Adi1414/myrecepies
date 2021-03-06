require 'test_helper'

class ChefEditTest < ActionDispatch::IntegrationTest
  def setup
  	 @chef = Chef.create!(chefname: "mashrur",email: "mashrur@example.com", password: "jewel", password_confirmation: "jewel")
      @admin = Chef.create!(chefname: "tomato1",email: "tomato1@example.com", password: "jewel", password_confirmation: "jewel", admin: true)
  end
 test "reject an invalid edit" do
    sign_in_as(@chef, "jewel")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", 
                              email: "mashrur@example.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
 test "accept valid chef update" do
   sign_in_as(@chef, "jewel")
   get edit_chef_path(@chef)
   assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "mashrur1", 
                                email: "mashrur1@example.com" } }
    assert_redirected_to @chef
   assert_redirected_to chef_path(@chef)
   assert_not flash.empty?
   @chef.reload
  assert_match "mashrur1", @chef.chefname
    assert_match "mashrur1@example.com", @chef.email
   
 end


 test "accept valid chef update via admin" do
   sign_in_as(@admin, "jewel")
   get edit_chef_path(@chef)
   assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "mashrur1", 
                                email: "mashrur1@example.com" } }
    assert_redirected_to @chef
   assert_redirected_to chef_path(@chef)
   assert_not flash.empty?
   @chef.reload
  assert_match "mashrur1", @chef.chefname
    assert_match "mashrur1@example.com", @chef.email
   
 end



 test "reject invalid chef update via admin" do
   sign_in_as(@admin, "jewel")
    patch chef_path(@chef), params: { chef: { chefname: "mashrur1", 
                                email: "mashrur1@example.com" } }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "mashrur1", @chef.chefname
    assert_match "mashrur1@example.com", @chef.email
   
 end

end
