class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  
  # GET /categories
  def index
    @categories = current_user.categories.order(:name)
    
    # Разделяем на доходы и расходы для отображения
    @income_categories = @categories.where(category_type: 'income')
    @expense_categories = @categories.where(category_type: 'expense')
  end
  
  # GET /categories/1
  def show
  end
  
  # GET /categories/new
  def new
    @category = current_user.categories.new(category_type: params[:category_type])
  end
  
  # GET /categories/1/edit
  def edit
  end
  
  # POST /categories
  def create
    @category = current_user.categories.new(category_params)
    
    if @category.save
      redirect_to categories_url, notice: 'Категория успешно создана.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to categories_url, notice: 'Категория успешно обновлена.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # DELETE /categories/1
def destroy
  @category.destroy
  redirect_to categories_url, notice: 'Категория удалена.', status: :see_other
end
  
  private
  
  # Находим категорию текущего пользователя
  def set_category
    @category = current_user.categories.find(params[:id])
  end
  
  # Разрешаем параметры (strong parameters)
  def category_params
    params.require(:category).permit(:name, :category_type)
  end
end