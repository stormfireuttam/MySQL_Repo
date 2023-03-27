# Write your MySQL query statement below

Update Salary 
Set Sex = IF(sex = 'm', 'f', 'm')

Update Salary
Set Sex = Case sex
  When 'm' then 'f'
  else 'm'
End 
