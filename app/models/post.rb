class Post < ActiveRecord::Base
  attr_accessible :author, :text, :title

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: :true
  validates :text, presence: :true
end
