class Favorite < ActiveRecord::Base
    belongs_to :user 
    belongs_to :recipe

    # user can leave a recipie notes
    
end