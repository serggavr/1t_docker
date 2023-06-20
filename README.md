Инициализация базы данных "Библиотека"

Запуск: `docker-compose up`

Запросы к БД:  
1) Определить, сколько книг прочитал каждый читатель в текущем году. Вывести рейтинг читателей по убыванию.  
```sql
SELECT operation.id_reader, reader.full_name, count(operation.id_reader) AS rate FROM operation 
INNER JOIN reader ON operation.id_reader = reader.id_reader
WHERE operation.id_type = 2 
AND operation.date > '2023-01-01' 
AND operation.id_book IN (SELECT id_book FROM operation 
		WHERE id_type = 1 
		AND operation.date > '2023-01-01') 
GROUP BY operation.id_reader, reader.full_name
ORDER BY rate DESC
```  
2) Определить, сколько книг у читателей на руках на текущую дату  
```sql
SELECT count(id_book) AS not_returned_books FROM (
	SELECT id_book, id_reader FROM operation
		WHERE id_type = 1
	EXCEPT 
	SELECT id_book, id_reader FROM operation
		WHERE id_type = 2
	GROUP BY id_book, id_reader
) AS not_returned_books
``` 

Схема БД: ![Схема БД "Библиотека""](theLibrary.jpeg)




