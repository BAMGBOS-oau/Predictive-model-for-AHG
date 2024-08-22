
--Customer Table
Select 
CustomerKey, YearlyIncome,
GeographyKey, 
DateDiff(yy,BirthDate, '2014-12-31') as Age, 
MaritalStatus, 
Gender, 
EnglishEducation as Education, 
EnglishOccupation as Occupation,
Case 
	When YearlyIncome between 10000 and 50000 then 'Low Income'
	When YearlyIncome between 50001 and 100000 then 'Mid Income'
	When YearlyIncome > 100000 then 'High Income'
End as 'Income Segment',
--TotalChildren, 
Case 
	When TotalChildren < 1 then 'No kids'
	When TotalChildren between 1 and 2 then '1-2 kids'
	When TotalChildren >2 then '3-5 kids'
End as 'TotalChildren',
Case 
	When DateDiff(yy,BirthDate, '2014-12-31') between 20 and 30 then '21-30'
	When DateDiff(yy,BirthDate, '2014-12-31') between 31 and 40 then '31-40'
	When DateDiff(yy,BirthDate, '2014-12-31') between 41 and 50 then '41-50'
	When DateDiff(yy,BirthDate, '2014-12-31') between 51 and 60 then '51-60'
	When DateDiff(yy,BirthDate, '2014-12-31') between 61 and 70 then '61-70'
	When DateDiff(yy,BirthDate, '2014-12-31') between 71 and 80 then '71-80'
	When DateDiff(yy,BirthDate, '2014-12-31') between 81 and 90 then '81-90'
End as 'Age Group',
NumberChildrenAtHome, 
HouseOwnerFlag, 
NumberCarsOwned

from DimCustomer;


--Territory table 

Select 
Geographykey, 
G.SalesTerritoryKey, 
EnglishCountryRegionName as Country, 
SalesTerritoryGroup as Continent

from DimGeography as G
left join DimSalesTerritory as T 
on G.SalesTerritoryKey = T.SalesTerritoryKey;

-- sales table

Select  
ProductKey, 
OrderDateKey,
SalesTerritoryKey,
CustomerKey,
SalesOrderNumber, 
Cast(OrderDate as Date) as OrderDate, 
OrderQuantity, 
SalesAmount as Revenue, 
TotalProductCost as Cost, 
SalesAmount - TotalProductCost as Profit 

from FactInternetSales


--Product Table

Select 
ProductKey, 
EnglishProductName as Product, 
EnglishProductCategoryName as ProductCategory, 
EnglishProductSubcategoryName as ProductSubcategory,
LargePhoto

from DimProduct as P 
left join DimProductSubcategory as S
on P.ProductSubcategoryKey = S.ProductSubcategoryKey
left join DimProductCategory as C
on S.ProductCategoryKey = C.ProductCategoryKey
where StandardCost is not null


-- Dates Table

Select 
[DateKey], [FullDateAlternateKey] as [Date],
[DayNumberOfWeek] as DayNumber,
[EnglishDayNameOfWeek] as [Weekday],
[MonthNumberOfYear] as MonthNumber,
[EnglishMonthName] as [MonthName],
[CalendarQuarter] as [Quarter],
[CalendarYear] as [Year]

from [dbo].[DimDate]
Where FullDateAlternateKey > '2010-12-27';



--Table for Recommendation Engine
 
Select FIS.[OrderQuantity] as QuantityOrdered, psc.[EnglishProductSubcategoryName] as ProductSub,
FIS.[CustomerKey] as CustomerID, p.[EnglishProductName] as Product,
PC.[EnglishProductCategoryName] as ProductCategory

from [dbo].[FactInternetSales] as FIS
INNER JOIN [dbo].[DimProduct] as P 
on FIS.[ProductKey] = p.[ProductKey]

left join [dbo].[DimProductSubcategory] as psc
on psc.[ProductSubcategoryKey] = p.[ProductSubcategoryKey]

left join [dbo].[DimProductCategory] as PC
on PC.[ProductCategoryKey] = psc.[ProductCategoryKey];


---Defining churn

select 

case when max([OrderDate]) > '2013-05-28 00:00:00.000'
then 0 else 1 
end as ChurnFlag

from [dbo].[FactInternetSales]


--table for prediction model

Select 
dc.CustomerKey, dc.YearlyIncome, 
DateDiff(yy,dc.BirthDate, '2014-12-31') as Age, 
dc.MaritalStatus, 
dc.Gender, 
dc.EnglishEducation as Education, 
dc.EnglishOccupation as Occupation,
Case 
	When dc.YearlyIncome between 10000 and 50000 then 'Low Income'
	When dc.YearlyIncome between 50001 and 100000 then 'Mid Income'
	When dc.YearlyIncome > 100000 then 'High Income'
End as 'Income Segment',

Case 
	When dc.TotalChildren < 1 then 'No kids'
	When dc.TotalChildren between 1 and 2 then '1-2 kids'
	When dc.TotalChildren >2 then '3-5 kids'
End as 'TotalChildren',
Case 
	When DateDiff(yy,dc.BirthDate, '2014-12-31') between 20 and 30 then '21-30'
	When DateDiff(yy,dc.BirthDate, '2014-12-31') between 31 and 40 then '31-40'
	When DateDiff(yy,dc.BirthDate, '2014-12-31') between 41 and 50 then '41-50'
	When DateDiff(yy,dc.BirthDate, '2014-12-31') between 51 and 60 then '51-60'
	When DateDiff(yy,dc.BirthDate, '2014-12-31') between 61 and 70 then '61-70'
	When DateDiff(yy,dc.BirthDate, '2014-12-31') between 71 and 80 then '71-80'
	When DateDiff(yy,dc.BirthDate, '2014-12-31') between 81 and 90 then '81-90'
End as 'Age Group',

dc.NumberChildrenAtHome, 
fi.SalesAmount, fi.OrderDate, fi.OrderQuantity, fi.SalesOrderNumber

from DimCustomer as dc
left join FactInternetSales as fi
on dc.CustomerKey = fi.CustomerKey;
















