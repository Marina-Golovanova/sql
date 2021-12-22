/* Задача 2
Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name. */

CREATE DATABASE IF NOT EXISTS example;

USE example;

CREATE TABLE IF NOT EXISTS users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя пользователя'
);

/* Задача 3
 * Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
 * 
 * mysqldump example > example.sql */

CREATE DATABASE IF NOT EXISTS sample;

/* mysql sample < example.sql */

/* Задача 4
 * Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
 * 
 * mysqldump --opt --where="1 limit 100" mysql help_keyword > mysql.sql
 */