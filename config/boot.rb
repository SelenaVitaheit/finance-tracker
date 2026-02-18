ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.

#Bundler — это менеджер зависимостей для Ruby. Он:
#•	Читает Gemfile
#•	Устанавливает нужные гемы
#•	Следит за версиями
#•	Подключает их перед запуском приложения

