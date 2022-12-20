require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "blog.sqlite3"
)

ActiveRecord::Base.logger = Logger.new($stdout)

class Post < ActiveRecord::Base
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :post
end
