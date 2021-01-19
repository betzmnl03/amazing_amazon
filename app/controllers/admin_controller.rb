class AdminController < ApplicationController
    def new
    end

    def index
      @products = Product.all
      @reviews = Review.all
      @users  = User.all.order(first_name: :ASC)
      @product_count = @products.count
      @review_count = @reviews.count
      @user_count = @users.count
    end

end
