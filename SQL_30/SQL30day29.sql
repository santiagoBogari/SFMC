SELECT 
    DATENAME(WEEKDAY, eventdate) AS day_of_week, 
    COUNT(DISTINCT subscriberkey) AS unique_unsubscribes
FROM 
    [NextMobile Unsubscribe]
WHERE isunique = 1
GROUP BY
    DATENAME(WEEKDAY, eventdate)
