/*

Assume you are given the tables below about Facebook pages and page likes. Write a query to return the page IDs of all the Facebook pages that don't have any likes. The output should be in ascending order.

*/

SELECT
  page_id
from pages
where page_id not in (select page_id from page_likes)
order by page_id