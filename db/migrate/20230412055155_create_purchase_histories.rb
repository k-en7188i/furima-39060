class CreatePurchaseHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_histories do |t|
      t.references :user, null: false
      t.references :item, null: false
      t.timestamps
    end
  end
end
