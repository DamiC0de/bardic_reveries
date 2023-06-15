class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.integer :age
      t.string :theme
      t.string :first_character
      t.string :secondary_character
      t.string :fav_object
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
