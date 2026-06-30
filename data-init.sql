INSERT INTO [USER] (UserID, FirstName, LastName, Email, Phone, Password, Address, City, PostalCode)
VALUES (1, 'Nguyen', 'Van Manh', 'elroydevops@gmail.com', '0900000009', '0900000009', 'Ha Noi', 'Ha Noi', '000084');

-- Thêm dữ liệu vào bảng PRODUCT
INSERT INTO PRODUCT (ProductID, Name, Brand, Description, ImageURL)
VALUES 
    (1, 'Nike Air Max 270', 'Nike', 'The Nike Air Max 270 combines elements from the Air Max family and modern styling for a sneaker that''s sure to turn heads.', 'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/38321ec6-8c92-488d-924d-02dd07eaeceb/air-max-270-older-shoes-tnlrnr.png'),
    (2, 'Adidas Ultra Boost', 'Adidas', 'The Adidas Ultra Boost is a popular running shoe known for its comfort and style.', 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/f042b05ad1bf4d51b7dfaf1600054038_9366/Ultraboost_1.0_Shoes_White_HQ4202_01_standard.jpg'),
    (3, 'Converse Chuck Taylor All Star', 'Converse', 'The Converse Chuck Taylor All Star is a classic sneaker that''s been a staple for decades.', 'https://res.cloudinary.com/dfnhctsnk/image/upload/v1782030658/anh-converse_s4usrv.png'),
    (4, 'Vans Old Skool', 'Vans', 'The Vans Old Skool is a timeless skate shoe with a durable canvas and suede upper.', 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/4896bd57f0894845b5c0ae8300eec549_9366/Grand_Court_Cloudfoam_Comfort_Shoes_White_GW9195_01_standard.jpg'),
    (5, 'New Balance 574', 'New Balance', 'The New Balance 574 is a classic sneaker known for its comfort and versatility.', 'https://res.cloudinary.com/dfnhctsnk/image/upload/v1782030827/anh-new-blance_trrnaa.png'),
    (6, 'Puma Suede Classic', 'Puma', 'The Puma Suede Classic is a legendary sneaker known for its sleek design and comfort.', 'https://product.hstatic.net/1000284478/product/01_374915_1_b622d15c43ee4f2e85180cbb5b850fd3_large.jpg');

-- Thêm dữ liệu vào bảng PRODUCT_SIZE cho sản phẩm Nike Air Max 270 00
INSERT INTO PRODUCT_SIZE (ProductSizeID, Size, Price, Quantity, ProductID)
VALUES 
    (1, 36, 310, 10, 1),
    (2, 37, 310, 10, 1),
    (3, 38, 310, 10, 1),
    (4, 39, 310, 10, 1),
    (5, 40, 310, 10, 1),
    (6, 41, 310, 10, 1),
    (7, 42, 310, 10, 1),
    (8, 43, 310, 10, 1);

-- Thêm dữ liệu vào bảng PRODUCT_SIZE cho sản phẩm Adidas Ultra Boost
INSERT INTO PRODUCT_SIZE (ProductSizeID, Size, Price, Quantity, ProductID)
VALUES 
    (9, 36, 450, 10, 2),
    (10, 37, 450, 10, 2),
    (11, 38, 450, 10, 2),
    (12, 39, 450, 10, 2),
    (13, 40, 450, 10, 2),
    (14, 41, 450, 10, 2),
    (15, 42, 450, 10, 2),
    (16, 43, 450, 10, 2);

-- Thêm dữ liệu vào bảng PRODUCT_SIZE cho sản phẩm Converse Chuck Taylor All Star
INSERT INTO PRODUCT_SIZE (ProductSizeID, Size, Price, Quantity, ProductID)
VALUES 
    (17, 36, 100, 10, 3),
    (18, 37, 100, 10, 3),
    (19, 38, 100, 10, 3),
    (20, 39, 100, 10, 3),
    (21, 40, 100, 10, 3),
    (22, 41, 100, 10, 3),
    (23, 42, 100, 10, 3),
    (24, 43, 100, 10, 3);

-- Thêm dữ liệu vào bảng PRODUCT_SIZE cho sản phẩm Vans Old Skool
INSERT INTO PRODUCT_SIZE (ProductSizeID, Size, Price, Quantity, ProductID)
VALUES 
    (25, 36, 200, 10, 4),
    (26, 37, 200, 10, 4),
    (27, 38, 200, 10, 4),
    (28, 39, 200, 10, 4),
    (29, 40, 200, 10, 4),
    (30, 41, 200, 10, 4),
    (31, 42, 200, 10, 4),
    (32, 43, 200, 10, 4);

-- Thêm dữ liệu vào bảng PRODUCT_SIZE cho sản phẩm New Balance 574
INSERT INTO PRODUCT_SIZE (ProductSizeID, Size, Price, Quantity, ProductID)
VALUES 
    (33, 36, 150, 10, 5),
    (34, 37, 150, 10, 5),
    (35, 38, 150, 10, 5),
    (36, 39, 150, 10, 5),
    (37, 40, 150, 10, 5),
    (38, 41, 150, 10, 5),
    (39, 42, 150, 10, 5),
    (40, 43, 150, 10, 5);

-- Thêm dữ liệu vào bảng PRODUCT_SIZE cho sản phẩm Puma Suede Classic
INSERT INTO PRODUCT_SIZE (ProductSizeID, Size, Price, Quantity, ProductID)
VALUES 
    (41, 36, 199, 10, 6),
    (42, 37, 199, 10, 6),
    (43, 38, 199, 10, 6),
    (44, 39, 199, 10, 6),
    (45, 40, 199, 10, 6),
    (46, 41, 199, 10, 6),
    (47, 42, 199, 10, 6),
    (48, 43, 199, 10, 6);