class CreateDealers < ActiveRecord::Migration[5.2]
  def change
    create_table :dealers do |t|
      t.string :name
      t.integer :account_balance
    end
  end
end
