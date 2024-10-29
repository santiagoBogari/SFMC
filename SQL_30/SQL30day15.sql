SELECT 
    state, 
	COUNT(id)
FROM [NextMobile Users]
GROUP BY 
    state
HAVING COUNT(id) > 50