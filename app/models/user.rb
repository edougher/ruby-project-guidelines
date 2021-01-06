class User < ActiveRecord::Base 
    has_many :favorites
    has_many :recipes, through: :favorites 

    # methods needed:

    # view all of user's recipes
    def user_recipes
        self.recipes
    end

     # creates a favroite reciepe
     def create_favorite(recipe)
        if user_recipes.include?(recipe) 
            puts "this already exists"
         else
            Favorite.create(user_id: self.id, recipe_id: recipe.id)
         end
    end

    # create a username - still needs work 
    def self.create_user(name)
        if name == User.find_by(name: name)
            binding.pry 
            puts "This name alredy taken. Try again."
        else 
            User.create(name: name)
        end
    end
   
    # display all favorite receipes by name in array 
    # def self.favorite_recipes
    #     self.favorites
    #     # Favorite.all.select do |favorite|
    #     #     binding.pry 
    #     #     favorite.user_id == self.id 
    #     # end
    # end

    # display all favorite receipes by region in a unique array
    # display all favorite receipes by category in a unique array
    # user can delete a favroite 
    # select a different recipe 
    # change the category

end