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