SELECT 
    DATEPART(quarter, date) AS quarter,
    SUM(amount) AS total_sales
FROM [NextMobile Orders_2023]
WHERE status = 'shipped'
GROUP BY DATEPART(quarter, date)