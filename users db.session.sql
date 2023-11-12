SELECT roles_id, name
FROM roles
WHERE roles_id NOT IN (
    SELECT DISTINCT roles_id
    FROM peopleroles
)


