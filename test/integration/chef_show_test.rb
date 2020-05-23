require 'test_helper'

class ChefShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
  	 @chef = Chef.create!(chefname: "mashrur",email: "mashrur@example.com", password: "jewel", password_confirmation: "jewel")
     @recipe = Recipe.create!(name: "Paneer tikka", description: "Contains garlic paste, origano and sauces", chef: @chef )
     @recipe2 = @chef.recipes.build(name: "Paneer dopyaza", description: "Contains onion, garlic paste, origano and sauces" )
     @recipe2.save!
  
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end

  test "should get index page" do
   get chefs_path
   assert_response :success
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template 'chefs/index'
  assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
 
  end

end
