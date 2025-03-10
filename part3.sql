/* Chapter 3: SQL 기본 및 활용

 coalesce: NULL이 아닌 첫 번째 값 반환 (여러 인자 중)

 sample 테이블
 col1   col2    col3
 10     null    5
 null   15      10
 null   null    5
 20     10      5
*/

select sum(coalesce(col1, col2, col3)) as sum from sample;

/* 결과: 50 */

select d.dept_no
     , e.emp_id
  from emp e natural join on dept d; 

=>

select d.dept_no
     , e.emp_id
  from emp e natural join dept d; 

/* natural join 앞에 테이블명이나 alias를 붙이면 에러가 발생*/

select dempt_name
     , count(*) as cnt
     , case when count(*) < 10 then 'S'
            when count(*) < 20 then 'M'
            else 'L'
       end team_size
  from emp
 group by dept_name;

 /*
 select 문장의 논리적인 실행 순서
 from - where - group by - having - select - order by
 */

 select order_item,
        count(*) as cnt
  from cafe_order
 where order_date = '20211225'
 group by order_item
 having count(*) > 100;

/*
sign은 해당 숫자가 양수면 1, 음수면 -1을 출력
*/

 select sign(-25) from dual;
 select sign(8) from dual;

 /*
'_' 혹은 '%'가 포함된 문자를 검색하고자 할때 escape을 지정해서 쿼리를 작성할 수 있다.
escape '#'로 지정해주면 '#%' 혹은 '#_'가 문자 그대로 인식될 수 있다.
 */

col1    col2
1       %A
3       C%

select * from sample
where col2 like '%#%%' escape '#';

/*
substr의 두번째 인수가 음수일 경우 뒤에서부터 5번째자리 즉 X부터 3자리 XPE가 출력된다.
결과: XPE
*/
select substr('sql expert', -5, 3) from dual;