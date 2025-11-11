Use TelcoChurn;
select * from Customers

-- Overall Churn Rate
create view ChurnRate as 
select 
COUNT(*)as TotalCustomers,
SUM(Case when Churn = 'Yes' then 1 else 0 end) as ChurnedCustomers,
ROUND(Sum(case when Churn = 'Yes' then 1 else 0 end)* 100.0/ COUNT(*), 2)as ChurnRate
from customers;

select * from ChurnRate

-- 2. Churn by Contract Type

CREATE VIEW ChurnByContract AS

select Contract, COUNT(*)TotalCustomers, 
SUM(Case when Churn = 'Yes' then 1 else 0 end) as ChurnedCustomers,
ROUND(Sum(case when Churn = 'Yes' then 1 else 0 end)* 100.0/ COUNT(*), 2)as ChurnRate
from Customers group by Contract;

select * from ChurnByContract

-- 3. Churn by Internet Service Type

create view ChurnByInternetService as

select InternetService, COUNT(*)TotalCustomers, 
SUM(Case when Churn = 'Yes' then 1 else 0 end) as ChurnedCustomers,
ROUND(Sum(case when Churn = 'Yes' then 1 else 0 end)* 100.0/ COUNT(*), 2)as ChurnRate
from Customers group by InternetService;

select * from ChurnByInternetService

-- 4. Churn by Payment Method

create view churnbyPaymentMethod as
select PaymentMethod, COUNT(*)TotalCustomers, 
SUM(Case when Churn = 'Yes' then 1 else 0 end) as ChurnedCustomers,
ROUND(Sum(case when Churn = 'Yes' then 1 else 0 end)* 100.0/ COUNT(*), 2)as ChurnRate
from Customers group by PaymentMethod;

select * from churnbyPaymentMethod

-- 5. Tenure Analysis

create view churnbytenure as

select 
Case 
when tenure <= 12 Then '0-12 months'
when tenure <= 24 Then '13-24 months'
when tenure <= 36 Then '25-36 months'
when tenure <= 48 Then '37-48 months'
when tenure <= 60 Then '49-60 months'
Else '60+ months'

end as TenureGroup,

COUNT(*)TotalCustomers, 
SUM(Case when Churn = 'Yes' then 1 else 0 end) as ChurnedCustomers,
ROUND(Sum(case when Churn = 'Yes' then 1 else 0 end)* 100.0/ COUNT(*), 2)as ChurnRate
from Customers
group by 
Case 
when tenure <= 12 Then '0-12 months'
when tenure <= 24 Then '13-24 months'
when tenure <= 36 Then '25-36 months'
when tenure <= 48 Then '37-48 months'
when tenure <= 60 Then '49-60 months'
Else '60+ months'
end;

 select * from churnbytenure

-- 6. Monthly Charges vs Churn
create view monthlyCharge as 

SELECT 
CASE 
WHEN MonthlyCharges <= 35 THEN 'Low ($0-35)'
WHEN MonthlyCharges <= 70 THEN 'Medium ($36-70)'
WHEN MonthlyCharges <= 105 THEN 'High ($71-105)'
ELSE 'Very High ($106+)'
END as ChargeSegment,
COUNT(*) as TotalCustomers,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as ChurnedCustomers,
ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) as ChurnRate,
AVG(MonthlyCharges) as AvgMonthlyCharge
FROM customers
GROUP BY 
CASE 
WHEN MonthlyCharges <= 35 THEN 'Low ($0-35)'
WHEN MonthlyCharges <= 70 THEN 'Medium ($36-70)'
WHEN MonthlyCharges <= 105 THEN 'High ($71-105)'
ELSE 'Very High ($106+)'
END;

select * from monthlyCharge




