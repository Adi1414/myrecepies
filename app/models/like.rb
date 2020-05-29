class Like < ApplicationRecord
  belongs_to :recipe
  belongs_to :chef
end
