=begin
the command to create the Review model with product_id as foreign key
rails g model review body:text rating:integer product:references
=end
class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true
  validates :rating, presence:true, numericality:{greater_than:0, less_than:6}

  has_many :likes
  has_many :likers, through: :likes, source: :user 


  has_many :votes
  has_many :voters, through: :votes, source: :user 

  def self.all_with_vote_counts
    self.left_outer_joins(:votes)
        .select("reviews.*","Count(votes.*) AS votes_count")
        .group('reviews.id')
  end

end
