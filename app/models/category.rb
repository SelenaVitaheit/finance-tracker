class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy
  
  validates :name, presence: true
  validates :category_type, inclusion: { in: %w[income expense] }
  
  # Виртуальный атрибут для отображения
  def display_name
    "#{name} (#{category_type})"
  end
end