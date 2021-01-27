class VotesController < ApplicationController

  
    def create
        product = Product.find params[:product_id]
        review= Review.find params[:review_id] 
        vote= Vote.new review: review, user: current_user
        if !can?(:vote, review)
            flash[:alert]='You can not vote your own review'
        elsif vote.save
            flash[:notice]='Review voted'
        else
            flash[:alert]=vote.errors.full_messages.join(', ')
        end
        redirect_to product_path(product)
    end
    def destroy
        vote = current_user.votes.find params[:id]
        review = vote.review
        if !can?(:destroy, vote)
            flash[:success] = "Downvoted Review"
            redirect_to favourite.product
        elsif vote.destroy
          flash[:notice] = "Vote -1"
        else
          flash[:alert] = "Couldn't unvote"
        end
        redirect_to product_path(review.product)
    end

    def index
        #here i want to get each review with their number of votes

    end

    def voted
        # @tag=Tag.find_or_initialize_by(name: params[:tag])
        # @questions= current_user.liked_questions.order(created_at: :desc)
        @reviews = Review.all.all_with_vote_counts.order(votes_count: :desc) 
    end
    def show

    end

   
end
