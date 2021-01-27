class TagsController < ApplicationController

    def index
        @tags= Tag.all.order(name: :asc)
       
    end

    def show
        @tag = Tag.find params[:id]
        @products = @tag.products.order(created_at: :desc)
    end
end
