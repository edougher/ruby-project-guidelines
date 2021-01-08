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
        puts "Enter your username:" 
        
        user_name = gets.chomp 
        @user = User.create_user(user_name)

        home 
        # come back to to two login-pages
    end

    def home
        clear_terminal
        puts "Welcome #{@user.name}, what do you feel like cooking tonight?"

        prompt = TTY::Prompt.new
        display_categories = Recipe.all_categories
        choice = prompt.select("Select a category:", display_categories)

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

        selection(second_choice, choice)
    end

    def selection(second_choice, recipe)
        if second_choice == "Search again?"
            home 
        elsif second_choice == "Add to Favorites"
            @user.create_favorite(recipe)
            sleep 2
            display_recipe(recipe)
        elsif second_choice == "View Favorites"
            if display_favorites.any? == false  
                puts "You have no favorites saved."
                sleep 2
                display_recipe(recipe)
            else
                view_favorites
            end
        else second_choice == "Log Off"
            clear_terminal
            puts "Goodbye #{@user.name}! Happy cooking!"
            sleep 5 
            clear_terminal
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
        fav_choice = prompt.select("Select a favorite:", display_favorites)

        fav_recipe = @user.recipes.where(name: fav_choice)
        sent_recipe = fav_recipe.first 
        #binding.pry 
        display_fav_recipe(sent_recipe)
    end

    def display_fav_recipe(sent_recipe)
        clear_terminal

        puts "Your favorite #{sent_recipe.category} recipe:"
        puts "Name: #{sent_recipe.name}\nRegion: #{sent_recipe.region}\nTime: #{sent_recipe.time} minutes\nIngredients: #{sent_recipe.ingredient_list}\nInstructions: #{sent_recipe.instruction}"
        
        prompt = TTY::Prompt.new
        display_categories = ["Add Notes", "Delete from Favorites", "View Favorites", "Log Off"]
        thrid_choice = prompt.select("Select one:", display_categories)

        fav_selection(thrid_choice, sent_recipe)
    end

    def fav_selection(thrid_choice, sent_recipe)
        if thrid_choice == "Add Notes"
            puts "this works"
        elsif thrid_choice == "Delete from Favorites"
            puts "this works too"
        elsif thrid_choice == "View Favorites"
            view_favorites
        else thrid_choice == "Log Off"
            clear_terminal
            puts "Goodbye #{@user.name}! Happy cooking!"
            sleep 5 
            clear_terminal
        end
    end
    
    # log_off not displaying - no method error - need help 
    def log_off
        clear_terminal
        puts "Goodbye #{@user.name}! Happy cooking!"
        sleep 5 
        clear_terminal
    end 

    def clear_terminal
        system "clear"
    end

end
