class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.string :nom
      t.string :valeur

      t.timestamps
    end
  end
end
