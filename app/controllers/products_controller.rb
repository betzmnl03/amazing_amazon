class ProductsController < ApplicationController
    before_action :find_product, only:[:destroy,:show, :edit, :update ]
    def new
        @product=Product.new
    end

    def destroy
        puts "inside desrtroy method"
        @product = Product.find(params[:id])
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
    end

    def create
        @product=Product.new product_params

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
    end

    private
    def find_product
        @product=Product.find params[:id] 
    end
    def product_params
        params.require(:product).permit(:title, :description, :price)
    end
end
