/*
 * Транзакции, переменные, представления
 */

/*
 * Задание 1
 * В базе данных shop и sample присутствуют одни и те же таблицы, 
 * учебной базы данных. Переместите запись id = 1 из таблицы shop.users 
 * в таблицу sample.users. Используйте транзакции.
 */

DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;

USE SAMPLE;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

START TRANSACTION;
INSERT INTO sample.users SELECT * from shop.users WHERE id = 1;
COMMIT;

/*
 * Задание 2
 * Создайте представление, которое выводит название name товарной позиции 
 * из таблицы products и соответствующее название каталога name 
 * из таблицы catalogs.
 */

USE shop;

CREATE OR REPLACE VIEW prod_cat AS
SELECT products.name AS prod_name, catalogs.name AS cat_name FROM products INNER JOIN catalogs ON products.catalog_id = catalogs.id;

/*
 * Хранимые процедуры и функции, триггеры
 */

/*
 * Задание 1
 * Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
 * в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
 * возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
 * фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — 
 * "Доброй ночи".
 */

delimiter //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello ()
RETURNS TEXT DETERMINISTIC
BEGIN
	SET @time = DATE_FORMAT(NOW(), '%H:%i');
	IF (@time < '06:00') THEN
		RETURN 'Доброй ночи';
	END IF;
	IF (@time >= '06:00' AND @time < '12:00') THEN
		RETURN 'Доброе утро';
	END IF;
	IF (@time >= '12:00' AND @time < '18:00') THEN
		RETURN 'Добрый день';
	END IF;
	IF (@time >= '18:00' AND @time <= '23:59') THEN
		RETURN 'Добрый вечер';
	END IF;
END//

SELECT hello()//

/*
 * Задание 2
 * В таблице products есть два текстовых поля: name с названием товара 
 * и description с его описанием. Допустимо присутствие обоих полей или одно 
 * из них. Ситуация, когда оба поля принимают неопределенное значение NULL 
 * неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей 
 * или оба поля были заполнены. При попытке присвоить полям NULL-значение 
 * необходимо отменить операцию.
 */

delimiter //

CREATE TRIGGER validate_insert_name_and_description BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL THEN 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Both name and description are NULL';
	END IF;
END//

