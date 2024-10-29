SELECT 
    u.id, 
    u.first_name,
    u.last_name, 
    u.email
FROM [NextMobile Users] u
WHERE u.id IN (
    SELECT 
        customer_id AS id
    FROM [NextMobile Orders_2023]
    GROUP BY customer_id
    HAVING SUM(amount) > 10000
)