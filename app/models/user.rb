class User < ApplicationRecord

    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_secure_password
   
end
