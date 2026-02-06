module ApplicationHelper
  # Форматирование денег с цветом в зависимости от типа
  def format_money(amount, type = nil)
    color_class = if type == 'income'
                    'text-success'
                  elsif type == 'expense'
                    'text-danger'
                  elsif amount >= 0
                    'text-success'
                  else
                    'text-danger'
                  end
    
    content_tag(:span, class: color_class) do
      number_to_currency(amount, unit: '₽', format: '%n %u')
    end
  end
  
  # Процент прогресса с цветом
  def progress_bar(percentage, options = {})
    color = case percentage
            when 0..30 then 'danger'
            when 31..70 then 'warning'
            when 71..90 then 'info'
            else 'success'
            end
    
    height = options[:height] || '20px'
    
    content_tag(:div, class: 'progress', style: "height: #{height}") do
      content_tag(:div, 
        class: "progress-bar bg-#{color}", 
        role: 'progressbar',
        style: "width: #{percentage}%",
        'aria-valuenow': percentage,
        'aria-valuemin': 0,
        'aria-valuemax': 100) do
        "#{percentage.round}%"
      end
    end
  end
  
  # Форматирование даты
  def format_date(date)
    date.strftime('%d.%m.%Y')
  end
  
  # Сокращение больших чисел
  def humanize_number(number)
    if number >= 1_000_000
      "#{(number / 1_000_000.0).round(1)}M"
    elsif number >= 1_000
      "#{(number / 1_000.0).round(1)}K"
    else
      number.to_i.to_s
    end
  end
  
  # Активный пункт меню
  def nav_link(text, path, options = {})
    active = current_page?(path) ? 'active' : ''
    options[:class] = "#{options[:class]} nav-link #{active}"
    
    link_to text, path, options
  end
end