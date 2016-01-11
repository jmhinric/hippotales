class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books, id: :uuid do |t|
      t.string :title
      t.string :isbn
      t.string :image
      t.text :description
      t.integer :age
      t.integer :gender, default: 0
      t.timestamps null: false
      t.uuid :publisher_id
    end

    create_table :publishers, id: :uuid do |t|
      t.string :name
      t.timestamps null: false
    end

    add_foreign_key :books, :publishers, column_name: :publisher_id, name: "fk_books_publishers_publisher_id"
  end
end
