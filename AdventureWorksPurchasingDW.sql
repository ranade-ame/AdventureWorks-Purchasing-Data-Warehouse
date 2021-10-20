/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      purchasing v3.DM1
 *
 * Date Created : Sunday, October 17, 2021 21:15:41
 * Target DBMS : Microsoft SQL Server 2019
 */

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'team7_AdventureWorksPurchasingDW')
BEGIN
  CREATE DATABASE team7_AdventureWorksPurchasingDW;
END;
GO
use team7_AdventureWorksPurchasingDW;

CREATE TYPE AccountNumber FROM nvarchar(15) NULL
go

CREATE TYPE Flag FROM bit NOT NULL
go

CREATE TYPE Name FROM nvarchar(50) NULL
go

/* 
 * TABLE: dimDate 
 */

CREATE TABLE dimDate(
    DateKey                 int             NOT NULL,
    FullDateAlternateKey    date            NOT NULL,
    DayNumberOfWeek         tinyint         NOT NULL,
    EnglishDayNameOfWeek varchar(50)    NOT NULL,
    DayNumberOfMonth        tinyint         NOT NULL,
    DayNumberOfYear         smallint        NOT NULL,
    WeekNumberOfYear        tinyint         NOT NULL,
    EnglishMonthName varchar(50)    NOT NULL,
    MonthNumberOfYear       tinyint         NOT NULL,
    CalendarQuarter varchar(50)         NOT NULL,
    CalendarYear            smallint        NOT NULL,
    CalendarSemester        tinyint         NOT NULL,
    CONSTRAINT PK_DimDate_DateKey PRIMARY KEY NONCLUSTERED (DateKey)
)

go


IF OBJECT_ID('dimDate') IS NOT NULL
    PRINT '<<< CREATED TABLE dimDate >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dimDate >>>'
go

/* 
 * TABLE: dimEmployee 
 */

CREATE TABLE dimEmployee(
    EmpBusinessEntityID     int             NOT NULL,
    NationalIDNumber     varchar(100)    NULL,
    firstName            varchar(200)    NULL,
    lastName             varchar(250)    NULL,
    middleName           varchar(250)    NULL,
    emailAddress         varchar(150)    NULL,
    phone                bigint          NULL,
    LoginID              varchar(256)    NULL,
    OrganizationNode     varchar(75)     NULL,
    OrganizationLevel    smallint        NULL,
    JobTitle             varchar(150)    NULL,
    BirthDate            date            NULL
                         CONSTRAINT CK_Employee_BirthDate CHECK ([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate())),
    MaritalStatus        varchar(10)     NULL
                         CONSTRAINT CK_Employee_MaritalStatus CHECK (upper([MaritalStatus])='S' OR upper([MaritalStatus])='M'),
    Gender               varchar(50)     NULL
                         CONSTRAINT CK_Employee_Gender CHECK (upper([Gender])='F' OR upper([Gender])='M'),
    HireDate             date            NULL
                         CONSTRAINT CK_Employee_HireDate CHECK ([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate())),
    SalariedFlag         varchar(18)     DEFAULT ((1)) NULL,
    VacationHours        smallint        CONSTRAINT [DF_Employee_VacationHours] DEFAULT (0) NULL
                         CONSTRAINT CK_Employee_VacationHours CHECK ([VacationHours]>=(-40) AND [VacationHours]<=(240)),
    SickLeaveHours       smallint        CONSTRAINT [DF_Employee_SickLeaveHours] DEFAULT (0) NULL
                         CONSTRAINT CK_Employee_SickLeaveHours CHECK ([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120)),
    addressType          varchar(50)     NULL,
    AddressID            int             NOT NULL,
    SOR_ID               int             NULL,
    SOR_LoadDate         date            NULL,
    SOR_UpdateDate       date            NULL,
    DI_Job_ID            int             NULL,
    DI_Create_Date       date            NULL,
    DI_Modified_Date     date            NULL,
    CONSTRAINT PK_Employee_BusinessEntityID PRIMARY KEY NONCLUSTERED (EmpBusinessEntityID)
)

go


IF OBJECT_ID('dimEmployee') IS NOT NULL
    PRINT '<<< CREATED TABLE dimEmployee >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dimEmployee >>>'
go

/* 
 * TABLE: dimGeography 
 */

CREATE TABLE dimGeography(
    AddressID            int             NOT NULL,
    geographySK          int             NOT NULL,
    AddressLine1         varchar(250)    NULL,
    AddressLine2         varchar(150)    NULL,
    City                 varchar(150)    NOT NULL,
    stateProviceCode     varchar(150)     NULL,
    countryRegionCode    varchar(150)        NULL,
    provinceName varchar(150)        NULL,
    PostalCode          varchar(150)            NULL,
    countryName          varchar(150)        NULL,
    CONSTRAINT PK_Address_AddressID PRIMARY KEY NONCLUSTERED (AddressID)
)

go


IF OBJECT_ID('dimGeography') IS NOT NULL
    PRINT '<<< CREATED TABLE dimGeography >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dimGeography >>>'
go

/* 
 * TABLE: dimProduct 
 */

CREATE TABLE dimProduct(
    ProductID               int             ,
    Name                    varchar(250)    NOT NULL,
    ProductNumber           nvarchar(25)    NOT NULL,
    MakeFlag                int             DEFAULT (1) NULL,
    FinishedGoodsFlag       int             DEFAULT (1) NULL,
    Color                   varchar(15)     NULL,
    SafetyStockLevel        smallint        NULL
                            CONSTRAINT CK_Product_SafetyStockLevel CHECK ([SafetyStockLevel]>(0)),
    ReorderPoint            smallint        NULL
                            CONSTRAINT CK_Product_ReorderPoint CHECK ([ReorderPoint]>(0)),
    StandardCost            float           NULL
                            CONSTRAINT CK_Product_StandardCost CHECK ([StandardCost]>=(0.00)),
    ListPrice               float            NULL
                            CONSTRAINT CK_Product_ListPrice CHECK ([ListPrice]>=(0.00)),
    Size                    varchar(50)     NULL,
    Weight                  float           NULL
                            CONSTRAINT CK_Product_Weight CHECK ([Weight]>(0.00)),
    DaysToManufacture       int             NOT NULL
                            CONSTRAINT CK_Product_DaysToManufacture CHECK ([DaysToManufacture]>=(0)),
    ProductLine             varchar(2)      NULL
                            CONSTRAINT CK_Product_ProductLine CHECK (upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL),
    Class                   nchar(2)        NULL
                            CONSTRAINT CK_Product_Class CHECK (upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL),
    Style                   nchar(2)        NULL
                            CONSTRAINT CK_Product_Style CHECK (upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL),
    ProductSubcategoryID    int             NULL,
    modelName               varchar(50)     NULL,
    SellStartDate           datetime        NOT NULL,
    SellEndDate             datetime        NULL,
    DiscontinuedDate        datetime        NULL,
    ModifiedDate            datetime        CONSTRAINT [DF_Product_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    SOR_ID                  int             NULL,
    SOR_LoadDate            date            NULL,
    SOR_UpdateDate          date            NULL,
    DI_Job_ID               int             NULL,
    DI_Create_Date          date            NULL,
    DI_Modified_Date        date            NULL,
    CONSTRAINT PK_Product_ProductID PRIMARY KEY NONCLUSTERED (ProductID)
)

alter table dimProduct
alter column SellStartDate           datetime         NULL;
alter table dimProduct
alter column DaysToManufacture       int              NULL;
alter table dimProduct
alter column ProductNumber           nvarchar(25)     NULL;
alter table dimProduct
alter column  ModifiedDate            datetime     NULL;

go


IF OBJECT_ID('dimProduct') IS NOT NULL
    PRINT '<<< CREATED TABLE dimProduct >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dimProduct >>>'
go

/*alter table dimProduct
alter column StandardCost            float ;
alter table dimProduct
alter column ListPrice               float ;*/

/* 
 * TABLE: dimProductCategory 
 */

CREATE TABLE dimProductCategory(
    ProductCategoryID    int         not null,
    categoryName         Name        NULL,
    ModifiedDate         datetime    CONSTRAINT [DF_ProductCategory_ModifiedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT PK_ProductCategory_ProductCategoryID PRIMARY KEY NONCLUSTERED (ProductCategoryID)
)



go


IF OBJECT_ID('dimProductCategory') IS NOT NULL
    PRINT '<<< CREATED TABLE dimProductCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dimProductCategory >>>'
go

/* 
 * TABLE: dimProductSubcategory 
 */

CREATE TABLE dimProductSubcategory(
    ProductSubcategoryID    int         ,
    ProductCategoryID       int         NOT NULL,
    subCategoryName         Name        NULL,
    ModifiedDate            datetime    CONSTRAINT [DF_ProductSubcategory_ModifiedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT PK_ProductSubcategory_ProductSubcategoryID PRIMARY KEY NONCLUSTERED (ProductSubcategoryID)
)

go


IF OBJECT_ID('dimProductSubcategory') IS NOT NULL
    PRINT '<<< CREATED TABLE dimProductSubcategory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dimProductSubcategory >>>'
go

/* 
 * TABLE: dimShipmentMethod 
 */

CREATE TABLE dimShipmentMethod(
    ShipMethodID        int             NOT NULL,
    Name                varchar(150)    NULL,
    ShipBase            float           CONSTRAINT [DF_ShipMethod_ShipBase] DEFAULT (0.00) NULL
                        CONSTRAINT CK_ShipMethod_ShipBase_1 CHECK ([ShipBase]>(0.00)),
    ShipRate            float           CONSTRAINT [DF_ShipMethod_ShipRate] DEFAULT (0.00) NULL
                        CONSTRAINT CK_ShipMethod_ShipRate_1 CHECK ([ShipRate]>(0.00)),
    SOR_ID              int             NULL,
    SOR_LoadDate        date            NULL,
    SOR_UpdateDate      date            NULL,
    DI_Job_ID           int             NULL,
    DI_Create_Date      date            NULL,
    DI_Modified_Date    date            NULL,
    CONSTRAINT PK_ShipMethod_ShipMethodID_1 PRIMARY KEY NONCLUSTERED (ShipMethodID)
)

go


IF OBJECT_ID('dimShipmentMethod') IS NOT NULL
    PRINT '<<< CREATED TABLE dimShipmentMethod >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dimShipmentMethod >>>'
go

/* 
 * TABLE: dimVendor 
 */

create table vendorContacts(
	vendorBusinessEntityID int not null,
	VendorPersonID	 varchar(150) not null,
	vendorName varchar(150) null,
	firstName varchar(150) null,
	lastName varchar(150) null,
	contactType varchar(150) null
	CONSTRAINT PK_vendorContacts_BusinessEntityID PRIMARY KEY NONCLUSTERED (VendorPersonID)
)
ALTER TABLE vendorContacts ADD CONSTRAINT RefdimVendor60 
    FOREIGN KEY (vendorBusinessEntityID)
    REFERENCES dimVendor(VendorBusinessEntityID)

	select * from dimVendor


CREATE TABLE dimVendor(
    VendorBusinessEntityID           int               NOT NULL,
    AccountNumber              varchar(75)       NULL,
    Name                       varchar(250)      NULL,
    CreditRating               tinyint           NULL
                               CONSTRAINT CK_Vendor_CreditRating CHECK ([CreditRating]>=(1) AND [CreditRating]<=(5)),
    PreferredVendorStatus      tinyint           DEFAULT (1) NULL,
    ActiveFlag                 tinyint           DEFAULT (1) NULL,
    PurchasingWebServiceURL    nvarchar(1024)    NULL,
    SOR_ID                     int               NULL,
    SOR_LoadDate               date              NULL,
    SOR_UpdateDate             date              NULL,
    DI_Job_ID                  int               NULL,
    DI_Create_Date             date              NULL,
    DI_Modified_Date           date              NULL,
    CONSTRAINT PK_Vendor_BusinessEntityID PRIMARY KEY NONCLUSTERED (VendorBusinessEntityID)
)

go


IF OBJECT_ID('dimVendor') IS NOT NULL
    PRINT '<<< CREATED TABLE dimVendor >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE dimVendor >>>'
go


alter table dimVendor
add AddressID int 

ALTER TABLE dimVendor ADD CONSTRAINT RefdimGeography60 
    FOREIGN KEY (AddressID)
    REFERENCES dimGeography(AddressID)



select * from dimVendor

/* 
 * TABLE: factPurchases 
 */

CREATE TABLE factPurchases(
    factPurchaseSK      int      NOT NULL,
    orderID             int       not NULL,
    ProductID           int       NULL,
    VendorBusinessEntityID    int       NULL,
	EmpBusinessEntityID int      null,
    ShipMethodID        int       NULL,
    revisionNumber      int      NULL,
    dueDateKey          int       NULL,
    orderDateKey        int       NULL,
    shipDateKey         int       NULL,
    status              int      NULL,
    orderQuantity       int      NULL,
    salesAmount         float    NULL,
    unitPrice           float    NULL,
    [recieved Qty]      int      NULL,
    rejectedQty         int      NULL,
    stockedQty          int      NULL,
    taxAmt              float    NULL,
    totalDue            float    NULL,
    frieght             float    NULL,
    SOR_ID              int      NULL,
    SOR_LoadDate        date     NULL,
    SOR_UpdateDate      date     NULL,
    DI_Job_ID           int      NULL,
    DI_Modified_Date    date     NULL,
    DI_Create_Date      date     NULL,
    CONSTRAINT PK10 PRIMARY KEY NONCLUSTERED (factPurchaseSK, orderID)
)

go


IF OBJECT_ID('factPurchases') IS NOT NULL
    PRINT '<<< CREATED TABLE factPurchases >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE factPurchases >>>'
go
/*
alter table factPurchases
add EmpBusinessEntityID int
 FOREIGN KEY(EmpBusinessEntityID) REFERENCES dimEmployee(BusinessEntityID);*/



/* 
 * TABLE: dimEmployee 
 */

ALTER TABLE dimEmployee ADD CONSTRAINT RefdimGeography20 
    FOREIGN KEY (AddressID)
    REFERENCES dimGeography(AddressID)
go


/* 
 * TABLE: dimProduct 
 */

ALTER TABLE dimProduct ADD CONSTRAINT FK_Product_ProductSubcategory_ProductSubcategoryID 
    FOREIGN KEY (ProductSubcategoryID)
    REFERENCES dimProductSubcategory(ProductSubcategoryID)
go


/* 
 * TABLE: dimProductSubcategory 
 */

ALTER TABLE dimProductSubcategory ADD CONSTRAINT FK_ProductSubcategory_ProductCategory_ProductCategoryID 
    FOREIGN KEY (ProductCategoryID)
    REFERENCES dimProductCategory(ProductCategoryID)
go


/* 
 * TABLE: factPurchases 
 */

ALTER TABLE factPurchases ADD CONSTRAINT RefdimProduct4 
    FOREIGN KEY (ProductID)
    REFERENCES dimProduct(ProductID)
go

ALTER TABLE factPurchases ADD CONSTRAINT RefdimVendor5 
    FOREIGN KEY (VendorBusinessEntityID)
    REFERENCES dimVendor(VendorBusinessEntityID)
go

ALTER TABLE factPurchases ADD CONSTRAINT RefdimShipmentMethod9 
    FOREIGN KEY (ShipMethodID)
    REFERENCES dimShipmentMethod(ShipMethodID)
go

ALTER TABLE factPurchases ADD CONSTRAINT RefdimEmployee17 
    FOREIGN KEY (EmpBusinessEntityID)
    REFERENCES dimEmployee(EmpBusinessEntityID)
go

ALTER TABLE factPurchases ADD CONSTRAINT RefdimDate27 
    FOREIGN KEY (shipDateKey)
    REFERENCES dimDate(DateKey)
go

ALTER TABLE factPurchases ADD CONSTRAINT RefdimDate28 
    FOREIGN KEY (orderDateKey)
    REFERENCES dimDate(DateKey)
go

ALTER TABLE factPurchases ADD CONSTRAINT RefdimDate29 
    FOREIGN KEY (dueDateKey)
    REFERENCES dimDate(DateKey)
go


