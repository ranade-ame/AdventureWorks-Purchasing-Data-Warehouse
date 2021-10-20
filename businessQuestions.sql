-- Business Questions for Purshasing DW

-- What are AdventureWorks purchases (Purchase cost & quantity) by product? 

with valuesa as (
select  (unitPrice*orderQuantity) as "Ordervalue",  fp.ProductID, dp.Name, orderQuantity
from factPurchases fp
join dimProduct dp
on fp.ProductID = dp.ProductID
)
select productID, name, sum(Ordervalue) as totalSales, sum(orderQuantity) as quantity
from valuesa
group by productID, name
order by 3 desc

-- What products are purchased?
select distinct fp.productID, dp.Name as "purchasedProducts"
from factPurchases fp
join dimProduct dp
on dp.ProductID = fp.ProductID
order by 1

-- What are AdventureWorks product purchases (Purchase cost & quantity) by vendor?


with temp as (
select distinct fp.factPurchaseSK, 
fp.EmpBusinessEntityID,fp.VendorBusinessEntityID, salesAmount, taxAmt , frieght , totalDue, dv.name
from factPurchases fp
join dimvendor dv
on fp.VendorBusinessEntityID = dv.VendorBusinessEntityID
) 
select distinct VendorBusinessEntityID, name, sum(t.salesAmount) as "totalSales",  
(select sum(orderQuantity) from factPurchases fp2 where fp2.VendorBusinessEntityID = t.VendorBusinessEntityID) as "purchasedQuantity"
from temp t
group by VendorBusinessEntityID, name
order by 3 desc


--group by EmpBusinessEntityID, name 

-- What AdventureWorks’ employees were involved in the above purchasing and what did they purchase
select distinct fp.EmpBusinessEntityID, de.firstName, de.lastName, fp.ProductID, dp.Name as productName
from factPurchases fp
join dimEmployee de
on fp.EmpBusinessEntityID = de.EmpBusinessEntityID
join dimProduct dp
on fp.ProductID = dp.ProductID


-- What vendors’ contacts were involved in the above purchasing and what did they purchase
select distinct fp.VendorBusinessEntityID, de.Name as "vendorName", fp.ProductID as productID, dp.Name as productName
from factPurchases fp
join dimVendor de
on fp.VendorBusinessEntityID = de.VendorBusinessEntityID
join dimProduct dp
on fp.ProductID = dp.ProductID
order by 1, 3

