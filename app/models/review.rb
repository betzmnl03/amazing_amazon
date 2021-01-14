=begin
the command to create the Review model with product_id as foreign key
rails g model review body:text rating:integer product:references
=end
class Review < ApplicationRecord
  belongs_to :product

  validates :rating, presence:true, numericality:{greater_than:0, less_than:6}
end
