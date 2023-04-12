class CreatePurchaseHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_histories do |t|
      t.references :user_id, null: false
      t.references :item_id, null: false
      t.timestamps
    end
  end
end
