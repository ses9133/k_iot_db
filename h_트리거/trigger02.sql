-- 트리거 예제
USE `market_db`;

DROP table `singer`;

-- singer 테이블: member 테이블에서 데이터 추출
create table if not exists `singer`(
	select mem_id, mem_name, mem_number, addr
    from
		`member`
);

select * from `singer`;


-- 백업 테이블 : 변동 사항을 기록 할 테이블
create table `backup_singer` (
	mem_id char(8) not null,
    mem_name varchar(8) not null,
    mem_number int not null,
    addr char(2) not null,
    
    modType char(2), -- 변경 된 타입(수정인지 삭제인지)
    modDate date, -- 변경된 날짜
    modUser varchar(30)	-- 변경한 사용자
);

-- 변경이 (update) 발생했을 때 작동하는 트리거'
drop trigger if exists singer_updateTrg;

delimiter $$
create trigger singer_updateTrg
	after update
    on singer
    for each row
begin
	insert into backup_singer
    values 
		(
        OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr
        , '수정', curdate(), current_user()
        );
        
end $$
delimiter ;

select curdate();

# current_user() : 현재 작업중인 사용자
select current_user(); -- root@localhost

# OLD 테이블
-- : update 또는 delete 가 수행 될때, 변경 또는 삭제 전의 데이터가 잠깐 저장되는 임시테이블

update `singer` 
set 
	addr = '미국'
where
	mem_id = 'BLK';
-- em_id = 'BLK'	1 row(s) affected Rows matched: 1  Changed: 1  Warnings: 0	0.000 sec

select * from `backup_singer`;

update singer
set
	mem_number = 10
where
	mem_id = 'BLK';
    
select * from `backup_singer`;
    
select * from `singer`;

-- 삭제시 발생되는 트리거
drop trigger if exists `singer_deleteTrg`;

delimiter $$

create trigger `singer_deleteTrg`
	after delete
    on `singer`
    for each row

begin
	insert into `backup_singer`
    values
		(OLD.mem_id, OLD.mem_name, OLD.mem_number, OLD.addr
        , '삭제', curdate(), current_user()
        );
end $$
delimiter ;

delete from `singer`
where
	mem_number >= 7;
    
select * from `backup_singer`;
select * from `singer`;


