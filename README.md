# Logger-collector
Программа, которая собирает данные с температурных датчиков в сводную таблицу
Для работы необходимо извечь текст из pdf в txt файл. По оригинальной задумке, файл с всеми pdf назван svalka.txt
В код загружены все возможные вариации ключевых слов, по которым программа ищет нужные данные (Температурный минимум, максимум, и т.д.)
В начале работы программа должна пробежать по свалке и выгрузить оттуда все данные в тип. файл base
Далее в отдельный текстовый файл выписываем номера датчиков, которые мы хотим добавить в таблицу
Потом программа пробегает по этому файлу и ищет совпадения по номерам в типизированном файле и файле с номерами
Дальше идет выгрузка в внутреннюю таблицу
Теперь можно выгрузить таблицу как в эксель, так и в txt (выгрузка в txt морально устарела)
