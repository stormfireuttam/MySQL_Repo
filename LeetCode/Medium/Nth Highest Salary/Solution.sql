-- We will arrange salaries based on rank and then extract the salary which has value equivalent to the argument passed in the function
-- There can be more than one salaries with same rank so we will apply limit on our output which is generated as we just need one record

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      Select salary as getNthHighestSalary From (
          Select salary, dense_rank() over (order by salary desc) as rnk
          from Employee 
      ) t1
      Where rnk = N
      limit 1
  );
END
