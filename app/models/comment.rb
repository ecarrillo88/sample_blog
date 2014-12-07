class Comment < ActiveRecord::Base
  attr_accessible :user, :text

  belongs_to :post

  validates :user, presence: true
  validates :text, presence: :true
end
