-- 1. INSERT

	-- 1. ��� �������� ������ �����
	INSERT INTO [cookbook]
	VALUES
		('The Keto Diet', 'Leanne Vogel', 200, 100000)

	-- 2. � ��������� ������ �����
	INSERT INTO [product]
		(name, type, quantity, unit, price)
	VALUES
		('Limon', 'Fruit', 5, 'kg', 500)

	-- 3. � ������� �������� �� ������ �������
	INSERT INTO [cookbook_has_dish]
		(id_cookbook, id_dish)
	SELECT id_cookbook, id_dish FROM [cookbook], [dish]


-- 2. DELETE

	-- 1. ���� �������
	DELETE [product]

	-- 2. �� �������
	DELETE FROM [cookbook]
	WHERE page < 500

	-- 3. �������� �������
	TRUNCATE TABLE [cookbook_has_dish]


-- 3. UPDATE

	-- 1. ���� �������
	UPDATE [product]
	SET name = 'Oringe',
		quantity = 10

	-- 2. �� ������� �������� ���� �������
	UPDATE [cookbook]
	SET name = 'The Food Lab',
		author = 'J.Kenji'
	WHERE id_cookbook = 2

	-- 3. �� ������� �������� ��������� ���������
	UPDATE [product]
	SET quantity = 1
	WHERE quantity > 1


-- 4. SELECT

	-- 1. � ������������ ������� ����������� ���������
	SELECT name, author FROM [cookbook]

	-- 2. �� ����� ����������
	SELECT * FROM [product]

	-- 3. � �������� �� ��������
	SELECT name FROM [product]
	WHERE id_product = 3


-- 5. SELECT ORDER BY + TOP (LIMIT)

	-- 1. � ����������� �� ����������� ASC + ����������� ������ ���������� �������
	SELECT TOP 3 * FROM [product]
	ORDER BY price ASC

	-- 2. � ����������� �� �������� DESC
	SELECT * FROM [product]
	ORDER BY price DESC

	-- 3. � ����������� �� ���� ��������� + ����������� ������ ���������� �������
	SELECT TOP 3 * FROM [product]
	ORDER BY name ASC, price ASC

	-- 4. � ����������� �� ������� ��������, �� ������ �����������
	SELECT name, author, copy FROM [cookbook]
	ORDER BY name

-- 6. DATETIME 
	
	-- 1. WHERE �� ����
	SELECT * FROM [cookbook]
	WHERE (release BETWEEN '1/1/2010' AND '1/1/2020')

	-- 2. ������� �� ������� �� ��� ����, � ������ ���. ��������, ��� �������� ������.
	SELECT YEAR(release) FROM [cookbook]


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
	HAVING MAX(price) < 400

	SELECT name, AVG(price) FROM [product]
	GROUP BY name
	HAVING AVG(price) <= 400


-- 9. SELECT JOIN

	-- 1. LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
	SELECT author, copy FROM [cookbook]
	LEFT JOIN [product]
	ON copy = quantity
	WHERE copy < 25000

	-- 2. RIGHT JOIN. �������� ����� �� �������, ��� � � 5.1
	SELECT TOP 3 id_product, product.name, type, quantity, unit, price FROM [product]
	RIGHT JOIN [cookbook]
	ON product.id_product = cookbook.id_cookbook + 3
	ORDER BY price ASC

	-- 3. LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
	SELECT id_cookbook, complexity, price FROM [cookbook]
	LEFT JOIN [recipe]
	ON cookbook.id_cookbook = recipe.id_recipe
	LEFT JOIN [product]
	ON cookbook.id_cookbook = product.id_product - 3
	WHERE id_cookbook < 10 AND complexity > 1 AND price < 500

	-- 4. FULL OUTER JOIN ���� ������
	SELECT TOP 1 * FROM [cookbook]
	FULL OUTER JOIN [recipe]
	ON id_cookbook = id_recipe


-- 10. ����������

	-- 1. �������� ������ � WHERE IN (���������)
	SELECT name, copy FROM [cookbook] WHERE name IN ('Fish')

	-- 2. �������� ������ SELECT atr1, atr2, (���������) FROM ...    
	SELECT name, copy FROM [cookbook] WHERE id_cookbook IN (SELECT id_product FROM [product])