require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
   @chef = Chef.create!(chefname: "master chef", email: "masterchef@examole.com")
   @recipe = Recipe.create!(name: "Paneer tikka", description: "Contains garlic paste, origano and sauces", chef: @chef )
   @recipe2 = @chef.recipes.build(name: "Paneer dopyaza", description: "Contains onion, garlic paste, origano and sauces" )
   @recipe2.save!
  end

  test "should get index page" do
   get recipes_path
   assert_response :success
  end
 
  test "should redirect to index page" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]",recipe_path(@recipe), text:@recipe.name
    assert_select "a[href=?]",recipe_path(@recipe2), text:@recipe2.name
  end 

  test "should show list of all recipes" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end 


end
