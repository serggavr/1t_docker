CREATE TABLE IF NOT EXISTS author(
    id_author SERIAL PRIMARY KEY,
    full_name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS genre(
    id_genre SERIAL PRIMARY KEY,
    genre_name VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS city(
    id_city SERIAL PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS publisher(
    id_publisher SERIAL PRIMARY KEY,
    name VARCHAR(30),
    id_city INTEGER,
    FOREIGN KEY (id_city) REFERENCES city (id_city) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS address(
    id_address SERIAL PRIMARY KEY,
    id_city INTEGER,
    postcode VARCHAR(20),
    street VARCHAR(100),
    house_number VARCHAR(20),
    apartment_number VARCHAR(20),
    FOREIGN KEY (id_city) REFERENCES city (id_city) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS reader (
    id_reader SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    id_address INTEGER,
    phone VARCHAR(20),
    FOREIGN KEY (id_address) REFERENCES address (id_address) ON DELETE  SET NULL
);

CREATE TABLE IF NOT EXISTS operation_type(
    id_type SERIAL PRIMARY KEY,
    type_name VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS storage(
    id_storage SERIAL PRIMARY KEY,
    rack_number INTEGER,
    shelf_number INTEGER
);

CREATE TABLE IF NOT EXISTS book (
    id_book SERIAL PRIMARY KEY,
    id_publisher INTEGER,
    id_storage INTEGER,
    name VARCHAR(50),
    publishing_year DATE,
    pages_number INTEGER,
    price FLOAT(2),
    FOREIGN KEY (id_publisher) REFERENCES publisher (id_publisher) ON DELETE SET NULL,
    FOREIGN KEY (id_storage) REFERENCES storage (id_storage) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS authors (
    id SERIAL PRIMARY KEY,
    id_book INTEGER,
    id_author INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book) ON DELETE SET NULL,
    FOREIGN KEY (id_author) REFERENCES author (id_author) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS genres (
    id SERIAL PRIMARY KEY,
    id_book INTEGER,
    id_genre INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book) ON DELETE SET NULL,
    FOREIGN KEY (id_genre) REFERENCES genre (id_genre) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS operation (
    id_operation SERIAL PRIMARY KEY,
    id_book INTEGER,
    id_reader INTEGER,
    id_type INTEGER,
    date DATE,
    FOREIGN KEY (id_book) REFERENCES book (id_book) ON DELETE SET NULL,
    FOREIGN KEY (id_reader) REFERENCES reader (id_reader) ON DELETE SET NULL,
    FOREIGN KEY (id_type) REFERENCES operation_type (id_type) ON DELETE SET NULL
);


INSERT INTO  storage (id_storage, rack_number, shelf_number)
VALUES (1, 1, 1),
       (2, 1, 2),
       (3, 1, 3);

INSERT INTO city (id_city, city)
VALUES (1, 'Москва'),
       (2, 'Санкт Петербург');

INSERT INTO publisher (id_publisher, id_city, name)
VALUES (1, 1, 'АСТ'),
       (2, 1, 'Эксмо'),
       (3, 2, 'Азбука');

INSERT INTO author (id_author, full_name)
VALUES (1, 'Пушкин А.С'),
       (2, 'Лермонтов М.Ю'),
       (3, 'Толстой Л.Н'),
       (4, 'Оруэлл Дж'),
       (5, 'Маркс К');

INSERT INTO genre (id_genre, genre_name)
VALUES (1, 'Роман'),
       (2, 'Поэма'),
       (3, 'Драма'),
       (4, 'Сказка'),
       (5, 'Проза'),
       (6, 'Философия');

INSERT INTO book (id_book, id_publisher, id_storage, name, publishing_year, pages_number, price)
VALUES (1, 1, 1, 'Война и мир', '1877-01-01', 1300, 1200),
       (2, 1, 1, 'Анна Каренина', '1869-01-01', 864, 1000),
       (3, 2, 3, '1984', '1948-01-01', 320, 600),
       (4, 2, 3, 'Хаджи-Мурат', '1952-01-01', 700, 800),
       (5, 3, 2, 'Капитал', '1867-01-01', 960, 300 ),
       (6, 3, 2, 'Руслан и Людмила', '1820-01-01', 264, 500 ),
       (7, 3, 2, 'Пир во время чумы', '1867-01-01', 20, 140 ),
       (8, 3, 2, 'Сказка о попе и о работнике его Балде', '1830-01-01', 20, 200 ),
       (9, 3, 2, 'Пиковая дама', '1834-01-01', 200, 500 ),
       (10, 3, 2, 'Скотный двор', '1944-01-01', 260, 500 );

INSERT INTO authors (id_book, id_author)
VALUES (1, 3),
       (2, 3),
       (3, 4),
       (4, 3),
       (5, 5),
       (6, 1),
       (7, 1),
       (8, 1),
       (9, 1);

INSERT INTO genres ( id_book, id_genre)
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 2),
       (5, 6),
       (6, 2),
       (7, 3),
       (8, 4),
       (9, 5);

INSERT INTO address (id_address, id_city, postcode, street, house_number, apartment_number)
VALUES (1, 1, 101000, 'Ленина', '5', '45'),
       (2, 1, 101000, 'Авангардная', '5', '4'),
       (3, 1, 101000, 'Калужская', '8а', '1'),
       (4, 1, 101000, 'Палехская', '7 кор.2', '13'),
       (5, 1, 101000, 'Оршанская', '4', '12'),
       (6, 1, 101000, 'Охотничья', '5', '11'),
       (7, 1, 101000, 'Ремизова', '4', '69'),
       (8, 1, 101000, 'Сперанского', '3', '58'),
       (9, 2, 187015, 'Токарная', '2', '47'),
       (10, 2, 187015, 'Федорова', '1', '46');

INSERT INTO operation_type (id_type, type_name)
VALUES (1, 'Выдача'),
       (2, 'Возврат');

INSERT INTO reader (id_reader, full_name, id_address, phone)
VALUES (1, 'Иванов И.И', 1, '89998887788'),
       (2, 'Иванова А.К', 1, '89999999914'),
       (3, 'Гусев А.Ф', 2, '89999999915'),
       (4, 'Уткин Б.Б', 3, '89999999916'),
       (5, 'Селезнев В.Ф', 4, '89999999917'),
       (6, 'Воробьев Г.К', 5, '89999999918'),
       (7, 'Голубев Д.В', 6, '89999999919'),
       (8, 'Глухарев Е.Ы', 7, '89999999920'),
       (9, 'Чайка С.У', 8, '89999999921'),
       (10, 'Петухов П.И', 9, '89999999922'),
       (11, 'Петров С.В', 10, '89999999923'),
       (12, 'Петрова М.В', 10, '89999999924');

INSERT INTO operation ( id_book, id_reader, id_type, date)
VALUES (1, 1, 1, '2023-02-12'),
       (1, 1, 2, '2023-02-15'),
       (2, 2, 1, '2023-02-13'),
       (2, 2, 2, '2023-02-16'),
       (3, 3, 1, '2023-03-14'),
       (3, 3, 2, '2023-03-14'),
       (4, 4, 1, '2023-04-15'),
       (4, 4, 2, '2023-04-16'),
       (5, 5, 1, '2023-05-12'),
       (5, 5, 2, '2023-05-12'),
       (6, 6, 1, '2023-06-10'),
       (6, 6, 2, '2023-06-11'),
       (7, 7, 1, '2023-06-11'),
       (7, 7, 2, '2023-06-11'),
       (8, 1, 1, '2023-06-11'),
       (8, 1, 2, '2023-06-11'),
       (9, 10, 1, '2023-06-12'),
       (9, 10, 2, '2023-06-12'),
       (1, 11, 1, '2023-06-12'),
       (1, 11, 2, '2023-06-13'),
       (2, 1, 1, '2023-06-14'),
       (2, 1, 2, '2023-06-14'),
       (3, 2, 1, '2023-06-15'),
       (4, 2, 1, '2023-06-16'),
       (10, 3, 1, '2023-06-17');

