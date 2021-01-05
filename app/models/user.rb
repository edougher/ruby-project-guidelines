class User < ActiveRecord::Base 
    has_many :favorites
    has_many :recipes, through: :favorites 

    # methods needed:
    # create a username
    # creates a favroite reciepe
    # display all favorite receipes by name in array
    # display all favorite receipes by region in a unique array
    # display all favorite receipes by category in a unique array
    # select a different recipe 
    # change the category

    

end