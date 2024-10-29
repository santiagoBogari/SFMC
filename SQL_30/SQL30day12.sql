SELECT 
    status,
    COUNT(amount),
    SUM(amount)
FROM [NextMobile Orders_2023]
GROUP BY
    status