Select d.name as Department, e.name as Employee, e.salary  as Salary from 
(Select *, dense_rank() over(partition by departmentId Order by Salary Desc) as rnk
from Employee) e
Left Join Department d
ON e.departmentId = d.id
Where rnk <= 3
order by e.id
