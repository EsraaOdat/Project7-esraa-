CREATE DATABASE Project6Ecommerce;
GO 

USE Project6Ecommerce;

CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(max),
    email VARCHAR(max),
	phone_number varchar(max),
    image NVARCHAR(max),
    password NVARCHAR(max),
    passwordHash VARBINARY(MAX),
    passwordSalt VARBINARY(MAX),
    address NVARCHAR(max),
    points INT
);


CREATE TABLE Category (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(max),
    image NVARCHAR(max),
    description NVARCHAR(max)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(max),
    description NVARCHAR(max),
    image NVARCHAR(max),
    price DECIMAL(10, 2),
    category_id INT,
    color NVARCHAR(max),
    flower_color_id INT,
    price_with_discount DECIMAL(10, 2),
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE CASCADE
);

CREATE TABLE Cart_Item (
    Cart_Item_id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT,
    user_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
CREATE TABLE Copons (
    copon_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(max),
    amount DECIMAL(10, 2),
    date DATE,
    status INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    amount DECIMAL(10, 2),
    copon_id INT,
    status NVARCHAR(max),
    transaction_id NVARCHAR(max),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (copon_id) REFERENCES copons(copon_id) ON DELETE CASCADE
);

CREATE TABLE Order_Item (
    Order_Item_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

CREATE TABLE Comment (
    comment_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    product_id INT,
    comment NVARCHAR(max),
    status INT,
    date DATE,
    rating INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

CREATE TABLE Admin (
    admin_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(max),
    email VARCHAR(max),
    img NVARCHAR(max),
    password NVARCHAR(max),
    passwordHash VARBINARY(MAX),
    passwordSalt VARBINARY(MAX)
);

CREATE TABLE Contact (
    contact_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(max),
    email NVARCHAR(max),
    sub NVARCHAR(max),
    message NVARCHAR(max),
    sent_date DATE,
    admin_response NVARCHAR(max),
    response_date DATE,
    status INT
);


INSERT INTO Users (name, email, phone_number , image, password, passwordHash, passwordSalt, address, points) 
VALUES ('Alice Smith', 'alice@example.com', '123-456-7890', 'alice.png', 'password123', null, null, '123 Flower Lane', 10),
       ('Bob Johnson', 'bob@example.com', '987-654-3210', 'bob.png', 'password123', null, null, '456 Rose Street', 20),
       ('Charlie Davis', 'charlie@example.com', '456-789-1234', 'charlie.png', 'password123', null, null, '789 Tulip Ave', 30),
       ('Diana Clark', 'diana@example.com', '321-654-9870', 'diana.png', 'password123', null, null, '101 Daisy Road', 15),
       ('Eve Lewis', 'eve@example.com', '654-321-7890', 'eve.png', 'password123', null, null, '202 Sunflower Blvd', 25);

INSERT INTO Category (name, image, description) 
VALUES ('Roses', 'roses.png', 'A variety of beautiful roses.'),
       ('Tulips', 'tulips.png', 'Elegant tulip flowers.'),
       ('Daisies', 'daisies.png', 'Simple yet charming daisies.'),
       ('Sunflowers', 'sunflowers.png', 'Bright and cheerful sunflowers.');

	   INSERT INTO Products (name, description, image, price, category_id, color, flower_color_id, price_with_discount) 
VALUES ('Red Rose Bouquet', 'A bouquet of fresh red roses.', 'red_rose.png', 50.00, 1, 'Red', 1, 45.00),
       ('White Rose Bouquet', 'A bouquet of elegant white roses.', 'white_rose.png', 55.00, 1, 'White', 2, 50.00),
       ('Pink Rose Bouquet', 'A bouquet of charming pink roses.', 'pink_rose.png', 60.00, 1, 'Pink', 3, 55.00),
       ('Yellow Rose Bouquet', 'A bouquet of vibrant yellow roses.', 'yellow_rose.png', 45.00, 1, 'Yellow', 4, 40.00),
       ('Mixed Rose Bouquet', 'A bouquet of mixed color roses.', 'mixed_rose.png', 70.00, 1, 'Mixed', 5, 65.00);


INSERT INTO Products (name, description, image, price, category_id, color, flower_color_id, price_with_discount) 
VALUES ('Red Tulip Bouquet', 'A bouquet of beautiful red tulips.', 'red_tulip.png', 40.00, 2, 'Red', 1, 35.00),
       ('Yellow Tulip Bouquet', 'A bouquet of cheerful yellow tulips.', 'yellow_tulip.png', 45.00, 2, 'Yellow', 2, 40.00),
       ('White Tulip Bouquet', 'A bouquet of elegant white tulips.', 'white_tulip.png', 50.00, 2, 'White', 3, 45.00),
       ('Pink Tulip Bouquet', 'A bouquet of delightful pink tulips.', 'pink_tulip.png', 60.00, 2, 'Pink', 4, 55.00),
       ('Mixed Tulip Bouquet', 'A bouquet of mixed color tulips.', 'mixed_tulip.png', 65.00, 2, 'Mixed', 5, 60.00);


INSERT INTO Products (name, description, image, price, category_id, color, flower_color_id, price_with_discount) 
VALUES ('White Daisy Bouquet', 'A bouquet of fresh white daisies.', 'white_daisy.png', 30.00, 3, 'White', 1, 25.00),
       ('Yellow Daisy Bouquet', 'A bouquet of bright yellow daisies.', 'yellow_daisy.png', 35.00, 3, 'Yellow', 2, 30.00),
       ('Pink Daisy Bouquet', 'A bouquet of charming pink daisies.', 'pink_daisy.png', 40.00, 3, 'Pink', 3, 35.00),
       ('Purple Daisy Bouquet', 'A bouquet of elegant purple daisies.', 'purple_daisy.png', 45.00, 3, 'Purple', 4, 40.00),
       ('Mixed Daisy Bouquet', 'A bouquet of mixed color daisies.', 'mixed_daisy.png', 50.00, 3, 'Mixed', 5, 45.00);


INSERT INTO Products (name, description, image, price, category_id, color, flower_color_id, price_with_discount) 
VALUES ('Single Sunflower', 'A single bright sunflower.', 'single_sunflower.png', 10.00, 4, 'Yellow', 1, 8.00),
       ('Sunflower Bouquet', 'A bouquet of cheerful sunflowers.', 'sunflower_bouquet.png', 55.00, 4, 'Yellow', 2, 50.00),
       ('Mini Sunflower', 'A small and cute sunflower.', 'mini_sunflower.png', 8.00, 4, 'Yellow', 3, 6.00),
       ('Sunflower & Daisy Mix', 'A bouquet of sunflowers and daisies.', 'sunflower_daisy.png', 60.00, 4, 'Mixed', 4, 55.00),
       ('Sunflower Garden', 'A sunflower arrangement in a pot.', 'sunflower_garden.png', 70.00, 4, 'Yellow', 5, 65.00);


INSERT INTO Cart_Item (product_id, user_id, quantity)
VALUES (1, 1, 2), (2, 1, 1),
       (3, 2, 3), (4, 2, 1),
       (5, 3, 2), (6, 3, 1),
       (7, 4, 3), (8, 4, 1),
       (9, 5, 2), (10, 5, 1);


INSERT INTO Copons (name, amount, date, status)
VALUES ('SUMMER20', 20.00, '2024-09-01', 1),
       ('FALL15', 15.00, '2024-09-15', 1);


INSERT INTO Orders (user_id, amount, copon_id, status, transaction_id)
VALUES (1, 100.00, 1, 'Completed', 'TX001'), (1, 80.00, 2, 'Pending', 'TX002'),
       (2, 150.00, 1, 'Completed', 'TX003'), (2, 120.00, 2, 'Pending', 'TX004'),
       (3, 200.00, 1, 'Completed', 'TX005'), (3, 170.00, 2, 'Pending', 'TX006'),
       (4, 250.00, 1, 'Completed', 'TX007'), (4, 200.00, 2, 'Pending', 'TX008'),
       (5, 300.00, 1, 'Completed', 'TX009'), (5, 250.00, 2, 'Pending', 'TX010');


INSERT INTO Comment (user_id, product_id, comment, status, date, rating)
VALUES (1, 1, 'Beautiful roses! I loved them.', 1, '2024-09-05', 5),
       (2, 1, 'The bouquet was fresh and vibrant.', 1, '2024-09-06', 4),
       (3, 2, 'The white roses were elegant.', 1, '2024-09-07', 5),
       (4, 2, 'Would definitely order again!', 1, '2024-09-08', 5),
       (5, 3, 'Lovely pink roses.', 1, '2024-09-09', 4);


INSERT INTO Admin (name, email, img, password, passwordHash, passwordSalt)
VALUES ('Admin User', 'admin@example.com', 'admin.png', 'adminPass123', null, null);


INSERT INTO Contact (name, email, sub, message, sent_date, admin_response, response_date, status)
VALUES ('Customer 1', 'customer1@example.com', 'Order Inquiry', 'I have a question about my order.', '2024-09-05', 'We will respond shortly.', '2024-09-06', 1),
       ('Customer 2', 'customer2@example.com', 'Payment Issue', 'I encountered an issue with payment.', '2024-09-05', 'Payment confirmed.', '2024-09-06', 1),
       ('Customer 3', 'customer3@example.com', 'Product Inquiry', 'Is the product available?', '2024-09-07', 'Yes, it is available.', '2024-09-08', 1),
       ('Customer 4', 'customer4@example.com', 'Shipping Issue', 'When will my product be shipped?', '2024-09-07', 'Shipped today.', '2024-09-08', 1),
       ('Customer 5', 'customer5@example.com', 'Product Inquiry', 'Are there more colors available?', '2024-09-09', 'Yes, we have multiple colors.', '2024-09-10', 1);



