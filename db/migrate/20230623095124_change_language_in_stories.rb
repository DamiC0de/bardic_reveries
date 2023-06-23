class ChangeLanguageInStories < ActiveRecord::Migration[7.0]
  def change
    change_column(:stories, :language, :string, :default => "French")
  end
end
