SELECT  ContactKey,
                FirstName,
                LastName,
                MembershipTier,
                LastVisitDate,
                ClassesAttended,
                EmailOptOut,
                SMSOptOut,
                InterestedInOnlineClasses,
                InterestedInWellness,
                AttendedInPersonClasses,
                UPPER(LEFT(MembershipTier,4)) + '-10OFF' AS DiscountCode,
                CASE
                    WHEN ClassesAttended > 15 THEN 'A'
                    WHEN InterestedInOnlineClasses = 1 AND AttendedInPersonClasses = 0 THEN 'B'
                    WHEN InterestedInWellness = 1 AND AttendedInPersonClasses = 1 THEN 'C'
                    ELSE 'D'
                END AS 'Segment'
FROM            [mKbM7B4V]

/* AUDIENCE 1 */
WHERE           (
                    MembershipTier IN ('Gold','Platinum','Diamond')
                    AND             
                    ClassesAttended > 10
                )
                
/* AUDIENCE 2 */
OR              (
                    (InterestedInOnlineClasses = 1 OR InterestedInWellness = 1)
                    AND
                    AttendedInPersonClasses = 0
                )

/* AUDIENCE 3 */
OR              (
                    MembershipTier IN ('Platinum','Diamond')
                    AND
                    LastVisitDate >= DATEADD(D,-90, GETDATE())
                )


/* My code */

SELECT
ContactKey,
FirstName,
LastName,
MembershipTier,
LastVisitDate,
ClassesAttended,
EmailOptOut,
SMSOptOut,
InterestedInOnlineClasses,
InterestedInWellness,
AttendedInPersonClasses,
CASE
WHEN ClassesAttended > 15 AND LastVisitDate >= DATEADD(Month, -6, GETDATE()) THEN 'A'
WHEN InterestedInOnlineClasses = 1 AND AttendedInPersonClasses = 0 THEN 'B'
WHEN InterestedInWellness = 1 AND AttendedInPersonClasses = 1 THEN 'C'
WHEN MembershipTier IN ('Platinum', 'Diamond') THEN 'D'
ELSE 'D'
END AS Segment,
CASE
WHEN MembershipTier = 'Gold' THEN 'GOLD-10OFF'
WHEN MembershipTier = 'Platinum' THEN 'PLAT-10OFF'
WHEN MembershipTier = 'Diamond' THEN 'DIAM-10OFF'
END AS Discount
FROM
[FitnessGym_Members]
WHERE
(MembershipTier IN ('Gold', 'Platinum', 'Diamond') AND ClassesAttended > 10)
OR
(InterestedInOnlineClasses = 1 AND AttendedInPersonClasses = 0)
OR
(MembershipTier IN ('Platinum', 'Diamond') AND LastVisitDate >= DATEADD(Day, -90, GETDATE()))