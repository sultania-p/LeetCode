/* Write your T-SQL query statement below */
select
	I.invoice_id,
	C.customer_name,
	I.price,
	isnull(sq.contacts_cnt, 0) as contacts_cnt,
	isnull(sq1.trusted_contacts_cnt, 0) as trusted_contacts_cnt
from Invoices I
left join Customers C on I.user_id=C.customer_id
left join (select  user_id, count(contact_name) as contacts_cnt 
				from Contacts Ct 
				group by user_id
		) sq on I.user_id=sq.user_id
left join (select  user_id, count(contact_name) as trusted_contacts_cnt 
				from Contacts Ct 
				where contact_email in (select email from Customers)
				group by user_id
			) sq1 on I.user_id=sq1.user_id
order by I.invoice_id