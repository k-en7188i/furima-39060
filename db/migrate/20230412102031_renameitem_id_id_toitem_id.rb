class RenameitemIdIdToitemId < ActiveRecord::Migration[6.0]
  def change
    rename_column :purchase_histories, :item_id_id, :item_id
  end
end
