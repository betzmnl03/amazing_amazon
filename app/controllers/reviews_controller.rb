class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user!,only:[:edit,:update,:destroy]
    def new
        @review=Review.new
    end
    def create
        @product = Product.find params[:product_id]
        @review=Review.new review_params
        @review.product=@product
        @review.user=current_user
        @review_hide = params
        if @review.save
         redirect_to product_path(@product), notice: 'Review created!'
        else
            @reviews=@product.reviews.order(created_at: :desc)
            render '/products/show'
        end
    end

    def show
    end
    def destroy
        @product = Product.find params[:product_id]
        @review = Review.find params[:id]
        @review.destroy
        redirect_to product_path(@product), notice: "Review Deleted"
    end

    def update
        @product = Product.find params[:product_id]
        @review = Review.find params[:id]
        if(@review.hide)
            @review.hide = false
        else
            @review.hide = true
        end
        @review.save
        redirect_to product_path(@product)
        
    end

    private
    def review_params
        params.require(:review).permit(:body, :rating, :hide)
    end

    def authorize_user!
        @review = Review.find params[:id]
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @review)
    end


end
