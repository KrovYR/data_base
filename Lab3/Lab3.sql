
-- 1. INSERT

	-- 1. ��� �������� ������ �����

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

	-- 2. � �������� ������ �����
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

	-- 3. � ������� �� ������ �������
	INSERT INTO [cookbook_has_dish]
		(id_cookbook, id_dish)
	SELECT id_cookbook, id_dish FROM [cookbook], [dish]


-- 2. DELETE

	-- 1. ���� �������
	DELETE [recipe]
	
	-- 2. �� �������
	DELETE FROM [product]
	WHERE price < 100
	
	-- 3. �������� �������
	TRUNCATE TABLE [cookbook_has_dish]
	

-- 3. UPDATE

	-- 1. ���� �������
	UPDATE [product]
	SET name = 'Oringe',
		quantity = 10
	
	-- 2. �� ������� ���� �������
	UPDATE [cookbook]
	SET name = 'Healing Foods',
		author = 'Dale Pinnock'
	WHERE id_cookbook = 1
	
	-- 3. �� ������� �������� ��������� ���������
	UPDATE [product]
	SET quantity = 1
	WHERE unit = 'kg'


-- 4. SELECT

	-- 1. � ������������ ������� ����������� ���������
	SELECT name, author FROM [cookbook]
	
	-- 2. �� ����� ����������
	SELECT * FROM [product]
	
	-- 3. � �������� �� ��������
	SELECT name, price FROM [product]
	WHERE unit = 'kg'
	

-- 5. SELECT ORDER BY + TOP (LIMIT)

	-- 1. � ����������� �� ����������� ASC + ���������� ������ ���������� �������
	SELECT TOP 3 * FROM [product]
	ORDER BY price ASC

	-- 2. � ����������� �� �������� DESC
	SELECT * FROM [product]
	ORDER BY price DESC
	
	-- 3. � ����������� �� ���� ��������� + ���������� ������ ���������� �������
	SELECT TOP 3 * FROM [product]
	ORDER BY name ASC, price ASC
	
	-- 4. � ����������� �� ������� ��������, �� ������ �����������
	SELECT name, author, copy FROM [cookbook]
	ORDER BY name
	
-- 6. DATETIME 
	
	-- 1. WHERE �� ����
	SELECT * FROM [cookbook]
	WHERE (reliase BETWEEN '1/1/2010' AND '1/1/2020')
	
	-- 2. ������� �� ������� �� ��� ����, � ������ ���. ��������, ��� �������� ������.
	SELECT YEAR(reliase) FROM [cookbook]
	

-- 7. SELECT GROUP BY � ��������� ���������

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

	-- 1. �������� 3 ������ ������� � �������������� GROUP BY + HAVING
	SELECT name, MIN(price) FROM [product]
	GROUP BY name
	HAVING MIN(price) > 200
	
	SELECT name, MAX(price) FROM [product]
	GROUP BY name
	HAVING MAX(price) < 300

	SELECT name, AVG(price) FROM [product]
	GROUP BY name
	HAVING AVG(price) <= 300
	

-- 9. SELECT JOIN

	-- 1. LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
	SELECT author, copy FROM [cookbook]
	LEFT JOIN [product]
	ON copy = quantity
	WHERE copy < 100000
	
	-- 2. RIGHT JOIN. �������� ������� �������, ��� � � 5.1
	SELECT TOP 3 id_product, product.name, type, quantity, unit, price FROM [product]
	RIGHT JOIN [cookbook]
	ON id_cookbook = id_product
	ORDER BY price ASC

	-- 3. LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
	SELECT id_cookbook, dish.quantity, price FROM [cookbook]
	LEFT JOIN [dish]
	ON cookbook.id_cookbook = dish.id_dish
	LEFT JOIN [product]
	ON cookbook.id_cookbook = product.id_product
	WHERE id_cookbook < 10 AND dish.quantity > 100 AND price < 500
	
	-- 4. FULL OUTER JOIN ���� ������
	SELECT TOP 1 * FROM [cookbook]
	FULL OUTER JOIN [dish]
	ON id_cookbook = id_cookbook


-- 10. ����������

	-- 1. �������� ������ � WHERE IN (���������)
	SELECT name, copy, reliase FROM [cookbook] WHERE name IN ('The Food Lab')
	
	-- 2. �������� ������ SELECT atr1, atr2, (���������) FROM ...    
	SELECT name, copy, (SELECT name FROM [dish] WHERE id_cookbook = id_dish) FROM [cookbook]