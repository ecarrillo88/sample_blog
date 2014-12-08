class Post < ActiveRecord::Base
  attr_accessible :title, :user_id, :author, :text

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: :true
  validates :text, presence: :true
end
