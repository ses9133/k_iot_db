-- SQL 문 종류

-- 1. DDL (DB, DB 개체 구조 정의): CREATE, ALTER, DROP, TRUNCATE
-- 2. DML (데이터 CRUD): INSERT, SELECT, UPDATE, DELETE
-- 3. DCL(Control): 데이터 통제 언어
-- 		- GRANT(승인), REVOKE(취소)

-- DCL(Data Control Language)
-- : 데이터베이스 사용자 권한을 제어하는 SQL 명령어
-- - 보안과 접근 제어를 위한 역할 수행

-- 1. GRANT
-- : 특정 사용자에게 권한을 부여

-- 2. REVOKE
-- : 특정 사용자에게 부여된 권한을 회수 

-- DCL 사용 목적
-- 1) 보안 강화: 민감한 데이터에 접근 가능한 사용자 제한 가능
-- 2) 데이터 무결성 유지: 특정 사용자만 데이터를 수정할 수 있또록 제한 가능
-- 3) 역할 기반 접근 제어: 사용자의 역할에 따라 필요한 권한만 부여 가능

use korea_db;
select * from members;
select * from purchases;

-- 1) 사용자 계정 생성
-- : CREATE USER 명령어 사용
create user 'readonly_user'@'localhost' IDENTIFIED  BY '1234';

-- '계정명'@'접속범위설정' IDENTIFI0ED BY '사용자로그인비밀번호설정';
-- cf) 접속 범위 설정
-- - 'localhost': 현 시스템 컴퓨터를 의미 (MySQL 서버가 설치된 이 컴퓨터에서만 로그인 가능)
-- - '%': 어떤 IP 든지 접속 가능을 의미 (보안상 위험!, 실습 외에는 권장하지 않음)
-- - '127.0.0.1' : 해당 IP 주소를 가진 컴퓨터에서만 로그인 가능 (localhost 와 동일)

-- 2) 권한 부여
GRANT SELECT ON `korea_db`.* TO 'readonly_user'@'localhost';

/*
GRANT(승인하다)
 SELECT (조회 권한만 부여)
 ON ~ (해당 스키마의 해당 테이블을 대상으로 권한부여)
 TO ~ (특정 사용자에 대한 권한 부여. 즉 어떤 사용자에게 권한을 줄건지)
*/

-- 3) 권한 확인 방법
-- : SHOW GRANTS FOR '권한명'@'접속범위';
SHOW GRANTS FOR 'readonly_user'@'localhost';

-- cf) USAGE 권한 - 사실상 아무 권한도 없는 상태
-- >> 계정은 있지만, 어떤 작업도 할 수 없는 상태
-- 1) CREATE USER 이후 자동으로 USAGE 권한만 가진 계정이 생성
-- 2) 권한을 모두 회수한 뒤에도 USAGE 만 남음

# CLI (명령어)로 로그인하는 방법 - 명령 프롬프트 창에서 
# mysql -u 사용자이므 -p -h 호스트(위치)
# mysql -u readonly_user -p -h localhost

-- 모든 사용자 계정 목록 확인 
SELECT user, host FROM mysql.user;
-- root 계정 / root 비밀번호
-- readonly 계정 / 1234 비밀번호

-- 현재 로그인한 사용자 확인
SELECT current_user(); -- 현재접속한계정@권한위치 

use korea_db;

DROP USER 'readonly_user'@'localhost';































