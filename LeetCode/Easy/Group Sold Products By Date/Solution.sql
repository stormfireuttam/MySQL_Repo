#  Group_concat is a function in mysql that is used to group column values together comma separated
 Select sell_date, count(distinct(product)) as num_sold, group_concat(distinct(product)) as products from Activities
 Group By sell_date

