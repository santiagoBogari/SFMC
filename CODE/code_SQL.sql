/* https://github.com/camrobert/SalesforceMarketingCloud/tree/main/SQL */
/* Cameron, Get all Emails in all Journeys */

SELECT DISTINCT
job.EmailName
,ja.ActivityName
,j.JourneyName
,j.VersionNumber
,j.JourneyStatus
,s.SendsLast90Days
FROM (
    SELECT
        ActivityName
        ,VersionID
        ,JourneyActivityObjectID
        ,ActivityType
    FROM [_JourneyActivity]
    WHERE ActivityType LIKE '%EMAIL%'
) ja
LEFT JOIN (
    SELECT
        VersionID
        ,JourneyName
        ,JourneyStatus
        ,VersionNumber
    FROM [_Journey]
) j ON j.VersionID = ja.VersionID
LEFT JOIN (
    SELECT
        EmailName
        ,JobID
        ,TriggererSendDefinitionObjectID
    FROM [_Job]
) job ON job.TriggererSendDefinitionObjectID = ja.JourneyActivityObjectID
LEFT JOIN (
    SELECT
        TriggererSendDefinitionObjectID
        ,COUNT(*) as 'SendsLast90Days'
    FROM [_Sent]
    WHERE EventDate > (GetDate() - 90)
    GROUP BY TriggererSendDefinitionObjectID
) s ON s.TriggererSendDefinitionObjectID = ja.JourneyActivityObjectID

/*  */


/* Marketing Cloud Mondays - Hands-On Building Session */
SELECT DISTINCT 
CONCAT(CM.first_name, CM.last_name,RIGHT(CM.Email, LEN(CM.Email) - CHARINDEX('@', CM.Email )+1)) AS SubscriberKey
, MAX(CM.first_name) AS first_name
, MAX(CM.last_name) AS last_name
, MAX(CM.Email) AS CommunityEmail
, MAX(CM.Company) AS Company
, MAX(CM.Title) AS Title
, MAX(RIGHT(CM.Email, LEN(CM.Email) - CHARINDEX('@', CM.Email ))) AS Email_Domain
, MIN(CM.created_date) AS [Member_Join_Date]
, MIN(CA.SignUpDate) AS SignUpDate
, MIN(CA.CheckinDate) AS CheckinDate
, MIN(CS.Emailaddress) AS Emailaddress
, MIN(CS.Products) AS Products
, MIN(CS.Profession) AS Profession

FROM Community_Members AS CM
LEFT JOIN CommunityAttendee AS CA 
ON CONCAT(CM.first_name, CM.last_name,RIGHT(CM.Email, LEN(CM.Email) - CHARINDEX('@', CM.Email )+1)) = 
CONCAT(CA.first_name, CA.last_name,RIGHT(CA.Email, LEN(CA.Email) - CHARINDEX('@', CA.Email )+1))
Left JOIN Community_Signups AS CS
ON CONCAT(CM.first_name, CM.last_name,RIGHT(CM.Email, LEN(CM.Email) - CHARINDEX('@', CM.Email )+1)) = 
CONCAT(CS.firstname, CS.lastname,RIGHT(CS.Emailaddress, LEN(CS.Emailaddress) - CHARINDEX('@', CS.Emailaddress )+1))


WHERE CM.Email IS NOT NULL
AND CS.Emailaddress IS NOT NULL

GROUP BY CONCAT(CM.first_name, CM.last_name,RIGHT(CM.Email, LEN(CM.Email) - CHARINDEX('@', CM.Email )+1))

/*  */
SELECT TOP 5000
customer_id, date
FROM NextMobile_Orders 
WHERE date >= DATEADD(YEAR, -1, GETDATE()) ORDER BY date DESC