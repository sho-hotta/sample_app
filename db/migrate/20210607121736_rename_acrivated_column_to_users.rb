class RenameAcrivatedColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :acrivated, :activated
  end
end
