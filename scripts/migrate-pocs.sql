-- Update existing Users who are listed as POCs for any event to the SCHOOL_POC role
UPDATE "User" 
SET role = 'SCHOOL_POC' 
WHERE email IN (SELECT DISTINCT "pocEmail" FROM "Event") 
AND role != 'ADMIN';
