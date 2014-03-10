class PostEntry < ActiveRecord::Base
  attr_accessible :author_id, :content, :post_id

  belongs_to :author
end
