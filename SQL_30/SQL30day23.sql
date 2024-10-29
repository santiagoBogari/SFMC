SELECT 
    s.id, 
    s.first_name, 
    s.last_name, 
    s.email,
    sr.nps_score
FROM [NextMobile Survey] s
LEFT JOIN [NextMobile Survey Responses] sr 
    ON s.id = sr.id