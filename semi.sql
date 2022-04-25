
create table user{
   user_id varchar2(30)  primary key,          -- 회원 아이디
   user_pwd varchar2(30) not null,             -- 회원 비밀번호
   user_name varchar2(50) not null,            -- 회원 이름
   user_email varchar2(50),                    -- 회원 이메일
   user_addr varchar2(500),                    -- 회원 주소
   user_phone varchar2(20),                    -- 회원 휴대전화
   user_point number(100),                     -- 회원 포인트
   }
   
create table admin(
 	admin_id varchar2(30) primary key,         -- 관리자 아이디
 	admin_pwd varchar2(30) not null,           -- 관리자 비밀번호
 	admin_name varchar2(50) not null,          -- 관리자 이름                  
)

CREATE TABLE seller(
 	seller_id varchar2(30) PRIMARY KEY,        -- 판매자 아이디
 	seller_pwd varchar2(30)  not null,         -- 판매자 비밀번호
 	seller_name varchar2(50) not null          -- 판매자 이름
)

CREATE TABLE product(
 	pno number(10) PRIMARY KEY,           -- 상품 번호
 	pname varchar2(50) not null,          -- 상품명
 	pcode varchar2(10) not null,          -- 카테고리 코드
 	pcompany varchar2(100),               -- 상품 제조사
 	pimage varchar2(100),                 -- 상품 이미지
  	pqty number(5) default 0,             -- 상품 수량
  	price number(10) default 0,           -- 상품 가격
  	pspec varchar2(30),                   -- 상품 스펙
  	pcontents varchar2(1000),             -- 상품 설명
  	point number(6) default 0,            -- 상품 포인트
  	pinputdate date                       -- 상품 입고일
)

create table category(
 	category_no number(3) primary key,      -- 카테고리 번호
 	category_code varchar2(8) not null,      -- 카테고리 코드
 	category_name varchar2(100) not null     -- 카테고리 이름
);
