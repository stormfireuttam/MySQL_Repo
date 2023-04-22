## 1.Asked to write a query to fetch 3rd Highest salary (without using Rank). 
With Limit and Offset:
```
SELECT (SELECT DISTINCT Salary FROM Employee ORDER BY Salary DESC LIMIT 1 OFFSET 2) AS ThirdHighestSalary;
```
With Rank: 
```
  Select D.sal from (Select *, dense_rank() over(order by sal desc) as rnk from emp) D 
  where D.rnk = 3; 
```
With Non-Correlated Subquery:
```
  Select max(sal) from emp 
  where sal < (Select max(sal) from emp 
  where sal < (Select max(sal) from emp))
```
With Correlated Subquery:
```
  Select sal from emp e1 where 3 = (
  Select count(distinct(sal)) from emp e2.sal >= e1.sal)
```

## 2.Asked to write a query to delete duplicate rows in a table. 
Using Subquery:
```
  Delete From my_table 
  Where row_id not in (Select min(row_id) from my_table group by col2,col3)
```
Using Rank: 
```
  Delete From my_table
  Where id in (Select D.id from (Select *, row_number() over(partition by id order by id) as rnk from my_table) where D.rnk > 1);
```
Using Join:
```
  Delete from my_table t1 
  Inner Join my_table t2 
  Where t1.id > t2.id AND t1.name = t2.name AND t1.sal = t2.sal  
```

## 3. class wise top3 ranks 
Using subquery:
```
  Select d.name as Department, e1.name as Employee, e1.salary as Salary 
  from Employee e1
  Left Join Department d On e1.departmentId = d.id
  where (Select count(distinct(salary)) as sal from Employee e2 
           Where e2.departmentId = e1.departmentId 
           And e2.salary >= e1.salary) <= 3
  Order By e1.departmentId, e1.salary desc
```
Using Rank:
```
  Select d.name as Department, e.name as Employee, e.salary  as Salary from 
  (Select *, dense_rank() over(partition by departmentId Order by Salary Desc) as rnk
   from Employee) e
  Left Join Department d ON e.departmentId = d.id
  Where rnk <= 3 order by e.id
```

## 4. Get age from date_of_birth
```
  Select timestampdiff(year, dob, curdate())
```
Unit can be year, month, quarter, day, week, hour, minute, second

## 5.Extract the middle name from FullName  

-   Using substring_index ---> Return a substring of a string before a specified number of delimiter occurs:  
```
SELECT SUBSTRING_INDEX("Surya Kumar R", " ", 2);
```
-   Using SUBSTRING And INSTR
``` 
SELECT SUBSTRING(full_name, INSTR(full_name, ' ') + 1, 
       INSTR(full_name, ' ', INSTR(full_name, ' ') + 1) - INSTR(full_name, ' ') - 1) AS middle_name
FROM your_table_name;

Or
(For Handling If Middle Name is not There)
SELECT SUBSTRING(name, INSTR(name, ' ') + 1, 
                 IFNULL(NULLIF(INSTR(SUBSTRING(name, INSTR(name, ' ') + 1), ' '), 0), 
                        LENGTH(name)) - 1) AS middle_name 
FROM my_table;
```

## 6.query for highest score for each student  
```
select studentid,max(score) from marklist group by studentid;
```
	
## 7. Print records other than duplicated rows
Using Subquery:
```
  Select * from emp where rowid in (Select min(rowid) from emp group by col1,col2,col3)
```

## 8. Print records that do not have duplicate rows
Using Subquery:
```		
		Select * from emp where rowid in (select rowid from emp group by col1,col2,col3 having count(rowid) = 1);
```

## 9.Delete duplicate records from a file
