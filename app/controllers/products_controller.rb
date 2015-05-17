class ProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    # @product.image = params[:product][:image]
    @product.save
    render 'show', status: 201
  end

  def update
    product = Product.find(params[:id])
    product.assign_attributes(product_params)
    # product.document = params[:product][:image]
    product.save
    head :no_content
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    head :no_content
  end

  def product_params
    params.require(:product).permit(:name,:description,:quantity,:sku,:price,:image)
  end

end
