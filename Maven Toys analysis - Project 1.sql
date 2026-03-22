-- In this Analysis, we'll identify profit origin, check profit margins of products, and offer analysis-based reccomendations  


-- Most profitable Categories

SELECT Product_Category,
			FORMAT(CAST(SUM((Product_Price - Product_Cost) * Units) AS DECIMAL(18,0)), 'N0') AS profit 
FROM sales s JOIN products p ON s.Product_ID=p.Product_ID
GROUP BY product_category 
ORDER BY SUM((Product_Price-Product_Cost)*Units) DESC

/* קטגוריות מובילות: צעצועים ואלקטרוניקה
Toys				1,079,527
Electronics			1,001,437
Art & Crafts		753,354
Games				673,993
Sports & Outdoors	505,718
*/

--Most profitable Pdcts

SELECT Product_Category, product_name,
			FORMAT(CAST(SUM((Product_Price - Product_Cost) * Units) AS DECIMAL(18,0)), 'N0') AS profit 
FROM sales s JOIN products p ON s.Product_ID=p.Product_ID
GROUP BY product_category ,Product_Name
ORDER BY SUM((Product_Price-Product_Cost)*Units) DESC

--Profability VS Sales: Are the most sold the most profitable?

SELECT Product_Category, 
			FORMAT(CAST(COUNT(*) AS DECIMAL(18,0)), 'N0') AS num_of_sales 
FROM sales s JOIN products p ON s.Product_ID=p.Product_ID
GROUP BY product_category 
ORDER BY COUNT(*) DESC

/* מוצרים הנמכרים ביותר: צעצועים ואומנות ויצירה
Toys				221,227
Art & Crafts		220,673
Games				157,006
Sports & Outdoors	131,331
Electronics			99,025 */
-- קופץ לעין: אלקטרוניקה הכי פחות נמכרת אך שנייה ברווחיות - כלומר הקטגוריה מאופיינת בשולי רווח גבוהים. כדאי לרדת לרזולציית המוצרים, איזה מהם אחראי לזה
--(כמו כן, אומנות ויצירה עם שולי רווח נמוכים ומכירות רבות. האם ניתן להסיק מכאן על כדאיות להורדת המחיר למטרת גידול מכירות? חומר לאנליזה נפרדת לכאורה) 

-- Electronics: What products responsible for the high profit margins?

SELECT DISTINCT(Product_Name), 
		 (p.Product_Price - p.Product_Cost) AS Profit_per_unit
FROM products p
JOIN sales s ON p.Product_ID = s.Product_ID
WHERE p.Product_Category = 'Electronics'
Order by  (p.Product_Price - p.Product_Cost) DESC

/* : שולי רווח מוצרי אלקטרוניקה 
Colorbuds			8.00
Gamer Headphones	6.00
Toy Robot			5.00

לעומת שולי רווח במוצרים  מקטגוריות אחרות: 
*/
SELECT DISTINCT p.Product_Category, Product_Name, 
		 (p.Product_Price - p.Product_Cost) AS Profit_per_unit
FROM products p
JOIN sales s ON p.Product_ID = s.Product_ID
WHERE p.Product_Category <> 'Electronics'

Order by p.Product_Category, (p.Product_Price - p.Product_Cost) DESC

/*
Art & Crafts		Etch A Sketch			10.00
Art & Crafts		Playfoam				7.00
Art & Crafts		Kids Makeup Kit			6.00
Art & Crafts		PlayDoh Playset			4.00
Art & Crafts		Barrel O' Slime			2.00
Art & Crafts		Magic Sand				2.00
Art & Crafts		PlayDoh Can				1.00
Art & Crafts		PlayDoh Toolkit			1.00
Games				Jenga					7.00
Games				Monopoly				6.00
Games				Glass Marbles			5.00
Games				Uno Card Game			4.00
Games				Chutes & Ladders		3.00
Games				Deck Of Cards			3.00
Games				Classic Dominoes		2.00
Games				Rubik's Cube			2.00
Sports & Outdoors	Mini Basketball Hoop	16.00
Sports & Outdoors	Nerf Gun				5.00
Sports & Outdoors	Dart Gun				4.00
Sports & Outdoors	Foam Disk Launcher		3.00
Sports & Outdoors	Mini Ping Pong Set		3.00
Sports & Outdoors	Supersoaker Water Gun	3.00
Sports & Outdoors	Splash Balls			1.00
Toys				Plush Pony				11.00
Toys				Action Figure			6.00
Toys				Lego Bricks				5.00
Toys				Mr. Potatohead			5.00
Toys				Dinosaur Figures		4.00
Toys				Animal Figures			3.00
Toys				Hot Wheels 5-Pack		2.00
Toys				Teddy Bear				2.00
Toys				Dino Egg				1.00

 תובנה: אלקטרוניקה מתייחדת בכך ששולי הרווח של *כל* המוצרים בה בטווח הגבוה-בינוני, לעומת קטגוריות אחרות בהן מגוון רמות רווח. 
מסקנה אפשרית: לגוון את היצע המוצרים בקטגוריה כך שיהיו גם מוצרי יוקרה בעלי שולי רווח גבוהים, וכן מוצרי 'Entry level' עם רווח מועט - על מנת למקסם מכירות בקהלים שונים.
*/

