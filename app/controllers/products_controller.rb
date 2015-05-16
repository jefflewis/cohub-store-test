class ProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @products = if params[:keywords]
                 Product.where('name ilike ?',"%#{params[:keywords]}%")
               else
    @products = Product.all
               end
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(params.require(:product).permit(:name,:description,:quantity,:sku,:price))
    @product.save
    render 'show', status: 201
  end

  def update
    product = Product.find(params[:id])
    product.update_attributes(params.require(:product).permit(:name,:description,:quantity,:sku,:price))
    head :no_content
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    head :no_content
  end
end
