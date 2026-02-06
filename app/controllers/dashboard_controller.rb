class DashboardController < ApplicationController
  # Требуем аутентификацию
  before_action :authenticate_user!
  
  # GET / (корневой маршрут)
  def index
    @user = current_user
    
    # Основная статистика
    @total_income = @user.transactions.incomes.sum(:amount)
    @total_expense = @user.transactions.expenses.sum(:amount)
    @balance = @total_income - @total_expense
    
    # Последние транзакции (5 шт)
    @recent_transactions = @user.transactions
                                .includes(:category)
                                .order(date: :desc, created_at: :desc)
                                .limit(5)
    
    # Статистика по месяцам (последние 6 месяцев)
    @monthly_stats = monthly_statistics
    
    # Расходы по категориям (топ-5)
    @expenses_by_category = expenses_by_category
    
    # Доходы по категориям (топ-5)
    @incomes_by_category = incomes_by_category
    
    # Прогресс целей
    @goals = @user.goals.order(deadline: :asc).limit(3)
    
    # Общие цифры
    @transaction_count = @user.transactions.count
    @category_count = @user.categories.count
    @goal_count = @user.goals.count
  end
  
  private
  
  # Статистика по месяцам
  def monthly_statistics
    end_date = Date.current
    start_date = end_date - 5.months
    
    months = (start_date..end_date).map { |d| d.beginning_of_month }.uniq
    
    months.map do |month|
      incomes = current_user.transactions
                           .incomes
                           .where(date: month.beginning_of_month..month.end_of_month)
                           .sum(:amount)
      
      expenses = current_user.transactions
                            .expenses
                            .where(date: month.beginning_of_month..month.end_of_month)
                            .sum(:amount)
      
      {
        month: month.strftime('%B %Y'),
        month_short: month.strftime('%b %Y'),
        incomes: incomes,
        expenses: expenses,
        balance: incomes - expenses
      }
    end
  end
  
  # Расходы по категориям
  def expenses_by_category
    current_user.categories
                .expenses
                .joins(:transactions)
                .group('categories.id', 'categories.name')
                .select('categories.id, categories.name, SUM(transactions.amount) as total')
                .order('total DESC')
                .limit(5)
                .map do |cat|
      {
        id: cat.id,
        name: cat.name,
        total: cat.total.to_f
      }
    end
  end
  
  # Доходы по категориям  
  def incomes_by_category
    current_user.categories
                .incomes
                .joins(:transactions)
                .group('categories.id', 'categories.name')
                .select('categories.id, categories.name, SUM(transactions.amount) as total')
                .order('total DESC')
                .limit(5)
                .map do |cat|
      {
        id: cat.id,
        name: cat.name,
        total: cat.total.to_f
      }
    end
  end
end