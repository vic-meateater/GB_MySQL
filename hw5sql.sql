/*
1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
Заполните их текущими датой и временем.
*/	

UPDATE users SET created_at = NOW(), updated_at = NOW();

/*
2. Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались 
значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, 
сохранив введённые ранее значения.
*/

ALTER TABLE users ADD created_at_tmp DATETIME, updated_at_tmp DATETIME;
UPDATE users 
SET created_at_tmp = STR_TO_DATE(created_at, '%Y-%m-%d %H:%i:%s'),
SET updated_at_tmp = STR_TO_DATE(updated_at, '%Y-%m-%d %H:%i:%s');
ALTER TABLE users DROP created_at, updated_at, 
RENAME COLUMN created_at_tmp TO created_at, 
RENAME COLUMN updated_at_tmp TO updated_at;
