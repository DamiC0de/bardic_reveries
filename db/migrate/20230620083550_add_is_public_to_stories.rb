class AddIsPublicToStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :is_public, :boolean, :default => true
  end
end
