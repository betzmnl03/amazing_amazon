class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_product, only:[:destroy,:show, :edit, :update ]
    before_action :authorize_user!,only:[:edit,:update,:destroy]
    def new
        @product=Product.new
    end

    def edit
    end

    def destroy
        @product.destroy
        redirect_to products_path
    end
    
    def index
        @products=Product.all.order(title: :ASC)  
        @search_word=""
        @count=@products.count
    end

    def show
        @reviews = @product.reviews.order(created_at: :DESC)
        @review = Review.new
        @review_hide = params
    end

    def create
        if params[:search]
            @search_word = params[:search]
            @products= Product.where("title ilike?", "%#{@search_word}%")
            @count=@products.count
            render :index
        else
            @product=Product.new product_params
            @product.user = current_user

            if @product.save
                flash[:notice]="Product created successfully."
                redirect_to product_path(@product.id)
            else
                render :new
            end
        end
    end

    def update
        if @product.update product_params
            redirect_to product_path(@product.id), notice: "Product edited successfully."
        else
            render :edit
        end
    end

    private
    def find_product
        @product=Product.find params[:id] 
    end
    def product_params
        params.require(:product).permit(:title, :description, :price, :category, :image)
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @product)
    end
end
