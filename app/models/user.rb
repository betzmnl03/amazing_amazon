class User < ApplicationRecord

    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_secure_password

    def full_name
        "#{first_name} #{last_name}"
    end
   
end
