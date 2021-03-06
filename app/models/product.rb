class Product < ApplicationRecord
    
    belongs_to :user, optional: true
    
    before_validation :set_default_price, :set_default_sale_price
    before_save :captitalize_title
    validates :title, presence:true, uniqueness:{case_sensitive:true, message:"please change the title. it sucks"}, confirmation:{case_sensitive:false}, exclusion: {in: ['apple','microsoft','sony'], message: "%{value} is reserved. Please use a diffferent title"}
    validates :description, presence:true, length:{minimum:0}
    validates :price, numericality:{greater_than:0}
    validate :sale_price_less_than_price
    DEFAULT_PRICE = 1


    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings


    def self.search(query)
        where("title ILIKE?", "%#{query}%")
        where("description ILIKE?", "%#{query}%")
    end


    def increment_hit_count
        new_hit_count = self.hit_count += 1
        update({hit_count: new_hit_count})
    end

    # def self.search(search_term)
    #     where("first_name LIKE? OR last_name LIKE? OR email LIKE?", "%#{search_term}%","%#{search_term}%","%#{search_term}%")     
    # end

     #ASSOCIATION WITH PRODUCT MODEL
     has_many :reviews, dependent: :nullify #we can choose to destroy the dependents or nullify

     has_many :favourites, dependent: :destroy
     has_many :favouriters, through: :favourites, source: :user

    def tag_names
        self.tags.map(&:name).join(', ')
    end

    def tag_names=(rhs)
        self.tags=rhs.strip.split(/\s*,\s*/).map do|tag_name|
            Tag.find_or_initialize_by(name: tag_name)
        end
    end

    private

    def set_default_price
        self.price ||= DEFAULT_PRICE 
    end

    def set_default_sale_price
        self.sale_price ||=self.price
    end


    def sale_price_less_than_price
        if self.sale_price > self.price
            errors.add(:sale_price, "sale_price: #{self.sale_price} must be lower than #{self.price}")
        end
    end

    def captitalize_title
        if title.capitalize != "#{title[0]}#{title.slice(1,-1)}"
            self.title = title.capitalize
        end
    end

end

