require 'json'
require 'rest-client'
require 'pry'
User.destroy_all
Recipe.destroy_all
Favorite.destroy_all


    api_key = 9973533
    api_url = "https://www.themealdb.com/api/json/v2/#{api_key}/"
    
    find_ten_random = api_url + "randomselection.php"

    3.times do
    recipe_data = RestClient.get(find_ten_random)
    parsed_recipe = JSON.parse(recipe_data.body)
    parsed_recipe.map do |meal_hash|
        #binding.pry
        i = 0
        while i < 10 do
        meal = meal_hash[1][i]
        meal_name = meal["strMeal"]
        meal_category = meal["strCategory"]
        meal_instructions = meal["strInstructions"]
        meal_area = meal["strArea"]
        meal_ingredients = meal["strIngredient1"]
    
        i += 1
        Recipe.create(category: meal_category, name: meal_name, region: meal_area, ingredient_list: meal_ingredients, time: rand(20..80), instruction: meal_instructions)
        end
      end
    end


#user_1 = User.create(name: "James")
#user_2 = User.create(name: "Aaron")
#user_3 = User.create(name: "Abbie")
#user_4 = User.create(name: "Rachelle")
#user_5 = User.create(name: "Max")
#
## this creates a string of the measurment & ingredient 
#total_ingredient = "#{Faker::Food.measurement} - #{Faker::Food.ingredient}, #{Faker::Food.measurement} - #{Faker::Food.ingredient}"
#
#recipe_1 = Recipe.create(category: "Chicken", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 20)
#recipe_2 = Recipe.create(category: "Chicken", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 80)
#recipe_3 = Recipe.create(category: "Beef", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 60)
#recipe_4 = Recipe.create(category: "Beef", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 20)
#recipe_5 = Recipe.create(category: "Seafood", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 30)
#recipe_6 = Recipe.create(category: "Seafood", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 40)
#recipe_7 = Recipe.create(category: "Vegan", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 45)
#recipe_8 = Recipe.create(category: "Vegetarian", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 50)
#recipe_9 = Recipe.create(category: "Vegan", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 60)
#recipe_10 = Recipe.create(category: "Pork", name: Faker::Food.dish, region: Faker::Nation.nationality, ingredient_list: total_ingredient, instruction: Faker::Food.description, time: 30)
#
#fav_1 = Favorite.create(user_id: user_1.id, recipe_id: recipe_1.id)
#fav_2 = Favorite.create(user_id: user_1.id, recipe_id: recipe_2.id)
#fav_3 = Favorite.create(user_id: user_2.id, recipe_id: recipe_3.id)
#fav_4 = Favorite.create(user_id: user_2.id, recipe_id: recipe_4.id)
#fav_5 = Favorite.create(user_id: user_3.id, recipe_id: recipe_1.id)
#fav_6 = Favorite.create(user_id: user_3.id, recipe_id: recipe_7.id)
#fav_7 = Favorite.create(user_id: user_3.id, recipe_id: recipe_8.id)
#fav_8 = Favorite.create(user_id: user_4.id, recipe_id: recipe_1.id)
#fav_9 = Favorite.create(user_id: user_4.id, recipe_id: recipe_10.id)
#fav_10 = Favorite.create(user_id: user_4.id, recipe_id: recipe_9.id)
#fav_11 = Favorite.create(user_id: user_4.id, recipe_id: recipe_5.id)
#fav_12 = Favorite.create(user_id: user_5.id, recipe_id: recipe_1.id)
#fav_13 = Favorite.create(user_id: user_2.id, recipe_id: recipe_1.id)
#fav_14 = Favorite.create(user_id: user_2.id, recipe_id: recipe_7.id)
#fav_15 = Favorite.create(user_id: user_2.id, recipe_id: recipe_6.id)
#fav_16 = Favorite.create(user_id: user_3.id, recipe_id: recipe_10.id)
#fav_17 = Favorite.create(user_id: user_1.id, recipe_id: recipe_6.id)

# user_id = User.all.map { |user| user.id }
# recipe_id = Recipe.all.map { |recipe| recipe.id }

# 20.times do
#     Favorite.create(user_id: user_id.sample, recipe_id: recipe_id.sample)
# end


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