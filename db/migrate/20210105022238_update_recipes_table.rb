class UpdateRecipesTable < ActiveRecord::Migration[6.1]
  def change
    rename_column :recipes, :cuisine, :category 
    add_column :recipes, :name, :string
    add_column :recipes, :region, :string 
  end
end
