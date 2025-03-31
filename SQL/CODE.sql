

SELECT NxtM.customer_id,
    COUNT(*) AS NumOrders
FROM [NextMobile_Orders] NxtM
    GROUP BY NxtM.customer_id 
Having COUNT(*) = 1
/* 358 */
SELECT NxtM.customer_id,
    COUNT(*) AS NumOrders
FROM [NextMobile_Orders] NxtM
    GROUP BY NxtM.customer_id 
Having COUNT(*) > 1
/* 257 */





/* DE-DEUPLICATION VIA ROW_NUMBER FUNCTION */
/*COPY AND PASTE THE BELOW SQL CODE SNIPPET */

/* PARTITION BY ONE FIELD */
SELECT	X.*
FROM    (
		SELECT	CustomerID,
				TransactionDate,
				TransactionAmount,          
				ROW_NUMBER() OVER (PARTITION BY CustomerID
						ORDER BY TransactionDate DESC) AS RowNum
		FROM    [Orders]            
	) X
WHERE	X.RowNum = 1


/* PARTITION BY TWO FIELDS */
SELECT	X.*
FROM    (
		SELECT	CustomerID,
				TransactionDate,
				TransactionAmount,          
				ROW_NUMBER() OVER (PARTITION BY CustomerID, PhoneID
						ORDER BY TransactionDate DESC) AS RowNum
		FROM    [Orders]            
	) X
WHERE	X.RowNum = 1


/*  */
SELECT	X.customer_id,
				X.date,
				X.amount
FROM    (
		SELECT	customer_id,
				date,
				amount,          
				ROW_NUMBER() OVER (PARTITION BY customer_id
						ORDER BY date DESC) AS RowNum
		FROM    [NextMobile_Orders]            
	) X
WHERE	X.RowNum = 1




/*  */

SELECT 
    nxtUsers.id,
    nxtUsers.email,
    nxtUsers.first_name,
    NMO.order_id
FROM 
    [Nextmobile_Users] nxtUsers
INNER JOIN (
    SELECT 
        X.customer_id,
        X.date,
        X.amount,
        X.order_id  -- Ensure this column is included
    FROM (
				SELECT 
					customer_id,
					date,
					amount,
					order_id,  -- Include order_id in this inner query
					ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY date DESC) AS RowNum    
				FROM 
					[NextMobile_Orders] nxtOrders 
   		 ) AS X
    WHERE 
        X.RowNum = 1
) AS NMO ON nxtUsers.id = NMO.customer_id;


/* Marketing Cloud Mondays - Hands-On Building Session */

SELECT 
CONCAT(first_name, last_name,RIGHT(Email, LEN(Email) - CHARINDEX('@', Email )+1)) AS SubscriberKey 
, first_name 
, last_name 
, Email AS CommunityEmail 
, Company 
, Title 
, RIGHT(Email, LEN(Email) - CHARINDEX('@', Email )) AS Email_Domain , created_date AS Member_Join_Date

FROM Community_Members 
WHERE Email IS NOT NULL GROUP BY LAST_NAME

/*  */

SELECT DISTINCT CONCAT(first_name, last_name,RIGHT(Email, LEN(Email) - CHARINDEX('@', Email )+1)) AS SubscriberKey , MAX(first_name) AS first_name , MAX(last_name) AS last_name , MAX(Email) AS CommunityEmail , MAX(Company) AS Company , MAX(Title) AS Title , MAX(RIGHT(Email, LEN(Email) - CHARINDEX('@', Email ))) AS Email_Domain , MIN(created_date) AS [Member_Join_Date]

FROM Community_Members WHERE Email IS NOT NULL GROUP BY CONCAT(first_name, last_name,RIGHT(Email, LEN(Email) - CHARINDEX('@', Email )+1))

/*  */
SELECT DISTINCT CONCAT(CM.first_name, CM.last_name,RIGHT(CM.Email, LEN(CM.Email) - CHARINDEX('@', CM.Email )+1)) AS SubscriberKey , MAX(CM.first_name) AS first_name , MAX(CM.last_name) AS last_name , MAX(CM.Email) AS CommunityEmail , MAX(CM.Company) AS Company , MAX(CM.Title) AS Title , MAX(RIGHT(CM.Email, LEN(CM.Email) - CHARINDEX('@', CM.Email ))) AS Email_Domain , MIN(CM.created_date) AS [Member_Join_Date] , MIN(CA.SignUpDate) AS SignUpDate , MIN(CA.CheckinDate) AS CheckinDate

FROM Community_Members AS CM LEFT JOIN CommunityAttendee AS CA ON CONCAT(CM.first_name, CM.last_name,RIGHT(CM.Email, LEN(CM.Email) - CHARINDEX('@', CM.Email )+1)) = CONCAT(CA.first_name, CA.last_name,RIGHT(CA.Email, LEN(CA.Email) - CHARINDEX('@', CA.Email )+1))

WHERE CM.Email IS NOT NULL AND CA.SignUpDate IS NOT NULL GROUP BY CONCAT(CM.first_name, CM.last_name,RIGHT(CM.Email, LEN(CM.Email) - CHARINDEX('@', CM.Email )+1))






/*  */
SELECT c.SubscriberKey, c.EventDate as [ClickDate], c.LinkName as [LinkName]
FROM [_Click] c with (nolock)
join [_Job] j with (nolock)
On j.JobID = c.JobID
WHERE j.EmailID in ('60450')
and c.LinkName = 'Event Registration'