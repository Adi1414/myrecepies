# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Chef.create(chefname: "Aditi", email: "aditi@gmail.com", password: "jewel", password_confirmation: "jewel", admin: true)
@chef = Chef.create!(chefname: "mashrur",email: "mashrur@example.com", password: "jewel", password_confirmation: "jewel")
@recipe = Recipe.create(name: "vegetable saute",description: "great vegetable sautee, add vegetable and oil", chef: @chef)


@chef = Chef.create!(chefname: "chuchu",email: "chuchu@example.com", password: "jewel", password_confirmation: "jewel")
@admin = Chef.create!(chefname: "tomato1",email: "tomato1@example.com", password: "jewel", password_confirmation: "jewel", admin: true)

@recipe = Recipe.create(name: "Paneer tikka",description: "great vegetable sautee, add vegetable and oil", chef: @chef)
