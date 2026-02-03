class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :transaction_type, inclusion: { in: %w[income expense] }
  
  # Callback для автоматической установки типа транзакции из категории
  before_validation :set_transaction_type_from_category, if: -> { category.present? }
  
  # Scope для фильтрации
  scope :incomes, -> { where(transaction_type: 'income') }
  scope :expenses, -> { where(transaction_type: 'expense') }
  scope :recent, -> { order(date: :desc) }
  
  # Метод для отображения суммы с типом
  def display_amount
    if transaction_type == 'income'
      "+#{amount}"
    else
      "-#{amount}"
    end
  end
  
  private
  
  def set_transaction_type_from_category
    self.transaction_type = category.category_type if transaction_type.blank?
  end
end