class AddUserToReceipts < ActiveRecord::Migration[7.0]
  def change
    add_reference :receipts, :user, null: false, foreign_key: true
  end
end
