class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books, id: :uuid do |t|
      t.string :title
      t.string :author
      t.string :illustrator
      t.string :isbn
      t.string :publisher
      t.text :description
      t.integer :age
      t.integer :gender, default: 0
      t.timestamps null: false
    end
  end
end
