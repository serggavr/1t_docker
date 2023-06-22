Инициализация базы данных "Библиотека"

Запуск: `docker-compose up`

Задача:  


 Доработать структуру БД «Библиотека» на предмет хранения дополнительной информации о книгах, которые были утеряны. Информация о потерянных книгах должна содержать:
книга, которая была утеряна дата потери читатель, который потерял книгу.

- Напишите sql запрос, который определяет, терял ли определенный читатель книги.

- При потере книг количество доступных книг фонда меняется. Напишите sql запрос на обновление соответствующей информации.

- Определить сумму потерянных книг по каждому кварталу в течение года.

Дополнительная информация к заданию:  
Книга считается на руках, если не указана дата возврата книги.  
Должником является читатель, который не возвратил книгу в течение 2-х недель.  
Книга считается прочитанной, если она была взята и сдана.  


Решение:  
В сущность `book` добавим поле `is_available` с типом данных *boolean* хранящую информацию о доступности книги.
По умолчанию, у всех книг `is_available = true`.  
У нас есть сущность `operation`, которая хранит операции с 
книгами, в нее будем записывать потерю книги. Для этого нам в `operation_type` необходимо добавить тип операции 'Утрачена' с `id_type = 3`. 
Все остальные задачи решаются запросами:  
- Напишите sql запрос, который определяет, терял ли определенный читатель книги:
```sql
SELECT * FROM operation
WHERE id_reader = 1
AND id_type = 3
```  
- При потере книг количество доступных книг фонда меняется. Напишите sql запрос на обновление соответствующей информации:
```sql
--обновляем `is_available` на `false` у книг, которые были утеряны:
update book set is_available = false
where id_book in (
		select id_book from operation
		where id_type = 3
		);
--выбираем только доступные книги
select * from public.book
where book.is_available = true
```  
- Определить сумму потерянных книг по каждому кварталу в течение года:
```sql
--Сумма потерь в течении текущего года, and extract(year from date) = extract(year from now()),
--еслу убрать строку, будут выведены данные за все время, вместо extract(year from now()) можно
--посдтавить необходимый год.  

select
	extract(year from date) as year,
	extract(quarter from date) as quarter,
	sum(book.price)
from operation
inner join book on book.id_book = operation.id_book 
where id_type = 3
and extract(year from date) = extract(year from now())
group by quarter, year
```

Схема БД: ![Схема БД "Библиотека""](theLibrary.jpeg)




