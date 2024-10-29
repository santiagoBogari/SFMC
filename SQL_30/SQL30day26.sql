SELECT o.state, COUNT(o.order_id) AS order_count
FROM (
    SELECT o.order_id, u.state
    FROM [NextMobile Orders_2023] o
    JOIN [NextMobile Users] u 
        ON o.customer_id = u.id
    WHERE o.status = 'shipped'
) AS o
GROUP BY o.state