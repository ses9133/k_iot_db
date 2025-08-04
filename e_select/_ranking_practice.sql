create database if not exists ranking_db;

use ranking_db;

create table brands (
	brand_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
	product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    brand_id BIGINT,
    
    FOREIGN KEY(brand_id) REFERENCES brands(brand_id) ON DELETE CASCADE
);

INSERT INTO brands (brand_name)
VALUES 
	('삼성전자'),
    ('애플'),
    ('LG전자');
    
INSERT INTO products (product_name, price, brand_id)
VALUES 
	('갤럭시 S24 Ultra', 1450000, 1), 
	('갤럭시 Z Fold 5', 1990000, 1), 
	('갤럭시 watch 6', 450000, 1), 
	('갤럭시 Buds 2 Pro', 200000, 1), 
	('갤럭시 Tab S10', 2450000, 1), 
	('갤럭시 Book 4 Pro', 3500000, 1),
    
    ('iPhone 15 Pro Max', 1890000, 2), 
	('iPhone 15 mini', 130000, 2), 
	('MacBook Pro 17', 3800000, 2), 
	('AirPods Pro 3', 390000, 2), 
	('Apple watch 3', 1090000, 2), 
	('Mac Mini M23', 890000, 2), 
    
    ('LG Gram 18', 2300000, 3),
    ('LG OLED TV', 5000000, 3),
    ('LG 퓨리케어 공기청정기', 850000, 3),
    ('LG 코드제로 청소기', 1100000, 3),
    ('LG 스탠바이미', 530000, 3),
    ('LG 트롬 오브제컬렉션 ', 2850000, 3);
    
-- 브랜드별 최고가 Top3 상품 추출
SELECT
	RANK() 
FROM
	products P
    JOIN brands B
    ON P.brand_id = B.brand_id
GROUP BY
	P.brand_id;
    
