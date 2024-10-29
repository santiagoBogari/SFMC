SELECT 
    id,
    email,
    o.eventdate AS opened,
    c.eventdate AS clicked
FROM [NextMobile Users] u
LEFT JOIN
    [NextMobile Open] o
ON
    o.subscriberkey = u.id
LEFT JOIN
    [NextMobile Click] c
ON
    c.jobid = o.jobid AND c.subscriberkey = o.subscriberkey
WHERE
  o.jobid = '765452' OR o.jobid IS NULL