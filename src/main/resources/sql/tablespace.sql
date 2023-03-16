--테이블스페이스 생성
create tablespace eduzino 
datafile 'C:\oraclexe\app\oracle\oradata\XE\eduzino.dbf' size 5M;

--유저생성
create user zino identified by 1234 default tablespace eduzino;

--권한부여
grant connect, resource to zino;

