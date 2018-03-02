class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  # GET /products
  def index
    @products = Product.paginate(page: params[:page], per_page: 5)
  end
  
  # GET /products/new
  def new
    @product = Product.new
  end
  
  
  # GET /products/1/edit
  def edit
    
  end
  
  # PATCH/PUT /products/id
  def update
    if @product.update(product_params)
      flash[:success] = "Product was successfully updated!"
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end
  
  # POST /products
  def create
       @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      flash[:success] = "Product was successfully created!"
      redirect_to product_path(@product)
    else
      render 'new'
    end
  end
  
  # GET /products/id
  def show
   
  end
  
  #DELETE /products/id
  def destroy
    @product.destroy
    flash[:danger] = "Product was successfully deleted!"
    redirect_to product_path
  end
  
  
  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
    
    # Whitelist of params
    def product_params
    params.require(:product).permit(:name, :price)
    end

    def require_same_user
      if current_user != @product.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own products!"
      redirect_to root_path
      end
    end
    
    
end