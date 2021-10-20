# AdventureWorks-Purchasing-Data-Warehouse

Background:
1. AdventureWorks sells bikes, bike components and bile clothing directly to customers on internet and to stores, such as bike shops, that resell their products. 
2. AdventureWorks purchases products from vendors that they either resell or use as components in their own finished goods that they build (and then sell.) 
3. AdventureWorks contains the purchasing and related data that AdventureWorks business personnel need to answer many business questions and to perform analysis. 
4. The AdventureWorksDW has been created to enable reporting and BI, however, much of the data needed for purchasing related analysis are not present in that DW.

Deliverables:
1. Puchasing Data Warehouse Dimensional Model
2. Alteryx workflows to populate Tables
3. Create PowerBI Visualizations

Objectives:
1. All product purchases made by AdventureWorks from vendors, i.e. purchase orders 
2. List of products that might be purchased from Vendors, in other words, all the products that are not made by AdventureWorks
3. Need to include product attributes such as list price, standard cost, model name, subcategory name and category name. Current values is sufficient.
4. Vendors that AdventureWorks might purchase products from
5. Products that AdventureWorks might purchase from vendors and associated with the vendors that sell them.
6. Vendors’ employees (contacts) who interact with AdventureWorks 
7. AdventureWorks’ employees who have bought products from vendors and include attributes about those people such as address, email, phone, department they currently work in
8. AdventureWorks’ ship methods
9. A geography dimension used as outrigger for dimensions above that include cities, states and countries
10. A date (calendar) dimension that AdventureWorks could use for facts and dimensions 

Source Database: 
1. AdventureWorksDW2019
2. AdventureWorks2019

Dimensional Model: 
![image](https://user-images.githubusercontent.com/78456439/138182229-13f06e9a-9960-43cd-8b7b-5121935cafa4.png)

Alteryx Workflows:

![image](https://user-images.githubusercontent.com/78456439/138182535-048922ca-3909-41c5-a4ec-7f94a61c5945.png)

![image](https://user-images.githubusercontent.com/78456439/138182662-1cec34cf-1bdb-4a29-ab61-8859d53dde8b.png)

![image](https://user-images.githubusercontent.com/78456439/138182735-7104356e-7cd9-412c-bf86-157e5f744f4e.png)
