class CreateDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |t|
      t.references :hospital, foreign_key: true
      t.string :name
      t.string :specialty
      t.string :university

      t.timestamps
    end
  end
end
