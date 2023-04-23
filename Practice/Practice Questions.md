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

## 9. Query max of salary of each department with the emp_id and emp_name also.
Using Rank:
```
select empid,emp_name ,dept,max(salary) over(partition by dept ) as max_salary from emp;
```	
Using Subquery:
```
Select e1.empid, e1.empname, e1.dept, e1.salary from emp e1 
where e1.salary = (Select max(e2.salary) from emp e2 where e1.dept = e2.dept group by e2.dept)
```

## 10. Two tables were given. Perform inner, left and right join.
```		
select * from tbl1 inner join tbl2 on tbl1.col1=tbl2.col2;
select * from tbl1 left join tbl2 on tbl1.col1=tbl2.col2;
select * from tbl1 right join tbl2 on tbl1.col1=tbl2.col2;
```

## 11. Print the Students details of those students who scored more than avg marks in each Subject
```
select * from student where marks > (select avg(marks) 
```

## 12. Get the percentage of students who scored more than 90 in each subject
```
select (count(*)/(select count(*) from students))*100 from students where marks>90;
```		
 
## 13. One basic query like department wise count of subjects greater than 1 and order it . 
```
select deptno,count(empno) as cnt from emp2 group by deptno having cnt>1 order by cnt;
```		

## 14. here is a table courses with columns: student and class Please list out all classes which have more than or equal to 5 students 
```
select class,count(student) as cnt from courses group by class having cnt>=5;
```	

## 15. Write a SQL query to get the department wise highest salary from the Employee table. 
```
select dept,max(sal) from emp group by dept;
```

## 16. Write a SQL query to get id of users who purchased within 7 days. Userid , purchaseid , date columns are given 
```
select * from users where date>date_sub(curdate(),interval '7' day);
```

		
## 17. SQL query to find running total 
```	
select ename,sal,sum(sal) over(order by sal asc rows between unbounded preceding and current row) as run_sal from emp2;
```			 			

## 18. Get data from mysql database table using python, add new column and return the updated data to mysql 
```
import mysql.connector as mycon
try:
conn=mycon.connect(	host=,
			database=,
			user=,
			password=,
			port= )
```

## 19.Get month from a date 
```
SELECT MONTH(STR_TO_DATE('23-04-2023', '%d-%m-%Y')) as month_number;
```


## 20. Using window functions how do you get output as A 3003,B 1004,C 4001,D 5002
-	Table: names- A,A,A,B,B,B,C,C,D
-	Values- 3001,3002,3003,1002,1003,1004,4000,4001,5002
```
select distinct name,max(`values`) over(partition by name) from tbl1;
select distinct name,last_value(`values`) over(partition by name) from tbl1;
```

## 21. How many records will be there when we are performing inner join, left join, right join, full outer join, left outer join, right outer join.
-	Table 1: id- 1,1,1,2,4
-	Table 2: id- 1,1,1,null,5
```
inner --3+3+3 =9
left-3+3+3+1+1 =11
right--3+3+3+1+1 =11
full outer--3+3+3+1+1+1+1 = 13
```	
	
# 22. What is lead and lag in window functions?
-	lead function is used to pickup the desired value by position that is after the current column value	
-	lag function is used to pickup the desired value by position that is previous to the current column value
		
# 23. Count a character from a given string
```
length(word)-length(replace(word,'r',""))
```	
## 24. write a sql query to get the number which repeats consecutively for 3 or more times using SELF JOIN 
```
Select Distinct num
From (Select num, 
      Lead(num) over (order by num) as next_num, 
      Lag(num) over (order by num) as prev_num
      From numbers) AS t
Where num = prev_num+1 AND num=next_num-1
```

## 25. Write a sql query to get the desired output 
```
Student table 
StudentName 		English 		Math 			Science 
David 		   99 			  77 		99 
Mark 		   87 			  65 		55 
Sam 		   92 			  93 			  100 

o/p 
StudentName 			Subjects 			Marks 
David 			  English 			  99 
David 			  Math 				  77 
David 			  Science 			  99 
Mark 			  English 			  87 
Mark 			  Math 				  65 
Mark 			  Science 			  55 
Sam 			  English 			  92 
Sam 			  Math 				  93 
Sam 			  Science 			  100 
```
Solution:
```
SELECT StudentName, 'English' as Subjects, English as Marks FROM Student
UNION ALL
SELECT StudentName, 'Math' as Subjects, Math as Marks FROM Student
UNION ALL
SELECT StudentName, 'Science' as Subjects, Science as Marks FROM Student
ORDER BY StudentName;
```

## 26. Given a table and asked to write a query to get the users who purchased within 7 days 
```
select usrname,pdate from sales where pdate>date_sub(curdate(),interval '7' day);
```	

## 27.optimization of a query( if there are more than 3,4 joins)  

## 28. What complex procedure have you written?
```
CREATE PROCEDURE calculate_inventory()
BEGIN
  DECLARE total_qty INT;
  DECLARE total_value DECIMAL(10,2);
  
  -- Calculate total quantity of inventory
  SELECT SUM(qty) INTO total_qty FROM inventory;
  
  -- Calculate total value of inventory
  SELECT SUM(qty * unit_price) INTO total_value FROM inventory;
  
  -- Update inventory summary table
  UPDATE inventory_summary SET total_qty = total_qty, total_value = total_value;
  
  -- Insert inventory transaction records
  INSERT INTO inventory_transactions (transaction_date, product_id, qty, unit_price)
  SELECT CURDATE(), product_id, qty, unit_price FROM inventory;
  
  -- Delete old inventory records
  DELETE FROM inventory WHERE date_added < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
END;
```

## 29.Suppose you have two tables credit table and a transactional table to find the customer whose credit card was issued in the last 6 months and has only 1 transaction? 
```
SELECT *
FROM credit c
JOIN transactional t ON c.credit_card_number = t.credit_card_number
WHERE c.date_issued >= subdate(curdate(),interval '6' month)
GROUP BY t.credit_card_number
HAVING COUNT(*) = 1;
```
