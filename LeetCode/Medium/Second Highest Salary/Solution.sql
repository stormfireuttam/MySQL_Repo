-- Approach 01
Select max(salary) as SecondHighestSalary from Employee
Where salary <> (Select max(salary) from Employee)

-- Approach 02 (Failing for Null Condition)
Select ifnull(salary, 'null') as SecondHighestSalary from (
   Select salary, dense_rank() over (order by salary desc) as rnk from Employee
 ) cte
 where rnk = 2;

-- Approach 03 (Using CTE and Cases)
with T as (select *,dense_rank() over(order by salary desc) as rnk from Employee )
select
case when (select count(1) from T) > 1 then (select distinct salary as secondHighestSalary from T where rnk=2)
else NULL end as secondHighestSalary ;
