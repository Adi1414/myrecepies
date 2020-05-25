class Ingredient < ApplicationRecord
validates :name, presence: true, length: {minmum: 3, maximum: 25}
has_many :recipe_ingredients
has_many :recipes, through: :recipe_ingredients
validates_uniqueness_of :name

end	