-- MySQL Workbench 환경 설정(basic.sql)

-- 1. 주석
-- 1) 단축키: ctrl + /

-- 2) 한 줄 주석: 하이픈 2개 또는 샵 1개
# 주석입니다.
-- 주석입니다.

-- 3) 여러 줄 주석: /**/
 
 -- 아래 쿼리문은 모든 DB 를 보여줌
 SHOW DATABASES;
 
 -- === 2. 글자 크기 변경 ===
 -- 1) ctrl + 마우스 휠 이동
 -- 2) Edit > Preferences > Fonts & Colors
 
 -- === 3. 명령어 대소문자 설정 ===
 -- : 문법의 대소문자 구분 XX
 --  >> 일관성 있는 작성을 권장
 -- 1) 명령어(문법)는 대문자
 -- 2) 테이블 또는 컬럼명은 소문자 작성
 -- cf) MySQL WORKBENCH 는 소문자 자동완성이 기본 설정되어있음
 -- 대문자 변환 단축키: ctrl + shift + u
 show databases;