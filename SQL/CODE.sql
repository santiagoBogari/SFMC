

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