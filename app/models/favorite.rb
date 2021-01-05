class Favorite < ActiveRecord::Base
    belongs_to :user 
    belongs_to :recipe

    def self.favorite_regions
        self.recipes.map do |recipe|
            binding.pry
        end
    end
end