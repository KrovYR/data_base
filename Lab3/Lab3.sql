-- 1. INSERT

	-- 1. Без указания списка полей
	INSERT INTO [cookbook]
	VALUES
		('The Keto Diet', 'Leanne Vogel', 200, 100000)

	-- 2. С указанием списка полей
	INSERT INTO [product]
		(name, type, quantity, unit, price)
	VALUES
		('Limon', 'Fruit', 5, 'kg', 500)

	-- 3. С чтением значения из другой таблицы
	INSERT INTO [cookbook_has_dish]
		(id_cookbook, id_dish)
	SELECT id_cookbook, id_dish FROM [cookbook], [dish]


-- 2. DELETE

	-- 1. Всех записей
	DELETE [product]

	-- 2. По условию
	DELETE FROM [cookbook]
	WHERE page < 500

	-- 3. Очистить таблицу
	TRUNCATE TABLE [cookbook_has_dish]


-- 3. UPDATE

	-- 1. Всех записей
	UPDATE [product]
	SET name = 'Oringe',
		quantity = 10

	-- 2. По условию обновляя один атрибут
	UPDATE [cookbook]
	SET name = 'The Food Lab',
		author = 'J.Kenji'
	WHERE id_cookbook = 2

	-- 3. По условию обновляя несколько атрибутов
	UPDATE [product]
	SET quantity = 1
	WHERE quantity > 1


-- 4. SELECT

	-- 1. С определенным набором извлекаемых атрибутов
	SELECT name, author FROM [cookbook]

	-- 2. Со всеми атрибутами
	SELECT * FROM [product]

	-- 3. С условием по атрибуту
	SELECT name FROM [product]
	WHERE id_product = 3


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
	WHERE (release BETWEEN '1/1/2010' AND '1/1/2020')

	-- 2. Извлечь из таблицы не всю дату, а только год. Например, год рождения автора.
	SELECT YEAR(release) FROM [cookbook]


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

	SELECT name, MAX(price) FROM [product]
	GROUP BY name
	HAVING MAX(price) < 400

	SELECT name, AVG(price) FROM [product]
	GROUP BY name
	HAVING AVG(price) <= 400


-- 9. SELECT JOIN

	-- 1. LEFT JOIN двух таблиц и WHERE по одному из атрибутов
	SELECT author, copy FROM [cookbook]
	LEFT JOIN [product]
	ON copy = quantity
	WHERE copy < 25000

	-- 2. RIGHT JOIN. Получить такую же выборку, как и в 5.1
	SELECT TOP 3 id_product, product.name, type, quantity, unit, price FROM [product]
	RIGHT JOIN [cookbook]
	ON product.id_product = cookbook.id_cookbook + 3
	ORDER BY price ASC

	-- 3. LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
	SELECT id_cookbook, complexity, price FROM [cookbook]
	LEFT JOIN [recipe]
	ON cookbook.id_cookbook = recipe.id_recipe
	LEFT JOIN [product]
	ON cookbook.id_cookbook = product.id_product - 3
	WHERE id_cookbook < 10 AND complexity > 1 AND price < 500

	-- 4. FULL OUTER JOIN двух таблиц
	SELECT TOP 1 * FROM [cookbook]
	FULL OUTER JOIN [recipe]
	ON id_cookbook = id_recipe


-- 10. Подзапросы

	-- 1. Написать запрос с WHERE IN (подзапрос)
	SELECT name, copy FROM [cookbook] WHERE name IN ('Fish')

	-- 2. Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...    
	SELECT name, copy FROM [cookbook] WHERE id_cookbook IN (SELECT id_product FROM [product])