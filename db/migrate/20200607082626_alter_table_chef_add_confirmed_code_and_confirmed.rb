class AlterTableChefAddConfirmedCodeAndConfirmed < ActiveRecord::Migration[6.0]
  def change
  	add_column :chefs, :confirmed, :boolean, default: false
  	add_column :chefs, :confirm_code, :string
  end
end
