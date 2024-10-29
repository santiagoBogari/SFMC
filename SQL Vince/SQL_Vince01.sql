SELECT      ContactKey,
            FirstName,
            LastName,
            LoyaltyTier,
            LastVisitedDate,
            InterestedProperty,
            UPPER(InterestedProperty) AS InterestedPropertyCAPS,
            LastBookingAmount,
            EmailOptOut,
            SMSOptOut,
            CASE
                WHEN LoyaltyTier = 'Gold' THEN 'GOLD-10OFF'
                ELSE 'PLAT-15OFF'
            END AS 'DiscountCode'
FROM        [LEEJXQUa]
/* AUDIENCE CRITERIA */

/* TIER MEMBERSHIP INCLUSION */
WHERE       LoyaltyTier IN ('Gold', 'Platinum')

/* LAST VISITED PROPERTY WITHIN 6 MONTHS */
AND         InterestedProperty IN ('Casino Royale','MGM Grand')
AND         LastVisitedDate >= DATEADD(Month, -6, GETDATE())

/* LAST BOOKING AMOUNT FILTER */
AND         LastBookingAmount > 7000

/* CONSENT EXCLUSIONS */
AND         EmailOptOut = 0
AND         SMSOptOut = 0


/* My code */
SELECT
FirstName,LastVisitedDate,LastBookingAmount,LoyaltyTier, EmailOptOut, SMSOptOut,
UPPER(InterestedProperty) AS Property,
CASE
WHEN LoyaltyTier = 'Gold' THEN CONCAT(UPPER(LEFT(LoyaltyTier, 4)), '-10OFF')
WHEN LoyaltyTier = 'Platinum' THEN CONCAT(UPPER(LEFT(LoyaltyTier, 4)), '-15OFF')
END AS DiscountOffer
FROM ZdlxLy63
WHERE
(LoyaltyTier = 'Gold' OR LoyaltyTier = 'Platinum')
AND
LastVisitedDate >= DATEADD(month, -6, GETDATE())
AND
LastBookingAmount > 7000
AND
(EmailOptOut = 'FALSE' OR SMSOptOut = 'FALSE')