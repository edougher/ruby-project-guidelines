class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :cuisine
      t.integer :time
      t.text :ingredient_list
      t.text :instruction
    end
  end
end
