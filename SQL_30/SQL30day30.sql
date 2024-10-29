SELECT
    u.state,
    (SUM(CASE WHEN c.IsUnique = 1 THEN 1.0 ELSE 0 END) / (COUNT(s.SubscriberKey) - SUM(CASE WHEN b.IsUnique = 1 THEN 1.0 ELSE 0 END))) * 100 AS ctr
FROM
    [NextMobile Users] u
JOIN 
    [NextMobile Sent_2023] s 
ON
    u.id = s.SubscriberKey
LEFT JOIN
    [NextMobile Click_2023] c
ON
    s.SubscriberKey = c.SubscriberKey AND s.JobId = c.JobId
LEFT JOIN
    [NextMobile Bounce_2023] b
ON
    s.SubscriberKey = b.SubscriberKey AND s.JobId = b.JobId    
WHERE
    s.EventDate >= '2023-01-01' 
    AND s.EventDate <= '2023-12-31' 
GROUP BY
    u.state
