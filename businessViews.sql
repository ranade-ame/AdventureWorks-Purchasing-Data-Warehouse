

-- What are AdventureWorks purchases (Purchase cost & quantity) by product? 
create view "advPurchasesByProduct" as 
with valuesa as (
select  (unitPrice*orderQuantity) as "Ordervalue",  fp.ProductID, dp.Name, orderQuantity
from factPurchases fp
join dimProduct dp
on fp.ProductID = dp.ProductID
)
select productID, name, sum(Ordervalue) as totalSales, sum(orderQuantity) as quantity
from valuesa
group by productID, name

select * from "advPurchasesByProduct"
order by 3 desc


select * from advPurchasesByProduct

-- What products are purchased?
create view "purchasedProducts" as 
select distinct fp.productID, dp.Name as "productName"
from factPurchases fp
join dimProduct dp
on dp.ProductID = fp.ProductID

select * from purchasedProducts

-- What are AdventureWorks product purchases (Purchase cost & quantity) by vendor?
create view "purchaseByVendor" as
select distinct dv.VendorBusinessEntityID, dv.Name as"Vendor", sum(orderQuantity) as"orderedQuantity", sum(totalDue) as "totalCost"
from factPurchases fp
join dimVendor dv
on fp.VendorBusinessEntityID = dv.VendorBusinessEntityID
group by dv.VendorBusinessEntityID, dv.Name;

select * from purchaseByVendor

-- What AdventureWorks’ employees were involved in the above purchasing and what did they purchase
create view "purchaseByEmployees" as
select distinct fp.EmpBusinessEntityID, de.firstName, de.lastName, fp.ProductID, dp.Name as productName
from factPurchases fp
join dimEmployee de
on fp.EmpBusinessEntityID = de.EmpBusinessEntityID
join dimProduct dp
on fp.ProductID = dp.ProductID


-- What vendors’ contacts were involved in the above purchasing and what did they purchase
create view "produtVendors" as 
select distinct fp.VendorBusinessEntityID, de.Name as "vendorName", fp.ProductID as productID, dp.Name as productName
from factPurchases fp
join dimVendor de
on fp.VendorBusinessEntityID = de.VendorBusinessEntityID
join dimProduct dp
on fp.ProductID = dp.ProductID


create view "purchaseOrderHeader" as
select distinct fp.factPurchaseSK, 
fp.EmpBusinessEntityID,fp.VendorBusinessEntityID, salesAmount, taxAmt , frieght , totalDue, dv.name
from factPurchases fp
join dimvendor dv
on fp.VendorBusinessEntityID = dv.VendorBusinessEntityID

select * from "purchaseOrderHeader"


create View "VendorPurchases" as
with temp as (
select distinct fp.factPurchaseSK, 
fp.EmpBusinessEntityID,fp.VendorBusinessEntityID, salesAmount, taxAmt , frieght , totalDue, dv.name
from factPurchases fp
join dimvendor dv
on fp.VendorBusinessEntityID = dv.VendorBusinessEntityID
) 
select name, sum(salesAmount) as "totalSales"
from temp 
group by name 

drop view "VendorPurchases"

select * from "VendorPurchases"
order by 2 desc

create view "productSales" as
with valuesa as (
select  (unitPrice*orderQuantity) as "Ordervalue",  fp.ProductID, dp.Name
from factPurchases fp
join dimProduct dp
on fp.ProductID = dp.ProductID
)
select sum(Ordervalue) as totalSales, name 
from valuesa
group by name


create view "vendorPurchases" as
with temp as (
select distinct fp.factPurchaseSK, 
fp.EmpBusinessEntityID,fp.VendorBusinessEntityID, salesAmount, taxAmt , frieght , totalDue, dv.name
from factPurchases fp
join dimvendor dv
on fp.VendorBusinessEntityID = dv.VendorBusinessEntityID
) 
select distinct VendorBusinessEntityID, name, sum(t.salesAmount) as "totalSales", 
--(select sum(salesAmount) from factPurchases fp3 where fp3.VendorBusinessEntityID = t.VendorBusinessEntityID) as "totalSales", 
(select sum(orderQuantity) from factPurchases fp2 where fp2.VendorBusinessEntityID = t.VendorBusinessEntityID) as "purchasedQuantity"
from temp t
group by VendorBusinessEntityID, name


select * from  "vendorPurchases"
order by 3 desc

create view "VendorGeo" as
with temp as (
select distinct fp.factPurchaseSK, 
fp.EmpBusinessEntityID,fp.VendorBusinessEntityID, salesAmount, taxAmt , frieght , totalDue, dv.name
from factPurchases fp
join dimvendor dv
on fp.VendorBusinessEntityID = dv.VendorBusinessEntityID
) 
select provinceName, city, sum(salesAmount) as Purchases
from temp t
join dimVendor v
on t.VendorBusinessEntityID = v.VendorBusinessEntityID
join dimGeography ad
on v.AddressID = ad.addressid
group by provinceName, city

select * from "VendorGeo"
order by 1, 2


select * from vendorContacts
order by 1

create view vendorContact as 
with temp as (
select distinct fp.factPurchaseSK, 
fp.EmpBusinessEntityID,fp.VendorBusinessEntityID, salesAmount, taxAmt , frieght , totalDue, dv.name
from factPurchases fp
join dimvendor dv
on fp.VendorBusinessEntityID = dv.VendorBusinessEntityID
) 
select vc.firstName, vc.lastName, vc.VendorName, sum(t.salesAmount) as totalSales, vc.contactType
from temp t
join vendorContacts vc
on vc.VendorBusinessEntityID = t.VendorBusinessEntityID
group by vc.firstName, vc.lastName, vc.VendorName, vc.contactType

select * from vendorContact
order by 3



