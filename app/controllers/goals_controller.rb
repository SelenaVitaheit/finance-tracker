class GoalsController < ApplicationController
  # Требуем аутентификацию для всех действий
  before_action :authenticate_user!
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  
  # GET /goals
  def index
    @goals = current_user.goals
                        .order(deadline: :asc)
    
    # Фильтрация по статусу
    case params[:status]
    when 'active'
      @goals = @goals.where('current_amount < target_amount AND deadline >= ?', Date.today)
    when 'completed'
      @goals = @goals.where('current_amount >= target_amount')
    when 'expired'
      @goals = @goals.where('deadline < ?', Date.today)
    end
    
    # Сортировка - всегда по сроку
   @goals = @goals.order(deadline: :asc)
   end
  
  # GET /goals/1
  def show
  end
  
  # GET /goals/new
  def new
    @goal = current_user.goals.new(
      deadline: Date.today + 1.month,
      current_amount: 0
    )
  end
  
  # GET /goals/1/edit
  def edit
  end
  
  # POST /goals
  def create
    @goal = current_user.goals.new(goal_params)
    
    if @goal.save
      redirect_to @goal, notice: 'Цель успешно создана.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /goals/1
  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: 'Цель успешно обновлена.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  # DELETE /goals/1
  def destroy
    @goal.destroy
    redirect_to goals_url, notice: 'Цель успешно удалена.', status: :see_other
  end
  
  private
  
  # Находим цель текущего пользователя
  def set_goal
    @goal = current_user.goals.find(params[:id])
  end
  
  # Разрешаем параметры (strong parameters)
  def goal_params
    params.require(:goal).permit(
      :title, 
      :target_amount, 
      :current_amount, 
      :deadline,
      :description
    )
  end
end