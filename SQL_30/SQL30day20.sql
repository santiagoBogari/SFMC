SELECT 
    id, 
    launch_date,
    DATEADD(YEAR, DATEDIFF(YEAR, launch_date, GETDATE()), launch_date) AS renewal_date
FROM 
    [NextMobile Users]
WHERE
    DATEDIFF(DAY, GETDATE(), DATEADD(YEAR, DATEDIFF(YEAR, launch_date, GETDATE()), launch_date)) BETWEEN 0 AND 30
    AND DATEADD(YEAR, DATEDIFF(YEAR, launch_date, GETDATE()), launch_date) > GETDATE()
