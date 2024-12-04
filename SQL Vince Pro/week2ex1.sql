/* Week 2: Sample Brief Exercise 1

Practice Assignment: Loyalty Program Promotional Offer
 */

SELECT
Member.MemberID,
Member.Email,
Member.LoyaltyTier

FROM [Members_DE] Member
WHERE Member.LoyaltyTier IN ('Bronze', 'Silver', 'Gold')
AND EXISTS ( SELECT 1
                FROM [Transactions_DE] Txn
                WHERE Member.MemberID = Txn.MemberID
                AND Txn.TransactionAmount > 500
                AND Txn.TransactionDate >= DATEADD(month, -3, GETDATE())
                )
AND NOT EXISTS ( SELECT 1
                    FROM [Exclusions_DE] Exc
                    WHERE Member.MemberID = Exc.MemberID
)
AND NOT EXISTS ( SELECT 1
                    FROM [OfferRedemptions_DE] OfferRed
                    WHERE Member.MemberID = OfferRed.MemberID
                    AND OfferRed.RedemptionDate >= DATEADD(month, -6, GETDATE())
)