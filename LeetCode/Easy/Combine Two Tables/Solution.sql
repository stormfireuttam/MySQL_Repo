# Write your MySQL query statement below
 Select firstName, lastName, city, state 
 From Person P
 Left Join Address A On P.personId = A.personId
