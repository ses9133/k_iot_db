-- korea.db 에서 구매금앨(amount) 가 가장 높은 회원의 member_id, name, 총 구매금액을 조회
-- 실행순서 FWGHSO 
SELECT
	M.member_id, name, SUM(amount) AS total_amount
FROM 
	`members` AS M
    INNER JOIN `purchases` AS P 
    ON M.member_id = P.member_id
GROUP BY
	M.member_id
ORDER BY
	total_amount DESC
LIMIT 1;

-- baseball_league 사용 예제
USE `baseball_league`;

SELECT * FROM `players`; -- player_id(PK), name, positon, birth_date, team_id(FK)
SELECT * FROM `teams`; -- team_id(PK), name, city, founded_year

-- 1. 내부 조인
-- 1) 타자인 선수와 해당 선수가 속한 팀 이름 가져오기
-- - players 테이블 -> 선수 이름, teams 테이블 -> 팀 이름
SELECT
	P.name, T.name, position
FROM
	`players` P
    INNER JOIN `teams` T
    ON P.team_id = T.team_id
WHERE
	position = '타자';
    
-- 2) 1990 년 이후 창단된 팀의 선수 목록 가져오기
SELECT
	T.name, P.name, T.founded_year
FROM
	`teams` T
    JOIN `players` P
    ON T.team_id = P.team_id
WHERE
	T.founded_year >= 1990;
	
--  2. 외부 조인
-- 1) 모든 팀과 그 팀에 속한 선수 목록 가져오기
SELECT
	T.name team_name, P.name player_name
FROM
	`teams` T
    LEFT OUTER JOIN `players` P
	ON T.team_id = P.team_id;

-- 모든 팀과 해당 팀에 속한 타자 목록 가져오기
SELECT
	T.name team_name, P.name player_name, P.position
FROM
	`teams` T
    LEFT OUTER JOIN `players` P
	ON T.team_id = P.team_id
WHERE
	P.position = '타자';

-- 2) 모든 선수와 해당 선수가 속한 팀 이름 가져오기
SELECT
	P.name player_name, T.name team_name
FROM
	`players` P
    LEFT OUTER JOIN `teams` T
    ON T.team_id = P.team_id;























































