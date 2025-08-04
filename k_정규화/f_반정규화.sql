/*
	반정규화 (denormalzation)
    : 정규화된 데이터베이스 구조를 의도적으로 일부 되돌려, 중복을 허용하면서
		성능향상 또는 복잡한 조인 최소화를 위해 설계하는 기법
	- 성능을 위한 전략적인 선택
    - 조회(Read) 성능을 향상시키거나, 복잡한 JOIN 최소화를 목표로 사용
    
    정규화 vs 반정규화
    1) 정규화
		목적: 데이터 중복 제거, 무결성 유지
        장점: 데이터 일관성, 저장 공간의 절약
        단점: JOIN 많아져 성능 저하 가능성 
		- 사용시점: 트랜잭션 처리 중심 시스템
        
	2) 반정규화
		목적: 성능 향상, 조회 단순화
		장점: 빠른 조회 가능, JOIN 감소
        단점: 데이터 중복 발생, 무결성 유지 어려움
        - 사용시점: 조회/리포트 중심의 시스템
*/

-- 정규화된 테이블 예시
drop database if exists 비정규화;
create database if not exists 비정규화;

use 비정규화;

-- 고객 테이블
create table customers (
	customer_id bigint primary key auto_increment,
    name varchar(100),
    address varchar(255)
);

select * from customers;

-- 제품테이블
create table products (
	product_id bigint primary key auto_increment,
    product_name varchar(100),
    price int
);

select * from products;

-- 주문 테이블
create table orders (
	-- 주문의 공통 정보만 저장
    order_id bigint primary key auto_increment,
    customer_id bigint,
	order_date date,
    total_amount int,
   
    foreign key(customer_id) references customers(customer_id)
);

-- 주문 상세 테이블
create table order_details (
	order_detail_id bigint primary key auto_increment,
    order_id bigint, 
    product_id bigint,
    quantity int,

    foreign key(order_id) references orders(order_id), 
	foreign key(product_id) references products(product_id)
);

-- 반정규화 테이블 예시
create table order_denormal (
	order_id bigint primary key,
    customer_id bigint,
    customer_addr varchar(100),
    order_date date,
    product_name varchar(100),
    quantity int,
    price int,
    total_amount int
);
-- > 조인 없이 빠르게 주문 내역 조회가 가능
-- >> 고객이름, 주소, 또는 상품정보가 바뀌면 중복된 모든 행을 수정해야함






















