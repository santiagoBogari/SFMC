/* Week 2: Sample Brief Exercise 2
Practice Assignment: Loyalty Program Property Promotions Email
 */
 

/* MY CODE */
SELECT M.MemberID
,M.FirstName
,M.LastName
,M.BalancePoints 
,M.LoyaltyTier 
,M.Email 
,M.JoinedDate
,M.PreferredPropertyID
,MprefDE.InterestPreference
,TxnDE.TransactionAmount
,TxnDE.TransactionDate
,Prop.PropertyName
,Prop.PromotionalOffer
,Prop.PromoCode

FROM [Members_DE] M
LEFT JOIN [MemberPreferences_DE] MprefDE ON M.MemberID = MprefDE.MemberID
LEFT JOIN [Transactions_DE] TxnDE ON M.MemberID = TxnDE.MemberID
LEFT JOIN [Properties_DE] Prop ON TxnDE.PropertyID = Prop.PropertyID

WHERE 
 (EXISTS (
        SELECT 1 
        FROM [Members_DE] 
        WHERE MemberID = M.MemberID 
        AND LoyaltyTier IN ('Bronze', 'Silver') 
        AND JoinedDate >= DATEADD(year, -1, GETDATE())
    )
OR 
    EXISTS (
        SELECT 1 
        FROM [Members_DE] 
        WHERE MemberID = M.MemberID 
        AND LoyaltyTier IN ('Gold', 'Platinum') 
        AND BalancePoints > 500
    ))
    
AND NOT EXISTS ( SELECT 1
                    FROM [Exclusions_DE] Exc
                    WHERE M.MemberID = Exc.MemberID
)
AND NOT EXISTS ( SELECT 1
                    FROM [OfferRedemptions_DE] OfferRed
                    WHERE M.MemberID = OfferRed.MemberID
                    AND OfferRed.RedemptionDate >= DATEADD(month, -3, GETDATE())
)                    
AND NOT EXISTS ( SELECT 1
                    FROM [MemberPreferences_DE] MPref
                    WHERE M.MemberID = MPref.MemberID
                    AND EmailOptIn = 'False'
)  

/*  VINCE CODE */

SELECT      Member.MemberID, 
            Member.FirstName, 
            Member.LastName, 
            Member.Email, 
            Member.LoyaltyTier, 
            Member.JoinedDate, 
            Member.PreferredPropertyID, 
            Member.BalancePoints,
            /* PREFERENCE FIELDS */
            Preferences.EmailOptIn, 
            Preferences.InterestPreference, 
            /* TRANSACTION FIELDS */
            LatestTxn.TransactionDate AS Latest_Txn_Date, 
            LatestTxn.TransactionAmount AS Latest_Txn_Amount, 
            LatestTxn.PropertyID AS Latest_Txn_PropertyID, 
            CASE
                WHEN LatestTxn.MemberID IS NOT NULL THEN 1
                ELSE 0
            END AS Has_Transacted,
            /* PROPERTY PROMOTION FIELDS */
            Property.PromotionalOffer, 
            Property.PromoCode
            
FROM        [Members_DE] Member
INNER JOIN  [MemberPreferences_DE] Preferences
ON          Member.MemberID = Preferences.MemberID
LEFT JOIN   (
                SELECT  X.*
                FROM    (
                            SELECT  MemberID,
                                    TransactionDate,
                                    TransactionAmount,
                                    PropertyID,
                                    ROW_NUMBER() OVER (PARTITION BY MemberID
            						                        ORDER BY TransactionDate DESC) AS RowNum
                            FROM    [Transactions_DE]
                        ) X
                WHERE   X.RowNum = 1
            ) LatestTxn
ON          Member.MemberID = LatestTxn.MemberID

INNER JOIN  [Properties_DE] Property
ON          Member.PreferredPropertyID = Property.PropertyID

/* CAMPAIGN CRITERIA */

/* CONSENT CRITERIA */
WHERE       Preferences.EmailOptIn = 1

/* NOT AN EXCLUDED MEMBER */
AND         NOT EXISTS (SELECT  1
                        FROM    [Exclusions_DE] Excluded
                        WHERE   Member.MemberID = Excluded.MemberID)
                        
/* NOT REDEEMED ANY OFFERS IN THE LAST 3 MONTHS */
AND         NOT EXISTS (SELECT  1
                        FROM    [OfferRedemptions_DE] OfferRed
                        WHERE   Member.MemberID = OfferRed.MemberID
                        AND     OfferRed.RedemptionDate > DATEADD(M, -3, GETDATE()))

/* SPECIFIC LOYALTY TIER CRITERIA */
AND         (
                /* AUDIENCE 1 - BRONZE AND SILVER JOINED IN THE LAST YEAR */
                (Member.LoyaltyTier IN ('Bronze', 'Silver') AND Member.JoinedDate >= DATEADD(M,-12,GETDATE()))
                OR
                /* AUDIENCE 2 - GOLD AND PLAT OVER 500 BALANCE POINTS */
                (Member.LoyaltyTier IN ('Gold', 'Platinum') AND Member.BalancePoints > 500)
            )


/*  */

SELECT      Member.MemberID, 
            Member.FirstName, 
            Member.LastName, 
            Member.Email, 
            Member.LoyaltyTier, 
            Member.JoinedDate, 
            Member.PreferredPropertyID, 
            Member.BalancePoints,
           
            Preferences.EmailOptIn, 
            Preferences.InterestPreference, 
           
            LatestTxn.TransactionDate AS Latest_Txn_Date, 
            LatestTxn.TransactionAmount AS Latest_Txn_Amount, 
            LatestTxn.PropertyID AS Latest_Txn_PropertyID, 
            CASE
                WHEN LatestTxn.MemberID IS NOT NULL THEN 1
                ELSE 0
            END AS Has_Transacted,
          
            Property.PromotionalOffer, 
            Property.PromoCode
            
FROM        [Members_DE] Member
INNER JOIN  [MemberPreferences_DE] Preferences
ON          Member.MemberID = Preferences.MemberID
LEFT JOIN   (
                SELECT  X.MemberID, X.TransactionDate,X.TransactionAmount,X.PropertyID,X.RowNum
                FROM    (
                            SELECT  MemberID,
                                    TransactionDate,
                                    TransactionAmount,
                                    PropertyID,
                                    ROW_NUMBER() OVER (PARTITION BY MemberID
            						                        ORDER BY TransactionDate DESC) AS RowNum
                            FROM    [Transactions_DE]
                        ) X
                WHERE   X.RowNum = 1
            ) LatestTxn
ON          Member.MemberID = LatestTxn.MemberID

INNER JOIN  [Properties_DE] Property
ON          Member.PreferredPropertyID = Property.PropertyID

 
WHERE       Preferences.EmailOptIn = 1
 
AND         NOT EXISTS (SELECT  1
                        FROM    [Exclusions_DE] Excluded
                        WHERE   Member.MemberID = Excluded.MemberID)
                        
 
AND         NOT EXISTS (SELECT  1
                        FROM    [OfferRedemptions_DE] OfferRed
                        WHERE   Member.MemberID = OfferRed.MemberID
                        AND     OfferRed.RedemptionDate > DATEADD(M, -3, GETDATE()))

 
AND         (
                
                (Member.LoyaltyTier IN ('Bronze', 'Silver') AND Member.JoinedDate >= DATEADD(M,-12,GETDATE()))
                OR
                
                (Member.LoyaltyTier IN ('Gold', 'Platinum') AND Member.BalancePoints > 500)
            )


 /* VINCE CODE*/
 SELECT 
Member.MemberID, 
Member.FirstName, 
Member.LastName, 
Member.Email, 
Member.LoyaltyTier, 
Member.BalancePoints, 
Member.JoinedDate, 
Member.PreferredPropertyID, 
MPref.EmailOptIn, 
MPref.InterestPreference, 
/*Transaction Fields*/
LatestTxn.TransactionDate AS Latest_Txn_Date, 
LatestTxn.TransactionAmount AS Latest_Txn_Amount, 
LatestTxn.PropertyID AS Latest_Txn_PropertyID, 
CASE 
    WHEN LatestTxn.MemberID IS NOT NULL THEN 1
    ELSE 0
END AS Has_Transacted,   

Property.PromotionalOffer, 
Property.PromoCode


FROM [Members_DE] Member
INNER JOIN [MemberPreferences_DE] MPref
                    ON M.MemberID = MPref.MemberID
                    
LEFT JOIN ( SELECT X.* 
            FROM(
		SELECT	MemberID,
	          	TransactionDate,
	          	TransactionAmount,
	          	PropertyID,
	          	ROW_NUMBER() OVER (PARTITION BY MemberID
						ORDER BY TransactionDate DESC) AS RowNum
		FROM    [Transactions_DE]            
	) X                    
         WHERE X.RowNum = 1           
                    )LatestTxn
                    ON Member.MemberID = LatestTxn.MemberID

INNER JOIN [Properties_DE] Property     
    ON Member.PreferredPropertyID = Property.PropertyID
                    
WHERE  /*Excluding customers that are opted out */
            MPref.EmailOptIn = 1
AND
/*Not an excluded member*/
        NOT EXISTS (SELECT 1
                    FROM [Exclusions_DE] Excluded
                    WHERE Member.MemberID = Excluded.MemberID)
       AND
       /*Have not redeemed any offers in the last 3 months*/
        NOT EXISTS (SELECT 1
                     FROM [OfferRedemptions_DE] OfferRed
                    WHERE M.MemberID = OfferRed.MemberID
                    AND OfferRed.RedemptionDate >= DATEADD(month, -3, GETDATE())

AND (
        (Member.LoyaltyTier IN ('Bronze','Silver') 
        AND 
        Member.JoinedDate >= DATEADD(year, -1, GETDATE())
        OR
        (Member.LoyaltyTier IN ('Gold','Platinum') 
        AND
        Member.BalancePoints > 500
        ))
                   