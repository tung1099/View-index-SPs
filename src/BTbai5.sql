CREATE DATABASE Demo;
USE Demo;

CREATE TABLE Product (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
    productCode VARCHAR(20) NOT NULL ,
    productName VARCHAR(50) NOT NULL ,
    productPrice FLOAT,
    productAMount INT,
    productDescription VARCHAR(255),
    productStatus BIT
);

INSERT INTO Product VALUES
(1,'A1','TV',300,10,'TV',1),
(2,'A2','Computer',500,10,'May tinh',1),
(3,'A3','Bike',30,10,'Xe dap',1),
(4,'A4','Motor',100,10,'Xe may',1),
(5,'A5','Car',23000,10,'O to',1);

#INDEX
CREATE UNIQUE INDEX inx_pCode ON Product(productCode);
EXPLAIN SELECT productCode FROM Product;

CREATE INDEX inx_product ON Product(productName,productPrice);
EXPLAIN SELECT productName,productPrice FROM Product;

#VIEW
CREATE VIEW product_view AS
    SELECT productCode,productName,productPrice,productStatus
FROM Product;
SELECT * FROM product_view;
UPDATE product_view SET productPrice = 20 WHERE productPrice = 30;

DROP VIEW product_view;

#Store Procedure
# __ Hien thi toan bo san pham
DELIMITER //
create procedure showAllProduct()
begin
    select * from product;
end //
DELIMITER ;

call showAllProduct();

# __ Them san pham
DELIMITER //
create procedure addProduct(pId int, pCode varchar(20), pName varchar(50),
pPrice float, pAMount int, pDes varchar(50), pStatus bit)
begin
    insert into product values (pId,pCode,pName,pPrice,pAMount,pDes,pStatus);
end //
DELIMITER ;

call addProduct(6,'A6','Laptop',600,5,'May tinh xach tay',1);

# __ Sua san pham theo ID
DELIMITER //
create procedure editProduct(pId int, pCode varchar(20), pName varchar(50),
                             pPrice float, pAMount int, pDes varchar(50), pStatus bit)
begin
    update product p set p.productCode = pCode,
                         p.productName = pName,
                         p.productPrice = pPrice,
                         p.productAMount = pAMount,
                         p.productDescription = pDes,
                         p.productStatus = pStatus
    where p.id = pId;
end //
DELIMITER ;

call editProduct(6,'A06','LapTop',650,5,'MT xaxh tay',1);

# __ Xoa san pham theo ID
DELIMITER //
create procedure deleteProduct(pId int)
begin
    delete from product where product.id = pId;
end //
DELIMITER ;

call deleteProduct(6);