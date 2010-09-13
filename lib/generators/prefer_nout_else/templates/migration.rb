class CreatePreferencesTable < ActiveRecord::Migration
   def self.up
     create_table :preferences do |t|
       t.string   :preferencer_type
       t.integer  :preferencer_id
       t.text     :data
       t.timestamps
    end
  end

  def self.down
    drop_table :preferences
  end
end