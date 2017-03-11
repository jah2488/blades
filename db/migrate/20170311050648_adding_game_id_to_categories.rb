class AddingGameIdToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :game_id, :int
  end
end
