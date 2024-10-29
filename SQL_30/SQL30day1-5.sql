/* https://marketingcloud30.com/c/sql30axkyk/ */

SELECT 
	email,
	first_name,
	last_name
FROM [NextMobile Users]

/*  */

SELECT
    id,
    internet_package
FROM [NextMobile Packages]
WHERE
    internet_package != 'Gigabit Fibe 1.5'

/*  */

SELECT 
    COUNT(id) AS eligible_customers
FROM [NextMobile Usage]
WHERE 
    data_usage < 20

/*  */

SELECT 
    id, 
    points * 1.5 AS bonus_points
FROM [NextMobile Loyalty]
WHERE 
    points * 1.5 >= 150000

SELECT 
    id, 
    email, 
    mobility,
    internet
FROM [NextMobile Services]
WHERE 
    mobility = 'Essential 120' OR internet = 'Fibe 500'

/*  */    