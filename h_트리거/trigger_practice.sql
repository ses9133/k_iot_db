select * from players;
desc players;

-- 문제 1
create table if not exists player_delete_logs (
	name varchar(100),
    log_date datetime
)
-- 선수 테이블에서 삭제하고 나면 삭제로그에 이름과 삭제시간을 모든 열에 insert 하는 trigger
delimiter $$

create trigger after_player_delete
	after delete 
    on `players`
    for each row
begin
	insert into player_delete_logs
    values (
		OLD.name, curdate()
    );
end $$
delimiter ;

delete from players
where player_id = 101;

select * from players;

select * from player_delete_logs;

select * from player_position_logs;
-- 문제 2
-- 선수 포지션을 업데이트하고 나면 선수이름, 이전 포지션, 이후 포지션 로그를 만드는 트리거

update players
	set position = '외야수'
    where position = '내야수';
    
create table if not exists player_position_logs (
	log_id int auto_increment primary key,
    name varchar(50),
    old_position varchar(20),
    new_position varchar(20),
    changed_time datetime
);

delimiter $$

-- drop trigger after_player_position_update;

create trigger after_player_position_update 
	after update
    on players
    for each row
begin 
	insert into player_position_logs (name, old_position, new_position) 
    values (
		name, OLD.position, NEW.position
    );
end $$
delimiter ;

-- 문제 3
ALTER TABLE teams ADD COLUMN player_count INT DEFAULT 0;
select * from teams;

-- 삭제시 인원 -1
delimiter $$

create trigger after_player_delete_count
	after delete
    on players
    for each row
begin
	update teams
		set player_count = player_count - 1
        where team_id = OLD.team_id;

end $$
delimiter ;
    
-- 추가시 인원 +1
delimiter $$

create trigger after_player_insert_count
	after insert
    on players
    for each row
begin
	update teams
		set player_count = player_count + 1
        where team_id = New.team_id;
end $$
delimiter ;

insert into players
values (
	333, 'sdf', '외야수', '2000-07-31', 1
);






