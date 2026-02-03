# Очищаем базу (осторожно! только для разработки)
puts "Очищаем базу данных..."
User.destroy_all

# Создаем тестового пользователя
puts "Создаем пользователя..."
user = User.create!(
  email: "test@example.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "Пользователь создан: #{user.email} / password123"

# Создаем категории
puts "Создаем категории..."
categories_data = [
  { name: "Зарплата", category_type: "income" },
  { name: "Фриланс", category_type: "income" },
  { name: "Инвестиции", category_type: "income" },
  { name: "Еда", category_type: "expense" },
  { name: "Транспорт", category_type: "expense" },
  { name: "Жилье", category_type: "expense" },
  { name: "Развлечения", category_type: "expense" },
  { name: "Здоровье", category_type: "expense" },
  { name: "Образование", category_type: "expense" }
]

categories = categories_data.map do |cat_attrs|
  user.categories.create!(cat_attrs)
end

puts "Создано #{categories.count} категорий"

# Создаем транзакции (доходы и расходы)
puts "Создаем транзакции..."
income_categories = categories.select { |c| c.category_type == "income" }
expense_categories = categories.select { |c| c.category_type == "expense" }

# Доходы
5.times do |i|
  user.transactions.create!(
    amount: rand(20000..100000),
    date: Date.today - rand(30).days,
    description: "Доход #{i + 1}",
    transaction_type: "income",
    category: income_categories.sample
  )
end

# Расходы
15.times do |i|
  user.transactions.create!(
    amount: rand(100..20000),
    date: Date.today - rand(30).days,
    description: "Расход #{i + 1}",
    transaction_type: "expense",
    category: expense_categories.sample
  )
end

puts "Создано #{user.transactions.count} транзакций"

# Создаем цели
puts "Создаем цели..."
goals_data = [
  {
    title: "Накопить на отпуск",
    target_amount: 150000,
    current_amount: 45000,
    deadline: Date.today + 6.months
  },
  {
    title: "Новый ноутбук",
    target_amount: 80000,
    current_amount: 25000,
    deadline: Date.today + 3.months
  },
  {
    title: "Резервный фонд",
    target_amount: 300000,
    current_amount: 120000,
    deadline: Date.today + 1.year
  }
]

goals_data.each do |goal_attrs|
  user.goals.create!(goal_attrs)
end

puts "Создано #{user.goals.count} целей"

# Итог
puts "\n=== База заполнена! ==="
puts "Пользователь: #{user.email} (password: password123)"
puts "Категории: #{user.categories.count} шт."
puts "Транзакции: #{user.transactions.count} шт."
puts "Цели: #{user.goals.count} шт."
puts "========================="