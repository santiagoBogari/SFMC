SELECT id, data_usage,
CASE 
    WHEN data_usage > 50 THEN 'Heavy'
    WHEN data_usage > 25 THEN 'Moderate'
    ELSE 'Light'
END AS user_type
FROM [NextMobile Usage]
WHERE 
    data_usage != 0