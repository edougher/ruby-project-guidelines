class Recipe < ActiveRecord::Base 
    has_many :users
end