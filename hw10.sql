DROP DATABASE IF EXISTS skyeng;
CREATE DATABASE skyeng;

USE skyeng;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(255) COMMENT 'Имя пользователя',
	last_name VARCHAR(255) COMMENT 'Фамилия пользователя',
	birthday_at DATE COMMENT 'Дата рождения',
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	email VARCHAR(120) COMMENT 'Email пользователя',
  	phone BIGINT COMMENT 'Номер телефона пользователя',
  	photo_id BIGINT UNSIGNED,
  	status_id INT UNSIGNED COMMENT 'Статус ученик - учитель',
  	KEY index_of_status_id (status_id)
)

describe users;