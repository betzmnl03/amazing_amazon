class LikesController < ApplicationController

    def create
        product = Product.find params[:product_id]
        review= Review.find params[:review_id] 
        like= Like.new review: review, user: current_user
        if !can?(:like, review)
            flash[:alert]='You can not like your own question'
        elsif like.save
            flash[:notice]='Review liked'
        else
            flash[:alert]=like.errors.full_messages.join(', ')
        end
        redirect_to product_path(product)
    end
    def destroy
        like = current_user.likes.find params[:id]
        review = like.review
        if !can?(:destroy, like)
          flash[:alert] = "Can't unlike someone else's like"
        elsif like.destroy
          flash[:notice] = "Like -1"
        else
          flash[:alert] = "Couldn't unlike"
        end
        redirect_to product_path(review.product)
      end

   
      



end
