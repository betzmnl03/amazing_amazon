class User < ApplicationRecord

    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_secure_password

    has_many :likes
    has_many :liked_reviews, through: :likes, source: :review


    has_many :votes
    has_many :voted_reviews, through: :votes, source: :review

    has_many :favourites, dependent: :destroy
    has_many :favourited_products, through: :favourites, source: :product

    def full_name
        "#{first_name} #{last_name}"
    end
   
end
