-- Failing for some test cases
With cte_orders as 
(Select buyer_id, sum(if(year(order_date)=2019,1,0)) as 'count_orders' from orders group by buyer_id)
Select user_id as buyer_id, join_date, co.count_orders as orders_in_2019 
from Users 
Join cte_orders as co 
On user_id = buyer_id;

-- Use of IFNULL and JOIN WITHOUT CTE
Select u.user_id as buyer_id, join_date, ifnull(count(o.order_id), 0) as orders_in_2019
From Users u
Left Join Orders o
ON u.user_id=o.buyer_id AND year(order_date)='2019'
group by u.user_id
