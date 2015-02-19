class AddArtistsToUser < ActiveRecord::Migration
  def change
    add_column :users, :artists, :string, array: true, default: '{}'
  end
end
