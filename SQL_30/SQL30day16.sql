SELECT 
    MONTH(date), 
    MIN(amount) AS MinOrder, 
    MAX(amount) AS MaxOrder
FROM [NextMobile Orders_2023]
WHERE status = 'shipped'
GROUP BY MONTH(date)