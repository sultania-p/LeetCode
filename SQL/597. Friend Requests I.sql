/* Write your T-SQL query statement below */
with cte_req_acc as 
(
    select 1 as id, count(distinct concat(requester_id, accepter_id)) as cnt_req_acc
    from RequestAccepted
),
cte_fr_req as 
(
    select 1 as id, count(distinct concat(sender_id, send_to_id)) as cnt_fr_req
    from FriendRequest
)
select ROUND((1.0 * cnt_req_acc / (case when cnt_fr_req =0 then 1 else cnt_fr_req end)),2) as accept_rate 
from cte_req_acc a
join cte_fr_req b on a.id=b.id 
