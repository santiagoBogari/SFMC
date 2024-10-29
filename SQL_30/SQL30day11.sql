SELECT 
    TOP 50
    id,
    amount
FROM [NextMobile Spend]
WHERE
    amount > 2000
ORDER BY amount DESC