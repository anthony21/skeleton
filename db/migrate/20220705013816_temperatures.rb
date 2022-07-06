class Temperatures < ActiveRecord::Migration[7.0]
  def change
    create_table :temperatures do |t|
      t.string :hot
      t.string :cold
      t.string :warm
    end
  end
end
