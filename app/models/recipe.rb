class Recipe < ActiveRecord::Base 
    has_many :users


    def meal_category
        category_data = RestClient.get('https://www.themealdb.com/api/json/v2/9973533/categories.php')
        parsed_categroy = JSON.parse(category_data)
        binding.pry 
    end 


end