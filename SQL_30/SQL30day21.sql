SELECT 
    s.state, 
    AVG(u.data_usage) AS average_data_usage
FROM 
    [NextMobile Users] AS s
INNER JOIN 
    [NextMobile Usage] AS u ON s.id = u.id
GROUP BY 
    s.state