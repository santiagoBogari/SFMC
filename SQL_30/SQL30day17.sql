SELECT id, launch_date
FROM [NextMobile Users]
WHERE launch_date >= DATEADD(DAY, -90, GETDATE()) 
AND launch_date < GETDATE()