class RenameuserIdIdTouserId < ActiveRecord::Migration[6.0]
  def change
    rename_column :purchase_histories, :user_id_id, :user_id
  end
end
