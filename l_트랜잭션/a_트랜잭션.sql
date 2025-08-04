/*
	1. 트랜잭션 개요 
    : 데이터 베이스에서 하나의 논리적인 작업 단위를 의미
    - 여러 개의 작업(명령어)이 한 번에 처리되어야 할 때 사용
    > 중간에 하나라도 실패하면 '전체 작업을 취소(ROLLBACK)'
    > 모든 작업이 '문제없이 완료되면 확정(COMMIT)'
    
    2. 트랜잭션 목적
    : 여러개의 SQL 작업을 하나의 작업처럼 묶어서 처리
    > 데이터의 일관성과 신뢰성을 보장
    
    ex) A가 B에게 돈을 송금하는 경우
		: A 계좌에서 출금 + B 계좌에 입금(반드시 함께 실행되어야함)
        
	3. 트랜잭션의 4가지 특징 (ACID)
    Atmoicitiy (원자성): 트랜잭션 내 모든 작업을 모두 성공 또는 모두 실패 중 하나여야함 (ALL OR NOTHING)
    Consistency (일관성): 트랜잭션 전 후, 데이터베이스의 일관성 유지
    Isolation (독립성): 동시에 여러 트랜잭션이 실행되어도, 서로 간섭X
    Durability (지속성): 트랜잭션 성공시, 결과는 영구적으로 보존됨

	4. 트랜잭션 실행 흐름
    1) 트랜잭션 시작 - START TRANSACTION;
    2) SQL 명령어 실행 - INSERT, UPDATE, DELETE 등
    3) 문제없이 완료되면 - COMMIT
    4) 중간에 오류 발생 또는 취소시 - ROLLBACK
    
    START TRANSACTION;
    
    # START 이후 블럭 내의 명령어는 '하나의 명렁어 처럼 처리'
		>> 성공 또는 실패 둘 중 하나의 결과만 반환
        
	UPDATE	ACCOUNT 
		SET 잔고 = 잔고 - 1000
        WHERE  acount_id = 'A';
	
    UPDATE	ACCOUNT 
		SET 잔고 = 잔고 + 1000
        WHERE  acount_id = 'B';
        
	COMMIT;
		
	cf) SAVEPOINT: 트랜잭션 내 특정 지점 저장, 해당 지점으로 롤백(돌아가기) 가능
		savepoint 이름					> 되돌릴 수 있는 지점 저장
		rollback to savepoint 이름		> 지정한 지점으로 롤백
*/

-- 트랜잭션 실습 예제1
drop database if exists 트랜잭션;
create database if not exists 트랜잭션;
use 트랜잭션;

create table members (
	mem_id int primary key,
    mem_name varchar(50),
    mem_age int
);

create table purchases (
	purchase_id int primary key,
    mem_id int,
    product_name varchar(100),
    price int,
    
    foreign key(mem_id) references members(mem_id)
);

-- 트랜잭션 상태 확인 
select @@autocommit; -- 1
-- > 1: 자동 커밋이 활성화된 상태(기본값)
-- 		- 각 INSERT, update, delete 쿼리 실행 직후 자동 commit 됨
-- 		- 실패가 없으면 자동저장됨
-- > 0: 자동 커밋 비활성화된 상태
-- 		- 트랜잭션은 start transaction 또는 DML 문으로 시작
--  	- COMMIT 또는 ROLLBACK 을 직접 호출해야함

set autocommit = 0; -- 트랜잭션 수동 처리 
select @@autocommit; -- 0

-- 트랜잭션 시작
start transaction;

-- 이후 sql 문은 하나의 명령문으로 처리됨
insert into members
values 
	(1, '권지애', 25);
    
insert into purchases
values 
	(1, 2, '노트북', 200); -- FK 제약 조건 오류
    
commit; -- 예외가 없으면 변경 사항을 저장

select * from members;
select * from purchases;

-- 스토어드 프로시저 사용 예시
-- : 트랜잭션 쿼리를 전체 동시 실행하기 위함
delimiter $$

create procedure insert_member_and_purchases()
begin
	declare exit handler for sqlexception
    begin 
		-- 예외 발생시 롤백처리
		rollback;
        select '트랜잭션 롤백: 오르발생으로 모든 변경이 취소되었습니다.' AS message;
        end;
        
        -- 자동 커밋 비활성화 및 트랜잭션 시작
        start transaction;
        
        insert into members
        values 
			(101, '권지애', 25);
            
		insert into purchases
        values
			(1234, 999, '노트북', 200); ### 오류 발생 시점 ##### -> commit 되지 않고 위의 select 문으로 거슬러감
            
		-- 예외발생 없이 실행된 경우 커밋
        commit;
        
        select '트랜잭션 커밋: 모든 데이터가 성공적으로 저장되었습니다.' AS message;
end $$

delimiter ;

call insert_member_and_purchases();
select * from members;

-- #### 트랜잭션 예시2 #### --
drop database 트랜잭션;
create database 트랜잭션;
use 트랜잭션;
create table accounts (
	account_id int primary key auto_increment,
    account_holder varchar(50),
    balance int unsigned -- 잔고: 음수 불가능
);

create table transaction_log( -- 거래 기록 테이블
	transaction_id int primary key auto_increment,
    from_account_id int,
    to_account_id int,
    amount int,
    transaction_date datetime default current_timestamp, -- current_timestamp: 현재 날짜와 로컬 시간을 반환
    
    foreign key(from_account_id) references accounts(account_id),
    foreign key(to_account_id) references accounts(account_id)
);

insert into accounts (account_holder, balance)
values 
	('김동후', 50000),
    ('김지선', 40000);
    
select * from accounts;
-- 스토어드 프로시저 작성 --
delimiter $$

create procedure transfer_money()
begin
	declare from_balance int;
    
    -- 자동 커밋 해제
    set autocommit = 0;
    --
    start transaction;
    
    select balance into from_balance -- select 결과를 변수에 저장할때 사용하는 문법
    from accounts
	where
		account_holder = '김지선';
	
    -- 잔액에 10000원 이상일 경우에만 송금 실행
    if from_balance >= 10000 then
		update accounts 
        set balance = balance - 10000
        where
			account_holder = '김지선';
		
        update accounts 
        set balance = balance + 10000
        where
			account_holder = '김동후';
            
		insert into transaction_log (from_account_id, to_account_id, amount)
        values 
			(
				(select account_id from accounts where account_holder = '김지선'),
				(select account_id from accounts where account_holder = '김동후'),
                10000
            );
		commit; -- 성공적으로 끝나면 commit
	else
		rollback;
	end if;
    
end $$
delimiter ;

call transfer_money();

select * from accounts;
select * from transaction_log;












