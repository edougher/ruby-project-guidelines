require 'pry'
class Recipe < ActiveRecord::Base 
    # has_many :users
    has_many :favorites
    has_many :users, through: :favorites

    # methods needed:
    # display all caterogies in an array
    def self.all_categories
        self.all.map {|recipe| recipe.category}.uniq
    end
    # display all ingredients with measurements
    def self.all_ingredients 
        #name dish?
        self.all.map {|recipe| recipe.ingredient_list}
    end
    # sort recipes by time under 30, under 45, under 60
    def self.sort_by_cooktime(time)
        self.all.select do |recipe| 
            if recipe.time <= time
                recipe
            end
        
          #less than 20
        #case recipe.time 
        #when 0..20
        #    "#{recipe.name} takes 20 minutes or less"
        # #between 20 and 40
        #when 21..40
        #    "#{recipe.name} takes less than 40 minutes"
        #else 
        #    "#{recipe.name} takes #{recipe.time} minutes"
        #end
      end.sample
    end

    # find all the users 
    
end