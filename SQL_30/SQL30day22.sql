SELECT 
    DISTINCT u.id, 
    u.first_name, 
    u.last_name, 
    u.email
FROM [NextMobile Users] u
JOIN [NextMobile Orders] o ON u.id = o.customer_id
WHERE o.date BETWEEN DATEADD(day, -60, GETDATE()) AND DATEADD(day, -15, GETDATE())
AND o.status = 'shipped'