class PostEntry < ActiveRecord::Base
  attr_accessible :author_id, :content

  belongs_to :author
end
