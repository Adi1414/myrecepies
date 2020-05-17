class AlterTableRecipesAddColumnChefId < ActiveRecord::Migration[6.0]
  def change
  	add_column :recipes, :chef_id , :int
  end
end
