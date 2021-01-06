class Favorite < ActiveRecord::Base
    belongs_to :user 
    belongs_to :recipe


    # user can leave a recipie notes
    def add_note_to_recipe(note)
        self.user_note = note
    end
    
end