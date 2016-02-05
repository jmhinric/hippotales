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

class Book < ActiveRecord::Base
  include TextUtils

  validates :title, :age, :gender, presence: true
  validates :title, uniqueness: true

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :illustrators
  belongs_to :publisher

  enum age: ["0-1", "1-2", "3-6"]
  enum gender: [:both, :boy, :girl]

  def display_author
    display_creator(authors)
  end

  def display_illustrator
    display_creator(illustrators)
  end

  def same_author_illustrator?
    authors.size == 1 && display_author == display_illustrator
  end

  def multiple_authors?
    authors.size > 1
  end

  def multiple_illustrators?
    illustrators.size > 1
  end

  def publisher_name
    publisher.name
  end

  private

  def display_creator(creators)
    return nil unless creators.present?
    and_join(creators.map(&:display_name))
  end
end
