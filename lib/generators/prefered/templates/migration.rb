class CreatePreferencesTable < ActiveRecord::Migration
   def self.up
     create_table :preferences do |t|
       t.string   :owner_type
       t.integer  :owner_id
       t.text     :data
       t.timestamps
    end
  end

  def self.down
    drop_table :preferences
  end
end