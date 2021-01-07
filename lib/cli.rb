class CLI

    def run 
        sign_in_or_create_login 
    end

    def sign_in_or_create_login
        puts "Welcome What’s for Dinner?"

        prompt = TTY::Prompt.new
        options = ["Login", "Create a new user"]
        prompt.select("Select an option:", options) 

        login  
    end

    def login
        puts "enter your username"
        user_name = gets.chomp         
        @user = User.create_user(user_name)
        # if @user
        #     clear_terminal
        #     home
        # else 
        #     login
        # end
        home 
        # come back to to two login-pages
    end

    def home
        # clear_terminal
        puts "Welcome #{@user.name}, what do you feel like cooking tonight?"

        prompt = TTY::Prompt.new
        display_categories = Recipe.all_categories
        choice = prompt.select("Select one category:", display_categories)

        recipe_choice = Recipe.all.where(category: choice)
        first_choice = recipe_choice.sample

        display_recipe(first_choice) 
    end

    def display_recipe(choice)
        clear_terminal
        puts "Ta Da! Let's cook this #{choice.category} meal:"
        puts "Name: #{choice.name}\nRegion: #{choice.region}\nTime: #{choice.time} minutes\nIngredients: #{choice.ingredient_list}\nInstructions: #{choice.instruction}"
        
        prompt = TTY::Prompt.new
        display_categories = ["Search again?", "Add to Favorites", "View Favorites", "Log Off"]
        second_choice = prompt.select("Select one:", display_categories)

        selection(second_choice)
    end

    def selection(second_choice)
        if second_choice == "Search again?"
            home 
            # works - need to clean up a bit
        elsif second_choice == "Add to Favorites"
            binding.pry 
            create_favorite(recipe)
            # breaks 
        elsif second_choice == "View Favorites"
            view_favorites
        else second_choice == "Log Off"
            log_off
        end
    end

    def display_favorites
        @user.recipes.map do |recipe|
            recipe.name
        end
    end

    def view_favorites
        clear_terminal
        puts "#{@user.name} favorties:" 

        prompt = TTY::Prompt.new
        fav_choice = prompt.select("Select one category:", display_favorites)
        #binding.pry 

        fav_recipe = @user.recipes.where(name: fav_choice)

        display_recipe(fav_recipe)
        # need to write display for favorites
    end
    
    def log_off
        clear_terminal
        puts "Goodbye #{@user.name}! Happy cooking!"
    end 

    def clear_terminal
        system "clear"
    end

end
