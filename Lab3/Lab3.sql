-- 1. INSERT

	-- 1. Без указания списка полей

	INSERT INTO [cookbook]
	VALUES
		('The Keto Diet', 'Leanne Vogel', 200, 100000, '19/12/2018')

	INSERT INTO [cookbook]
	VALUES
		('The Food Lab', 'J. Kenji Lopez-Alt', 100, 150000, '2/1/2020')

	INSERT INTO [cookbook]
	VALUES
		('The Happy Cookbook', 'Steve Doocy', 130, 200000, '16/3/2013')

	INSERT INTO [cookbook]
	VALUES
		('From Scratch', 'Tembi Locke', 200, 75000, '29/2/2016')

	INSERT INTO [cookbook]
	VALUES
		('The Lost Kitchen', 'Erin French', 300, 50000, '15/7/2017')

	INSERT INTO [dish]
	VALUES
		('Fruit salad', 'Salad', 100, 'gr')

	INSERT INTO [dish]
	VALUES
		('Borsh', 'Soup', 250, 'ml')

	INSERT INTO [dish]
	VALUES
		('Meatloaf', 'Snack', 100, 'gr')

	INSERT INTO [dish]
	VALUES
		('Meatballs', 'Snack', 150, 'gr')

	INSERT INTO [dish]
	VALUES
		('Punch', 'Drink', 100, 'ml')

	INSERT INTO [recipe]
	VALUES
		(2, 4, 'cook', 6, 57700)

	-- 2. С указанием списка полей
	INSERT INTO [product]
		(name, type, quantity, unit, price)
	VALUES
		('Limon', 'Fruit', 5, 'kg', 200)
	
	INSERT INTO [product]
		(name, type, quantity, unit, price)
	VALUES
		('Oringe', 'Fruit', 1, 'kg', 500)

	INSERT INTO [product]
		(name, type, quantity, unit, price)
	VALUES
		('Potato', 'Vegetable', 1, 'kg', 40)

	INSERT INTO [product]
		(name, type, quantity, unit, price)
	VALUES
		('Vinegar', 'Liquid', 500, 'ml', 300)

	INSERT INTO [product]
		(name, type, quantity, unit, price)
	VALUES
		('Blackberry', 'Berry', 1, 'kg', 300)

	-- 3. С чтением значения из другой таблицы
	INSERT INTO [cookbook_has_dish]
		(id_cookbook, id_dish)
	SELECT id_cookbook, id_dish FROM [cookbook], [dish]


-- 2. DELETE

	-- 1. Всех записей
	DELETE [recipe]
	
	-- 2. По условию
	DELETE FROM [product]
	WHERE price < 100
	
	-- 3. Очистить таблицу
	TRUNCATE TABLE [cookbook_has_dish]
	

-- 3. UPDATE

	-- 1. Всех записей
	UPDATE [product]
	SET name = 'Oringe',
		quantity = 10
	
	-- 2. По условию обновляя один атрибут
	UPDATE [cookbook]
	SET name = 'Healing Foods',
		author = 'Dale Pinnock'
	WHERE id_cookbook = 1
	
	-- 3. По условию обновляя несколько атрибутов
	UPDATE [product]
	SET quantity = 1
	WHERE unit = 'kg'


-- 4. SELECT

	-- 1. С определенным набором извлекаемых атрибутов
	SELECT name, author FROM [cookbook]
	
	-- 2. Со всеми атрибутами
	SELECT * FROM [product]
	
	-- 3. С условием по атрибуту
	SELECT name, price FROM [product]
	WHERE unit = 'kg'
	

-- 5. SELECT ORDER BY + TOP (LIMIT)

	-- 1. С сортировкой по возрастанию ASC + ограничение вывода количества записей
	SELECT TOP 3 * FROM [product]
	ORDER BY price ASC

	-- 2. С сортировкой по убыванию DESC
	SELECT * FROM [product]
	ORDER BY price DESC
	
	-- 3. С сортировкой по двум атрибутам + ограничение вывода количества записей
	SELECT TOP 3 * FROM [product]
	ORDER BY name ASC, price ASC
	
	-- 4. С сортировкой по первому атрибуту, из списка извлекаемых
	SELECT name, author, copy FROM [cookbook]
	ORDER BY name
	
-- 6. DATETIME 
	
	-- 1. WHERE по дате
	SELECT * FROM [cookbook]
	WHERE (reliase BETWEEN '1/1/2010' AND '1/1/2020')
	
	-- 2. Извлечь из таблицы не всю дату, а только год. Например, год рождения автора.
	SELECT YEAR(reliase) FROM [cookbook]
	

-- 7. SELECT GROUP BY с функциями агрегации

	-- 1. MIN
	SELECT name, MIN(price) FROM [product]
	GROUP BY name

	-- 2. MAX
	SELECT name, MAX(price) FROM [product]
	GROUP BY name
	
	-- 3. AVG
	SELECT name, AVG(price) FROM [product]
	GROUP BY name

	-- 4. SUM
	SELECT name, SUM(price) FROM [product]
	GROUP BY name

	-- 5. COUNT
	SELECT name, COUNT(price) FROM [product]
	GROUP BY name


-- 8. SELECT GROUP BY + HAVING

	-- 1. Написать 3 разных запроса с использованием GROUP BY + HAVING
	SELECT name, MIN(price) FROM [product]
	GROUP BY name
	HAVING MIN(price) > 200
	
	SELECT id_dish FROM [dish]
	GROUP BY id_dish
	HAVING COUNT(*) = 1

	SELECT name FROM [cookbook]
	GROUP BY name
	HAVING SUM(page) >= 200

-- 9. SELECT JOIN

	-- 1. LEFT JOIN двух таблиц и WHERE по одному из атрибутов
	SELECT author, copy FROM [cookbook]
	LEFT JOIN [product]
	ON copy = quantity
	WHERE copy < 100000
	
	-- 2. RIGHT JOIN. Получить такую же выборку, как и в 9.1
	SELECT author, copy FROM [product]
	RIGHT JOIN [cookbook]
	ON quantity = copy
	WHERE copy < 100000

	-- 3. LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
	SELECT id_cookbook, dish.quantity, price FROM [cookbook]
	LEFT JOIN [dish]
	ON cookbook.id_cookbook = dish.id_dish
	LEFT JOIN [product]
	ON cookbook.id_cookbook = product.id_product
	WHERE id_cookbook < 10 AND dish.quantity > 100 AND price < 500
	
	-- 4. FULL OUTER JOIN двух таблиц
	SELECT TOP 1 * FROM [cookbook]
	FULL OUTER JOIN [dish]
	ON id_cookbook = id_cookbook


-- 10. Подзапросы

	-- 1. Написать запрос с WHERE IN (подзапрос)
	SELECT name, copy, reliase FROM [cookbook] WHERE name IN ('The Food Lab')
	
	-- 2. Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...
	SELECT name, copy, (SELECT name FROM [dish] WHERE id_cookbook = id_dish) FROM [cookbook]