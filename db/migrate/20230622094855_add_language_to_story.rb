class AddLanguageToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :language, :string, :default => "en français"
  end
end
