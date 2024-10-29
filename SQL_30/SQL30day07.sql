SELECT 
    id,
    data_usage,
    data_plan
FROM [NextMobile Usage]
WHERE 
    data_usage / data_plan BETWEEN 0.5 AND 0.75