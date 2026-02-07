class Goal < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 100 }
  validates :target_amount, presence: true, numericality: { greater_than: 0 }
  validates :current_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :deadline, presence: true
  validates :description, length: { maximum: 500 }
  # Валидация: deadline не может быть в прошлом
  validate :deadline_cannot_be_in_the_past
  
  # Вычисление прогресса в процентах
  def progress_percentage
    return 0 if target_amount.zero?
    ((current_amount / target_amount) * 100).round(2)
  end
  
  # Проверка выполнена ли цель
  def completed?
    current_amount >= target_amount
  end
  
  # Сколько осталось накопить
  def amount_remaining
    [target_amount - current_amount, 0].max
  end
  
  # Дней до дедлайна
  def days_remaining
    return 0 if deadline.past?
    (deadline - Date.today).to_i
  end
  
  private
  
  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline < Date.today
      errors.add(:deadline, "не может быть в прошлом")
    end
  end
end