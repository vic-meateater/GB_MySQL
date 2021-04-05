/*1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
 * Заполните их текущими датой и временем.*/	

UPDATE users SET created_at = NOW(), updated_at = NOW();

/*2. Таблица users была неудачно спроектирована.Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались 
 * значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, 
 * сохранив введённые ранее значения.*/

ALTER TABLE users ADD created_at_tmp DATETIME, updated_at_tmp DATETIME;
UPDATE users 
SET created_at_tmp = STR_TO_DATE(created_at, '%Y-%m-%d %H:%i:%s'),
SET updated_at_tmp = STR_TO_DATE(updated_at, '%Y-%m-%d %H:%i:%s');
ALTER TABLE users DROP created_at, updated_at, 
RENAME COLUMN created_at_tmp TO created_at, 
RENAME COLUMN updated_at_tmp TO updated_at;


/*3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
 * если товар закончился и выше нуля, если на складе имеются запасы. 
 * Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
 * Однако нулевые запасы должны выводиться в конце, после всех записей.*/

INSERT INTO
    storehouses (name)
VALUES ('Основоной склад');

INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 1),
    (1, 2, 16),
    (1, 3, 9),
    (1, 4, 5),
    (1, 5, 0),
    (1, 6, 0),
    (1, 7, 50);
   
SELECT 
    value
FROM
    storehouses_products 
    ORDER BY IF (value > 0, 0, 1), value ;

/*4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
 * Месяцы заданы в виде списка английских названий (may, august)*/
   
SELECT * FROM users WHERE MONTHNAME(birthday_at) = 'may' OR MONTHNAME(birthday_at) = 'august';



/*(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 * Отсортируйте записи в порядке, заданном в списке IN.*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
ORDER BY CASE
    WHEN id = 5 THEN 0
    WHEN id = 1 THEN 1
    WHEN id = 2 THEN 2
END;

/*Подсчитайте средний возраст пользователей в таблице users.*/
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0) FROM users;



/*Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 *Следует учесть, что необходимы дни недели текущего года, а не года рождения*/

SELECT 
	DAYNAME(DATE_FORMAT(birthday_at, CONCAT(YEAR(NOW()),'-%m-%d'))) AS day_of_birth, 
	COUNT(*) AS total_days 
FROM 
	users 
GROUP BY 
	day_of_birth 
ORDER BY 
	total_days;



