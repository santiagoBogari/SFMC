SELECT 
    id,
    data_plan
FROM [NextMobile Plans]
WHERE
    data_plan IN ('Flex', 'Flex Plus', 'Essential')