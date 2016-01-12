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

  enum age: { "0-1" => 0, "1-2" => 1, "3-6" => 2 }
  enum gender: { both: 0, boy: 1, girl: 2 }

  def display_author
    display_creator(authors)
  end

  def display_illustrator
    display_creator(illustrators)
  end

  private

  def display_creator(creators)
    return nil unless creators.present?
    return and_join(creators.map(&:display_name))
  end
end
