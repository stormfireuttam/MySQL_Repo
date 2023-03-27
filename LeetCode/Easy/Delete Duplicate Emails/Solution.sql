# Please write a DELETE statement and DO NOT write a SELECT statement.

With cte as (
    Select id,email, 
       row_number() over (partition by email order by id) as rnk
    from Person
)

Delete From Person
Where id in (Select id from cte where rnk > 1)
