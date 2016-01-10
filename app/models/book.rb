# == Schema Information
#
# Table name: books
#
#  id          :uuid             not null, primary key
#  title       :string
#  author      :string
#  illustrator :string
#  isbn        :string
#  publisher   :string
#  description :text
#  age         :integer
#  gender      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Book < ActiveRecord::Base
  validates :title, :age, :gender, presence: true
end
