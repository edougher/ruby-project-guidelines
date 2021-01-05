class Recipe < ActiveRecord::Base 
    # has_many :users
    has_many :favorites
    has_many :users, through: :favorites

    # methods needed:
    # display all caterogies in an array
    # display all ingredients with measurements 
    # sort recipes by time under 30, under 45, under 60
    # find all the users 


end