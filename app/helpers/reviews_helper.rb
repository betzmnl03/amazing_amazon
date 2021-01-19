MAX_RATING = 5
module ReviewsHelper
    def display_stars(review)
        full_stars= review.rating
        empty_stars = MAX_RATING - review.rating
        return full_stars,empty_stars
    end
end