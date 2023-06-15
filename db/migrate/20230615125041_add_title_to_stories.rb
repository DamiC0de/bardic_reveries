class AddTitleToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :title, :string
  end
end
