SELECT 
    order_id, 
    date AS order_date, 
    ship_date
FROM [NextMobile Orders_2023]
WHERE 
    DATEDIFF(day, date, ship_date) > 7
    AND status = 'shipped'