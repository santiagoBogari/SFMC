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