class AddPasswordResetColumnsToChef < ActiveRecord::Migration[6.0]
  def change
  	add_column :chefs, :reset_password_token, :string
    add_column :chefs, :reset_password_sent_at, :datetime
  end
end
