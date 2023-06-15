class AddContentToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :content, :text
  end
end
