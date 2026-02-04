class TransactionsController < ApplicationController
  # Требуем аутентификацию для всех действий
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit, :create, :update]
  
  # GET /transactions
  def index
    # Фильтрация транзакций текущего пользователя
    @transactions = current_user.transactions
                                .includes(:category)
                                .order(date: :desc, created_at: :desc)
    
    # Фильтрация по типу (доход/расход)
    if params[:type].present? && %w[income expense].include?(params[:type])
      @transactions = @transactions.where(transaction_type: params[:type])
    end
    
    # Фильтрация по категории
    if params[:category_id].present?
      @transactions = @transactions.where(category_id: params[:category_id])
    end
    
    # Фильтрация по дате (месяц)
    if params[:month].present?
      month = Date.strptime(params[:month], "%Y-%m")
      @transactions = @transactions.where(date: month.beginning_of_month..month.end_of_month)
    end
    
    # Пагинация (по 20 на страницу)
    @transactions = @transactions.page(params[:page]).per(20)
    
    # Для фильтров
    @categories = current_user.categories.order(:name)
  end
  
  # GET /transactions/1
  def show
  end
  
  # GET /transactions/new
  def new
    @transaction = current_user.transactions.new(
      date: Date.today,
      transaction_type: 'expense'
    )
  end
  
  # GET /transactions/1/edit
  def edit
  end
  
  # POST /transactions
  def create
    @transaction = current_user.transactions.new(transaction_params)
    
    if @transaction.save
      redirect_to @transaction, notice: 'Транзакция успешно создана.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      redirect_to @transaction, notice: 'Транзакция успешно обновлена.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # DELETE /transactions/1
  def destroy
    @transaction.destroy
    redirect_to transactions_url, notice: 'Транзакция успешно удалена.', status: :see_other
  end
  
  private
  
  # Находим транзакцию текущего пользователя
  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end
  
  # Список категорий текущего пользователя
  def set_categories
    @categories = current_user.categories.order(:name)
  end
  
  # Разрешаем параметры (strong parameters)
  def transaction_params
    params.require(:transaction).permit(
      :amount, 
      :date, 
      :description, 
      :transaction_type, 
      :category_id
    )
  end
end