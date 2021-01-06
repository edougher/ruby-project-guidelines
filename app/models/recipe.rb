class Recipe < ActiveRecord::Base 
    has_many :favorites
    has_many :users, through: :favorites

    # methods needed:
    # do we need a read recipe method???

    # display all caterogies in an array
    def self.all_categories
        self.all.map {|recipe| recipe.category}.uniq
    end

    # sort recipes by time under 30, under 45, under 60
    def self.sort_by_cooktime(time)
        self.all.select do |recipe| 
            if recipe.time <= time
                recipe
            end
      end.sample
    end

    # display all ingredients with measurements - for grocery list
    # def self.all_ingredients 
    #     self.all.map { |recipe| recipe.ingredient_list }
    # end
    
end