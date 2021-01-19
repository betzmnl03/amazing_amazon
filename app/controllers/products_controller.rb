class ProductsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_product, only:[:destroy,:show, :edit, :update ]
    before_action :authorize_user!,only:[:edit,:update,:destroy]
    def new
        @product=Product.new
    end

    def edit

        puts "here"
    end

    def destroy
        puts "inside destroy method"
        @product.destroy
        redirect_to products_path
    end
    
    def index
        @products=Product.all.order(created_at: :desc)
    end

    def show
        # puts params[:id]
        @reviews = @product.reviews.order(created_at: :DESC)
        @review = Review.new
        @review_hide = params
    end

    def create
        @product=Product.new product_params
        @product.user = current_user

        if @product.save
            flash[:notice]="Product created successfully."
            redirect_to product_path(@product.id)
        else
            render :new
        end
    end

    def update
        if @product.update product_params
            redirect_to product_path(@product.id), notice: "Product edited successfully."
        else
            render :edit
        end

        puts "here"
    end


    private
    def find_product
        @product=Product.find params[:id] 
    end
    def product_params
        params.require(:product).permit(:title, :description, :price)
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @product)
    end
end
