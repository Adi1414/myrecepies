class Comment < ApplicationRecord
validates :description, presence: true, length: {minmum: 4, maximum: 150 }
belongs_to :recipe
belongs_to :chef
validates :recipe_id , presence: true
validates :chef_id , presence: true
default_scope -> { order(updated_at: :desc)}
end	