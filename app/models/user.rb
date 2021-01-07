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
            puts "This recipe is already a favorite."
         else
            Favorite.create(user_id: self.id, recipe_id: recipe.id)
         end
    end

    # helper method for deleting favorite recipe
    def view_favorites
        self.favorites 
    end

    #create login method

    # find or create a username  
    def self.create_user(name)
        if User.find_by(name: name)
            puts "This user name alredy taken. Try again."
        else
            User.create(name: name)
        end
    end

    # user can delete a recipe from user favorites
    def delete_favorite(recipe_id) 
        fav_recipe = view_favorites.find_by(recipe_id: recipe_id) 
        fav_recipe.destroy  
    end

end