class BooksController < ApplicationController
  def index
    @books0_1 = Book.where(age: 0)
    @books1_2 = Book.where(age: 1)
    @books3_6 = Book.where(age: 2)
  end
end
