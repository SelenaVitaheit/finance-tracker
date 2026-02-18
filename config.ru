# Rack — это прослойка между веб-сервером и Ruby-приложением. Он:
#•	Принимает HTTP-запрос
#•	Превращает его в удобный для Ruby формат
#•	Передаёт в Rails
#•	Получает ответ
#•	Отдаёт обратно серверу


require_relative "config/environment"

run Rails.application
Rails.application.load_server
