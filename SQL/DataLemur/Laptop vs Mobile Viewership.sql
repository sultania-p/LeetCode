/*
Assume that you are given the table below containing information on viewership by device type (where the three types are laptop, tablet, and phone). Define “mobile” as the sum of tablet and phone viewership numbers. Write a query to compare the viewership on laptops versus mobile devices.

Output the total viewership for laptop and mobile devices in the format of "laptop_views" and "mobile_views".
*/


SELECT 
  sum(case when device_type in ('laptop') then 1 else 0 end) as laptop_views,
  sum(case when device_type in ('tablet', 'phone') then 1 else 0 end) as mobile_views
FROM viewership;