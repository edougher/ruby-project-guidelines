class CLI

    def run 
        sign_in_or_create_login 
    end

    def sign_in_or_create_login
        puts "Welcome to What’s for Dinner?"
        puts "Select to login or create a new user:"

        user_name = gets.chomp 
        @user = User.find_or_create_by(name: user_name)
        home 
    end

    # def login
        
    #     # clear up terminal so prompt is clear
    # end

    def home
        clear_terminal
        puts "Welcome #{@user.name}, what do you feel like cooking tonight?"

        puts "Select from these categories:"
        display_categories = Recipe.all_categories
        clear_terminal
        puts display_categories

        choice = gets.chomp
        recipe_choice = Recipe.all.where(category: choice)
        clear_terminal
        puts recipe_choice
        
    end

    def clear_terminal
        system "clear"
    end



end