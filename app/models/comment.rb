class Comment < ActiveRecord::Base
  attr_accessible :user, :text

  belongs_to :post
end
