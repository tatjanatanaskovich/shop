class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @products = Product.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @product = Product.new
  end
  
  def edit
    
  end
  
  def update
   
    if @product.update(product_params)
      flash[:success] = "Product was successfully updated!"
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end
  
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
  
  def show
   
  end
  
  def destroy
    
    @product.destroy
    flash[:danger] = "Product was successfully deleted!"
    redirect_to product_path
  end
  
  
  private
  
    def set_product
      @product = Product.find(params[:id])
    end
    
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