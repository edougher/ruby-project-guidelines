User.destroy_all
Recipe.destroy_all
Favorite.destroy_all

5.times do
User.create(name: Faker::FunnyName.two_word_name)
end
10.times do
Recipe.create(name: Faker::Food.dish, category: Faker::Food.dish, instruction: Faker::Food.description, ingredient_list: Faker::Food.ingredient, region: Faker::Nation.nationality)
end
user_id = User.all.map { |user| user.id }
recipe_id = Recipe.all.map { |recipe| recipe.id }

20.times do
        Favorite.create(user_id: user_id.sample, recipe_id: recipe_id.sample)
end


#fav_1 = Favorite.create(user_id: user_1.id, recipe_id: recipe_1.id)

#10.times do
#    User.create(name: Faker::FunnyName.two_word_name)
#
#    recipe_data = RestClient.get('https://www.themealdb.com/api/json/v2/9973533/random.php')
#    parsed_recipe = JSON.parse(recipe_data)
#    meal_hash = parsed_recipe["meals"][0]
#    meal_name = meal_hash["strMeal"]
#    meal_category = meal_hash["strCategory"]
#    meal_instructions = meal_hash["strInstructions"]
#    meal_area = meal_hash["strArea"]
#    Recipe.create(category: meal_category, name: meal_name, region: meal_area, instruction: meal_instructions)
#end
#
#user_id = User.all.map { |user| user.id }
#recipe_id = Recipe.all.map { |recipe| recipe.id }
#
#20.times do
#    Favorite.create(user_id: user_id.sample, recipe_id: recipe_id.sample)
#end 

#binding.pry