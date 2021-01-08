class CLI

    def run 
        sign_in_or_create_login 
        Rails.application.load_seed
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
        ###colorize user.name
        puts "Welcome #{@user.name}, what do you feel like cooking tonight?"

        prompt = TTY::Prompt.new
        display_categories = Recipe.all_categories
        choice = prompt.select("Select a category:", display_categories)
        #binding.pry

        recipe_choice = Recipe.all.where(category: choice)
        ###Give more choices to choose by just name
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
            add_more_seeds
            home
        elsif second_choice == "Add to Favorites"
            @user.create_favorite(recipe)
            #if @user.favorites.find_by(recipe_id: recipe.id)
            #    recipe = @user.favorites.find_by(recipe_id: recipe.id)
            #end
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
        this_favorite = @user.favorites.find_by(recipe_id: sent_recipe.id)
        if this_favorite.user_note != nil
            #binding.pry
        puts "Favorite note: #{this_favorite.user_note}"
        end
        #puts "Recipe Note: #{sent_recipe.user_note}"
        
        prompt = TTY::Prompt.new
        display_categories = ["Add Notes", "Delete from Favorites", "View Favorites", "Recipe Notes", "Log Off"]
        third_choice = prompt.select("Select one:", display_categories)
        ###View notes for this recipe
        fav_selection(third_choice, sent_recipe)
    end

    ###Display Recipe Notes
    #def display_recipe_notes(sent_recipe, recipe)
    #    this_favorite = @user.favorites.find_by(recipe_id: recipe.id)
    #    #binding.pry
    #    puts "Your favorite #{sent_recipe.category} recipe:"
    #    puts "Name: #{sent_recipe.name}\nRegion: #{sent_recipe.region}\nTime: #{sent_recipe.time} minutes\nIngredients: #{sent_recipe.ingredient_list}\nInstructions: #{sent_recipe.instruction}"
    #    puts "Recipe Note: #{this_favorite.user_note}"
    #    
    #end

    def fav_selection(thrid_choice, sent_recipe)
        if thrid_choice == "Add Notes"
            
            add_note(sent_recipe)
        elsif thrid_choice == "Delete from Favorites"
            ###Add delete 
            #@user.favorites.find_by(recipe_id: sent_recipe.id).
            #puts "this works too"
        elsif thrid_choice == "View Favorites"
            view_favorites
        else thrid_choice == "Log Off"
            clear_terminal
            puts "Goodbye #{@user.name}! Happy cooking!"
            sleep 5 
            clear_terminal
        end
    end

    def add_note(sent_recipe)
        puts "Enter a note for this recipe:"
        new_note = gets.chomp
        
        this_favorite = @user.favorites.find_by(recipe_id: sent_recipe.id)
        this_favorite.add_note_to_recipe(new_note)
        #binding.pry
        display_fav_recipe(sent_recipe)

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

    def add_more_seeds
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
        all_categories = Recipe.all_categories
        new_recipe = Recipe.create(category: meal_category, name: meal_name, region: meal_area, ingredient_list: meal_ingredients, time: rand(20..80), instruction: meal_instructions)
        new_recipe.reload
        end
      end
    end

    end

end