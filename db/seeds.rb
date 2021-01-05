require 'rest-client'
require 'json'
require 'pry'

Recipe.destroy_all



10.times do
recipe_data = RestClient.get('https://www.themealdb.com/api/json/v1/1/random.php')
parsed_recipe = JSON.parse(recipe_data)
meal_hash = parsed_recipe["meals"][0]
meal_name = meal_hash["strMeal"]
meal_category = meal_hash["strCategory"]
meal_instructions = meal_hash["strInstructions"]

Recipe.create(cuisine: meal_category, instruction: meal_instructions)
end

binding.pry