class ProductsController < ApiController
  before_action :authenticate_user
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all

    render json: @products, :each_serializer => Products::SearchSerializer
  end

  # GET /products/1
  def show
    if @product
      render json: @product ,:serializer => Products::ShowSerializer
    else
      render json: @product, status:  :not_found
    end
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product ,:serializer => Products::ShowSerializer
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  def search
    if (params.has_key?(:seraching_word))
      @products = Product.find_by({name: params[:seraching_word]})
      if @products
        render json: @products , status: :ok , :serializer => Products::SearchSerializer
      else
        @products = Product.where({name: /#{params[:seraching_word]}/i})
        render json: @products , status: :ok , :each_serializer => Products::SearchSerializer
      end
    else
      render json: {} , status: :not_found
    end
  end

  def searchqr
    if (params.has_key?(:seraching_qr))
        @product = Product.find_by({qr_code: params[:seraching_qr]})
        if @product
          render json: @product , status: :ok , :serializer => Products::SearchSerializer
        else
          render json: {} , status: :not_found
        end
    end
  end

  def pagination
    @products = Product.all
    @products = @products[params[:start].to_i..params[:end].to_i]
    if @products
      render json: @products , status: :ok , :each_serializer => Products::SearchSerializer
    else
      render json: {status:"no Results found"}
    end
  end

  def Blockedusers
    if User.where({'fakes' => {'$gt' => 30}}).delete
      render json: {} , status: :ok
    else
      render json: {} , status: :not_modified
    end
  end

  def DropFakePrices
    Price.where({})
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name,:qr_code)
    end
end
