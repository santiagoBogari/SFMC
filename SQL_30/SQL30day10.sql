SELECT 
    id,
    email,
    role,
    phone
FROM [NextMobile Commercial]
WHERE
    role LIKE '%administrator%' AND phone IS NULL