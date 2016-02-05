# == Schema Information
#
# Table name: books
#
#  id           :uuid             not null, primary key
#  title        :string
#  isbn         :string
#  image        :string
#  description  :text
#  age          :integer
#  gender       :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  publisher_id :uuid
#

class BooksController < ApplicationController
  def index
    @books0_1 = Book.where(age: 0)
    @books1_2 = Book.where(age: 1)
    @books3_6 = Book.where(age: 2)
  end
end
