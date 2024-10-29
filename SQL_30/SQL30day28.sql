SELECT
    COUNT(subscriberkey),
    domain,
    LEFT(SMTPBounceReason,100) AS BounceReason
FROM
    [NextMobile Bounce]
WHERE
    eventdate BETWEEN '2024-02-01' AND '2024-02-29'
GROUP BY
    domain,
    LEFT(SMTPBounceReason,100)
HAVING
    COUNT(subscriberkey) > 1