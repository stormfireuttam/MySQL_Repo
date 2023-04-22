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
 
25.One basic query like department wise count of subjects greater than 1 and order it . 

		select deptno,count(empno) as cnt from emp2 group by deptno having cnt>1 order by cnt;
		
		
26.In the first one I had to use lead window func,in the second one self join concept was used. 

		
27.sql queries.(3 tables were given) 
	Used inner join for 1st ques  
	Left join for 2nd ques 
	Inner join+wildcard for 3rd ques. 
	Some follow up questions like why I used left join and not inner join.
	
	
28.here is a table courses with columns: student and class Please list out all classes which have more than or equal to 5 students 

			select class,count(student) as cnt from courses group by class having cnt>=5;
			
29.Write a SQL query to get the department wise highest salary from the Employee table. 

			select dept,max(sal) from emp group by dept;
			
30.Write a SQL query to get id of users who purchased within 7 days. Userid , purchaseid , date columns are given 

			select * from users where date>date_sub(curdate(),interval '7' day);

31.Self join When self join is used 

		self join means joining the table to itself, it used in cases where we need to map the relation between columns of 2 tables
		example, if empid and ename and manager id are in are same table and if we want find name of manager for each employee, then we can use self join
		
		select e1.ename as empname, e2.ename as manager from emp e1 self join emp e2 on e1.managerid=e2.empid ;
		
	SQL query to find running total 
	
			 select ename,sal,sum(sal) over(order by sal asc rows between unbounded preceding and current row) as run_sal from emp2;
	She gave me two tables having only 1 column  and asked the output when I perform left, right, full, inner join on it 
	
	Table1		Table2 
	Id		Id                  
	1		1 
	1		1 
	1		1 
	For the same above table asked me output for table1 union table2 and table1 union all table2 
	
	select id from table1 union select id from table2;
	select id from table1 union all select id from table2;
	
	
	Table  
	Id 
	1 
	2 
	3 
	NULL 
	What is the output for select * from table where Id <> 2;

				1
				3
operators,artimetic functions will exclude null				

32.get data from mysql database table using python, add new column and return the updated data to mysql 

		#python
		import mysql.connector as mycon
		try:
			conn=mycon.connect(
							host=,
							database=,
							user=,
							password=,
							port=
						)
		
33.Get month from a date 

34.In SQL, he also asked about various window functions like row_number(), nth_value, lead(), lag(). All these were used in my query to solve, that's why he asked.


35.3. Sals 3 rd max : answer given, using dense rank order by sal desc, depth question for reason of using dense, asked without using dense, gave her two alternatives, using 3 subqueries, to get 3rd max, and another one that i know from prior versions of using rownum from older version.

	
36. Give a scenario in which self join can be used.

		empname and corresponding manager from emp
37. Table1: id- 1,1,1,2,4
	Table2: id- 1,1,1,null,5
	How many records will be there when we are performing inner join, left join, right join, full outer join, left outer join, right outer join.
	
		inner --3+3+3 =9
		left-3+3+3+1+1 =11
		right--3+3+3+1+1 =11
		full outer--3+3+3+1+1+1+1 = 13
38. How do you detect duplicate without using window functions? 

		select * from (select *,row_number() over(partition by empno,ename order by id) as rn from tb1) D where D.rn>1

		delete from tb1 where id in (select D.id from (select *,row_number() over(partition by empno,ename order by id) as rn from tb1) D where D.rn>1);

39.Table: names- A,A,A,B,B,B,C,C,D
	values- 3001,3002,3003,1002,1003,1004,4000,4001,5002
	Using window functions how do you get output as A 3003,B 1004,C 4001,D 5002.
	
	select distinct name,max(`values`) over(partition by name) from tbl1;
	select distinct name,last_value(`values`) over(partition by name) from tbl1;
	
40.1.Table 1: id- 1,1,1,2,4
	Table 2: id- 1,1,1,null,5
	How many records will be there when we are performing inner join, left join, right join, full outer join, left outer join, right outer join.
	inner --3+3+3 =9
		left-3+3+3+1+1 =11
		right--3+3+3+1+1 =11
		full outer--3+3+3+1+1+1+1 = 13
	
	
41. How do you detect duplicate without using window functions? 

				delete from emp where rowid not in (select min(rowid) from emp group by col1,col2,col2);
42. What is lead and lag in window functions?

		lead function is used to pickup the desired value by position that is after the current column value
		
		lead function is used to pickup the desired value by position that is previous to the current column value
		
43. Count a character from a given string

length(word)-length(replace(word,'r',""))

44.Count of distinct employees

	select count(distinct empno) from emp2;
	
45.Second highest salary from each department 
	
	select distinct D.deptno,D.sal from (select deptno,sal,dense_rank() over(partition by deptno order by sal desc) as drnk from emp2) D where D.drnk=2;
-46.write a sql query to get the number which repeats consecutively for 3 or more times using SELF JOIN 
SELECT DISTINCT num
FROM (
  SELECT num, 
         LAG(num) OVER (ORDER BY num) AS prev_num, 
         LEAD(num) OVER (ORDER BY num) AS next_num
  FROM numbers
) AS t
WHERE num = prev_num + 1 AND num = next_num - 1

	
tbl: num,
select t1.num from tbl t1 inner join tbl t2 using(num) group by t1.num having count(t2.num)>=3;

1
2
5
5
5
5

47. Write a sql query to get the desired output 
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
SELECT StudentName, 'English' as Subjects, English as Marks FROM Student
UNION ALL
SELECT StudentName, 'Math' as Subjects, Math as Marks FROM Student
UNION ALL
SELECT StudentName, 'Science' as Subjects, Science as Marks FROM Student
ORDER BY StudentName;



48.Given a table and asked to write the query to get the class in which 3 or more students were enrolled  

sname,course,class
select class,count(sname) as cnt from students group by class having cnt>=3;

49.Given a table and asked to write a query to get the highest salary from each department 

	select deptno,max(sal) from emp group by deptno ; 
50.Given a table and asked to write a query to get the users who purchased within 7 days 

select usrname,pdate from sales where pdate>date_sub(curdate(),interval '7' day);
 
51.Sales, revenue and average formula

52.Find out first, second and third unit price from the given data

select distinct(D1.unitprice),D1.drnk from (select unitprice,dense_rank(order by unitprice desc) as drnk from products) D1 where D1.drnk<=3;

-53.. 
	Table 1 
	Id 
	1 
	1 
	
	Table 2 
	Id        Age 
	1         20 
	1         20 
	1         20 
	What is output when we do left join for above table. 
1 1 20
1  1 20
1  1 20
1 1 20
1  1 20
1  1 20
	


54. Second question 
	Table 
	Id name salary managerID 
	1 aaaa  70000  3 
	2 bbbb  50000  4 
	3 ccccc  60000  null 
	4 dddd  90000 null 
	Write a query to find employees who have 
	Salary more than the manager 

select e1.name,e1.salary from emp e1 inner join emp e2 on e1.managerid=e2.id where e1.salary>e2.salary;

pd-55. Create a data frame with a given list 
    And drop the duplicates 
	Data = [[Mad kol 500],[kol, Mad, 500],    [mad, del,1000], [mad, bng, 600]] 
	Mad kol 500 and kol Mad 500  are considered to be duplicate here 
 
56.  And a question which need to be solved using case statement
select ename, case when cond1 then op1
			 when cond2 then op2
			 .
			 .
			 else opn
			 end as "col_alis"
from emp;
		

57.write a query to display top 3 salaries using sub query and window functions
	select distinct(D1.salary),D1.drnk(select salary,dense_rank() over(order by salary desc) as drnk from emp) D1 where D1.drnk<=3 order by D1.drnk;
 
58.regarding joins, indexes, views, stored procedures 
	

--59.optimization of a query( if there are more than 3,4 joins)  

60.Second highest salary in each department ?
	select D1.salary from (select salary,dense_rank() over(order by salary desc) as drnk from emp) D1 where D1.drnk=2;

61. Fifth highest salary in each department?
	select D1.salary from (select salary,dense_rank() over(order by salary desc) as drnk from emp) D1 where D1.drnk=2;

62. Highest salary in each department?
	select deptno,max(salary) from emp group by deptno;

63. How to find duplicates?
rowid,ename,dept,sal
	select * from (select *,row_number(partition by ename,dept order by rowid asec) as rn) D1 where D1.rn>1;

64. How to find and delete duplicates?
	delete from emp where rowid in (select D1.rowid from (select *,row_number(partition by ename,dept order by rowid asec) as rn) D1 where D1.rn>1);
65. What complex procedure have you written?

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


#explain about such procedure in healthcare

66.Suppose you have two tables credit table and a transactional table to find the customer whose credit card was issued in the last 6 months and has only 1 transaction? 
SELECT *
FROM credit c
JOIN transactional t ON c.credit_card_number = t.credit_card_number
WHERE c.date_issued >= subdate(curdate(),interval '6' month)
GROUP BY t.credit_card_number
HAVING COUNT(*) = 1;
