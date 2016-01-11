class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators, id: :uuid do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.references :creatorable, polymorphic: true, index: true
      t.timestamps null: false
    end

    create_table :authors, id: :uuid do |t|
      t.timestamps null: false
    end

    create_table :illustrators, id: :uuid do |t|
      t.timestamps null: false
    end

    create_table :authors_books, id: :uuid do |t|
      t.uuid :book_id
      t.uuid :author_id
      t.timestamps null: false
    end

    create_table :books_illustrators, id: :uuid do |t|
      t.uuid :book_id
      t.uuid :illustrator_id
      t.timestamps null: false
    end
  end
end
