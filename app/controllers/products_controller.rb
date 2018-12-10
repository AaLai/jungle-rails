class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
    @user_review = @product.reviews.find_by user_id: "#{current_user.id}"
  end

end
