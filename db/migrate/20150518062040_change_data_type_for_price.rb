class ChangeDataTypeForPrice < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.change :price, :money
    end
  end
  def self.down
    change_table :products do |t|
      t.change :price, :decimal
    end
  end
end
