
/*
Assume you are given the table below that shows job postings for all companies on the LinkedIn platform. Write a query to get the number of companies that have posted duplicate job listings.

Clarification:

Duplicate job listings refer to two jobs at the same company with the same title and description.
*/

select count(1) as co_w_duplicate_jobs
from (
  SELECT
    company_id, title, description,
    count(1) as cnt_jobs
  FROM job_listings
  group by company_id, title, description
) sq where cnt_jobs > 1;