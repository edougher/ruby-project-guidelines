class User < ActiveRecord::Base 
    has_many :favorites
    has_many :recipes, through: :favorites 

    # view all of user's recipes
    def user_recipes
        self.recipes
    end

     # creates a favroite reciepe
     def create_favorite(recipe)
        if user_recipes.include?(recipe) 
            puts "This recipe was already a favorite.".colorize(:red)
         else
            Favorite.create(user_id: self.id, recipe_id: recipe.id)
            puts "Success! This recipe was added to your favorites.".colorize(:green)
         end
    end

    # find or create a username  
    def self.create_user(name)
        user = User.find_by(name: name)
        if user
            puts "Welcome back!".colorize(:green)
            user 
        else
            puts "Your user name was created.".colorize(:green)
            User.create(name: name)
        end
    end

    # user can delete a recipe from user favorites
    def delete_favorite(recipe) 
        fav_recipe = self.favorites.find_by(recipe_id: recipe) 
        fav_recipe.destroy  
    end

end