class Api::V1::ProductsController < ActionController::API
  def index
    @products = Product.all
    render json: @products
  end

  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  def create
    scrapper = ScrapperService.new(params[:url])
    product_data = scrapper.scrape_and_save
    if product_data[:error]
      render json: { error: product_data[:error] }, status: :unprocessable_entity
    else
      product = Product.new(product_data)
      if product.save
        render json: product, status: :created
      else
        render json: product.errors, status: :unprocessable_entity
      end
    end
  end
end