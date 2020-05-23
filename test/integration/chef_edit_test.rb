require 'test_helper'

class ChefEditTest < ActionDispatch::IntegrationTest
  def setup
  	 @chef = Chef.create!(chefname: "mashrur",email: "mashrur@example.com", password: "jewel", password_confirmation: "jewel")
  end
 test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", 
                              email: "mashrur@example.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
 test "accept valid chef update" do
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

end
