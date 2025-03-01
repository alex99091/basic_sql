# SQL(Structured-Query Language)

## Part 1. Conecpt
### 1. 모델링 (Modeling)
```
데이터베이스 모델링은 현실 세계의 데이터를 체계적으로 구조화하는 과정, 
주로 ERD(Entity-Relationship Diagram)를 사용하여 데이터 간의 관계를 정의.
```

##### 데이터 모델의 종류
- **개념적 모델**: 사용자의 관점에서 데이터 구조를 정의 (ERD 활용)
- **논리적 모델**: 특정 DBMS에 독립적인 논리적 구조 설계 (정규화 적용)
- **물리적 모델**: 특정 DBMS의 물리적 저장 구조까지 고려한 설계
- **모델링의 순서**:  개념 → 논리 → 물리

### 2. 스키마 (Schema)
```
데이터베이스의 구조와 제약 조건을 정의하는 개념적 틀입니다.
```

#### 스키마의 종류 및 관점
```
외부 스키마 (사용자 관점): 사용자 또는 응용 프로그램이 바라보는 데이터 구조
개념 스키마 (설계자 관점): 전체적인 논리적 구조를 정의
내부 스키마 (개발자 관점): 데이터의 물리적 저장 구조 및 최적화를 담당
```

### 3. 정규형 (Normalization)
```
데이터의 중복을 최소화하고 일관성을 유지하기 위한 데이터베이스 설계 과정입니다.
```

#### 정규화 단계 및 예시
- **1NF (제1정규형)**: 원자성 유지 (각 컬럼은 단일 값만 가짐)
```
예: `이름 | 전화번호` → 전화번호가 여러 개일 경우 분리 필요
```
- **2NF (제2정규형)**: 부분 함수 종속 제거 (기본키의 부분 집합이 결정자가 되는 관계 제거)
```
예: `학생ID, 과목코드 | 교수명` → 과목코드만으로 교수명이 결정된다면 분리 필요
```
- **3NF (제3정규형)**: 이행적 함수 종속 제거 (비키 속성이 다른 비키 속성을 결정하는 관계 제거)
```
예: `학번 | 학과코드 | 학과이름` → 학과코드로 학과이름을 찾을 수 있다면 분리 필요
```
- **BCNF (보이스-코드 정규형)**: 결정자가 후보키가 아닌 함수 종속 제거
- **4NF (제4정규형)**: 다치 종속 제거
- **5NF (제5정규형)**: 조인 종속 제거

### 4. 도메인/인스턴스/속성
```
- 도메인(Domain): 각 속성이 가질 수 있는 값의 범위
- 인스턴스(Instance): 특정 시점에서의 테이블 내 개별 행(레코드) 데이터
- 속성(Attribute): 테이블의 컬럼으로, 특정 데이터를 저장하는 필드
```

### 5. 식별자 / 비식별자

- **1) 식별자 (Identifier)**: 각 개체(entity)를 고유하게 식별하는 속성
```
- 주 식별자: 기본키 (PK)로 사용되는 속성
- 보조 식별자: 보조적인 식별 용도로 사용되는 속성
```
- **2) 비식별자 (Non-Identifier)**: 데이터의 구분에는 사용되지 않지만 정보 제공을 위해 존재하는 속성

### 6. DDL / DML / DCL 개념

- **1) DDL (Data Definition Language)**:데이터베이스 구조를 정의하는 SQL 명령어
```
`CREATE` (테이블, 뷰, 인덱스 생성)
`ALTER` (구조 변경)
`DROP` (삭제)
`TRUNCATE` (모든 데이터 삭제, 구조는 유지)
```

- **2) DML (Data Manipulation Language)**:데이터를 조회하고 조작하는 SQL 명령어
```
`SELECT` (데이터 조회)
`INSERT` (데이터 삽입)
`UPDATE` (데이터 수정)
`DELETE` (데이터 삭제)
`MERGE` (두 개의 테이블을 조합하여 삽입, 수정, 삭제 수행)
`CALL` (저장 프로시저 실행)
`EXPLAIN PLAN` (SQL 실행 계획 확인)
`LOCK TABLE` (테이블 잠금)
```

- **3) DCL (Data Control Language)**:데이터베이스의 권한을 관리하는 SQL 명령어
```
`GRANT` (사용자에게 권한 부여)
`REVOKE` (사용자의 권한 회수)
`COMMIT` (변경 사항 저장)
`ROLLBACK` (변경 사항 취소)
`SAVEPOINT` (특정 시점으로 롤백 가능하도록 저장)
```

## Part 2. SQL Query Functions

### 📌 NULL 처리 함수

##### 1. `NVL(expression, replacement)` 
- NULL 값을 다른 값으로 대체
- `expression`이 NULL이면 `replacement` 값을 반환합니다.  

```sql
SELECT NVL(NULL, 'Default Value') FROM DUAL; 
결과: 'Default Value'
```

##### 2. `NULLIF(expression1, expression2)`
- 두 값이 같으면 NULL 반환
- expression1 == expression2이면 NULL 반환, 다르면 expression1을 반환합니다.
```sql
SELECT NULLIF(100, 100), NULLIF(100, 200) FROM DUAL; 
결과: NULL, 100
```

##### `3. COALESCE(expression1, expression2, ...)`
- NULL이 아닌 첫 번째 값 반환
- 여러 인자 중 NULL이 아닌 첫 번째 값을 반환합니다.
- NVL과 달리 여러 개의 인자를 받을 수 있어 더 유연합니다.
```sql
SELECT COALESCE(NULL, NULL, 'First Non-NULL', 'Second') FROM DUAL;
결과: 'First Non-NULL'
```

#### 🔹 차이점 정리
| 함수       | 목적 |
|------------|--------------------------------|
| `NVL`      | NULL이면 다른 값으로 대체 (2개 인자만) |
| `NULLIF`   | 두 값이 같으면 NULL 반환 |
| `COALESCE` | NULL이 아닌 첫 번째 값을 반환 (여러 개 인자 가능) |

### ✂ 문자열 다듬기 (TRIM 관련 함수)

##### TRIM 함수란 ?
-- 문자열의 공백이나 특정 문자를 제거하는 함수입니다.

##### 1. LEADING 
- 앞쪽 제거
```sql
SELECT TRIM(LEADING '0' FROM '0001234') FROM DUAL;
결과: '1234'
```

##### 2. TRAILING
- 뒤쪽 제거
```sql
SELECT TRIM(TRAILING '!' FROM 'Hello!!!') FROM DUAL;
결과: 'Hello'
```
##### 3. BOTH
- 양쪽 제거
```sql
SELECT TRIM(BOTH '-' FROM '--Hello-') FROM DUAL;
결과: 'Hello'
```

#### 🔹 차이점 정리

| 함수       | 목적 |
|------------|--------------------------------|
| `TRIM`     | 문자열에서 특정 문자 제거 |
| `LEADING`  | 문자열 앞부분에서 특정 문자 제거 |
| `TRAILING` | 문자열 뒷부분에서 특정 문자 제거 |
| `BOTH`     | 문자열 양쪽에서 특정 문자 제거 |


### 📌 JOIN 종류 정리

##### 1. `INNER JOIN`
- 교집합: 두 테이블에서 일치하는 행만 반환
```sql
SELECT A.*, B.*
FROM TableA A
INNER JOIN TableB B ON A.id = B.id;
결과: A.id = B.id 조건이 일치하는 행만 반환
```

##### 2. `OUTER JOIN`
- 합집합: 한쪽 테이블에 없는 값도 포함할 수 있는 JOIN
- `LEFT OUTER JOIN`: 왼쪽 테이블은 모두 포함, 오른쪽 테이블은 일치하는 값만 포함
```sql
SELECT A.*, B.*
FROM TableA A
LEFT JOIN TableB B ON A.id = B.id;

결과: 
TableA의 모든 행을 포함
TableB에 일치하는 값이 없으면 NULL 반환
```
- `RIGHT OUTER JOIN`: 오른쪽 테이블은 모두 포함, 왼쪽 테이블은 일치하는 값만 포함
```sql
SELECT A.*, B.*
FROM TableA A
RIGHT JOIN TableB B ON A.id = B.id;

결과: 
TableB의 모든 행을 포함
TableA에 일치하는 값이 없으면 NULL 반환
```
- `FULL OUTER JOIN`: 두 테이블의 모든 행을 포함, 일치하지 않는 값은 NULL 처리
```sql
SELECT A.*, B.*
FROM TableA A
FULL OUTER JOIN TableB B ON A.id = B.id;

결과:
INNER JOIN과 다르게 양쪽 테이블에 일치하는 값이 없더라도 포함
없는 값은 NULL로 채움
```

##### 3. `NATURAL JOIN`
- 자동으로 같은 컬럼명을 기준으로 조인 (ON 절 필요 없음)

```sql
SELECT *
FROM TableA
NATURAL JOIN TableB;

결과:
TableA와 TableB에서 같은 컬럼명을 가진 컬럼을 기준으로 조인
조인 조건을 지정하지 않기 때문에 컬럼명이 다르면 예기치 않은 결과가 나올 수 있음
```

##### 4. `CROSS JOIN`
- 모든 조합을 반환하는 데카르트 곱 (Cartesian Product)
```sql
SELECT A.*, B.*
FROM TableA A
CROSS JOIN TableB B;

결과:
TableA와 TableB의 모든 행을 조합
TableA에 3개, TableB에 2개 행이 있다면 3 × 2 = 6개 행 반환
```

#### 🔹 JOIN 비교 정리  

| JOIN 종류       | 설명 |
|---------------|--------------------------------------------------|
| `INNER JOIN`  | 두 테이블에서 일치하는 행만 반환 (교집합) |
| `LEFT JOIN`   | 왼쪽 테이블은 모두 포함, 오른쪽은 일치하는 행만 포함 |
| `RIGHT JOIN`  | 오른쪽 테이블은 모두 포함, 왼쪽은 일치하는 행만 포함 |
| `FULL JOIN`   | 두 테이블의 모든 행을 포함하고, 없는 값은 `NULL` 처리 |
| `NATURAL JOIN`| 같은 컬럼명을 가진 컬럼을 자동으로 조인 |
| `CROSS JOIN`  | 두 테이블의 모든 행을 조합 (데카르트 곱) |


### 📌 집계 함수
- SQL에서 데이터를 그룹화하고 집계할 때 사용하는 함수

##### 1. `GROUP BY`
- 특정 컬럼을 기준으로 데이터를 그룹화하여 집계하는 기본 기능
```sql
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;

결과: 각 department 별 salary 합계를 계산
```
##### 2. `ROLLUP`
- 계층적인 그룹화를 수행하여 부분 합계를 포함한 결과를 반환
- GROUP BY에 총합(TOTAL) 을 포함하는 기능이 추가됨
```sql
SELECT department, job_title, SUM(salary) AS total_salary
FROM employees
GROUP BY ROLLUP(department, job_title);

결과:
각 department 별 job_title 합계
각 department의 총합
전체 총합
```
##### 3. `CUBE`
- 모든 가능한 조합에 대한 집계를 수행
- ROLLUP과 달리 다차원 그룹화 를 지원
```sql
SELECT department, job_title, SUM(salary) AS total_salary
FROM employees
GROUP BY CUBE(department, job_title);

결과:
모든 department 별 job_title 합계
각 department의 총합
각 job_title의 총합
전체 총합
```
##### 4. `GROUPING SETS`
- 특정 그룹화 집합을 선택적으로 적용하는 기능
- ROLLUP과 CUBE의 확장 기능으로, 필요한 그룹화 조합만 지정할 수 있음
```sql
SELECT department, job_title, SUM(salary) AS total_salary
FROM employees
GROUP BY GROUPING SETS ((department, job_title), (department), ());

결과:
department + job_title 별 합계
department 별 합계
전체 총합
```
##### 5. `GROUPING`
- ROLLUP, CUBE 사용 시 NULL이 생성된 행을 구분하는 함수
- GROUPING(column_name) 값이 1이면 해당 열이 집계된 행을 의미
```sql
SELECT department, job_title, SUM(salary) AS total_salary, GROUPING(department) AS dept_group
FROM employees
GROUP BY ROLLUP(department, job_title);

결과: GROUPING(department) = 1 인 행은 부서별 총합 행을 의미
```

##### 6. `PARTITION BY`
- 윈도우 함수와 함께 사용하여 그룹을 나누지만, 개별 행을 유지하면서 집계 결과를 적용
- GROUP BY와 달리 행을 그룹화하지 않고 개별 행을 유지한 채 계산을 수행
```sql
SELECT employee_id, department, salary,
       SUM(salary) OVER (PARTITION BY department) AS total_department_salary
FROM employees;

결과: 
같은 department 내 모든 행에 department별 총급여(SUM(salary))가 추가됨
원본 행이 유지됨 (즉, 행이 줄어들지 않음)
```

#### 📝 GROUP BY 확장 기능 비교 

| 기능            | 설명 |
|---------------|--------------------------------------------------|
| `GROUP BY`    | 특정 컬럼을 기준으로 그룹화 |
| `ROLLUP`      | 계층적 그룹화 (부분 합계 + 전체 합계 포함) |
| `CUBE`        | 모든 가능한 조합으로 그룹화 |
| `GROUPING SETS` | 필요한 그룹화 조합만 선택적으로 적용 |
| `GROUPING`    | `ROLLUP`/`CUBE` 사용 시 집계된 행을 구분 |
| `PARTITION BY` | 행을 그룹화하지만 집계 결과를 개별 행에 유지 |


### 📌 순위 함수 (Ranking Functions) 정리

##### 1. `RANK`
- 동점이 있을 경우 순위가 건너뛰는 방식
- 동일한 값에 같은 순위를 부여하지만, 다음 순위는 건너뜀
- `ORDER BY` 기준에 따라 정렬된 데이터에 순위를 매김 
```sql
SELECT employee_id, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;
```
| employee_id | department | salary | rank |
|------------|------------|--------|------|
| 101        | Sales      | 5000   | 1    |
| 102        | Sales      | 5000   | 1    |
| 103        | Sales      | 4000   | 3    |
| 104        | Sales      | 3000   | 4    |


##### 2. `DENSE_RANK`
- 동점이 있어도 순위가 건너뛰지 않는 방식
- RANK와 비슷하지만, 순위가 연속적으로 매겨짐
- 동일한 값에 같은 순위를 부여하지만, 다음 순위가 건너뛰지 않음

```sql
SELECT employee_id, department, salary,
       DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank
FROM employees;
```
| employee_id | department | salary | dense_rank |
|------------|------------|--------|------------|
| 101        | Sales      | 5000   | 1          |
| 102        | Sales      | 5000   | 1          |
| 103        | Sales      | 4000   | 2          |
| 104        | Sales      | 3000   | 3          |


##### 3. `ROW_NUMBER`
- 모든 행에 고유한 순위를 부여 (동점 없음)
- 동일한 값이라도 각 행에 고유한 번호를 부여
- 같은 값이 있어도 순위가 임의로 정해짐

```sql
SELECT employee_id, department, salary,
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num
FROM employees;
```
| employee_id | department | salary | row_num |
|------------|------------|--------|---------|
| 101        | Sales      | 5000   | 1       |
| 102        | Sales      | 5000   | 2       |
| 103        | Sales      | 4000   | 3       |
| 104        | Sales      | 3000   | 4       |


#### 📝 순위 함수 비교

| 함수           | 설명 |
|---------------|--------------------------------------------------|
| `RANK`        | 동점자에게 같은 순위를 부여하지만, 다음 순위는 건너뜀 |
| `DENSE_RANK`  | 동점자에게 같은 순위를 부여하며, 다음 순위는 연속적으로 유지 |
| `ROW_NUMBER`  | 동점자 없이 모든 행에 고유한 순위를 부여 |


### 📌 특수 개념 정리

#####  📝 1. 계층형 질의 (Hierarchical Query)
- 트리 구조 데이터를 조회하는 SQL 기능
- 조직도, 카테고리 트리, 제품 계층 구조 등의 데이터를 처리할 때 사용  
- 오라클에서는 `CONNECT BY`를 사용하여 계층 구조를 탐색
```sql
SELECT employee_id, manager_id, LEVEL
FROM employees
CONNECT BY PRIOR employee_id = manager_id
START WITH manager_id IS NULL;

결과:
START WITH을 사용하여 계층 구조의 루트(최상위)를 설정
CONNECT BY PRIOR로 부모-자식 관계를 정의
LEVEL을 사용하여 계층 깊이를 나타냄
```


#####  📝 2. CONNECT BY
- 오라클에서 계층형 데이터를 탐색하는 SQL 구문
- PRIOR 키워드를 사용하여 부모-자식 관계를 설정
```sql
SELECT category_id, parent_category_id, LEVEL
FROM categories
CONNECT BY PRIOR category_id = parent_category_id
START WITH parent_category_id IS NULL;

결과:
LEVEL을 사용하면 트리 깊이를 알 수 있음
```


#####  📝 3. ORDER SIBLINGS BY
- 계층형 질의에서 동일한 부모를 가진 노드들을 정렬하는 기능
- ORDER SIBLINGS BY를 사용하면 같은 부모를 가지는 형제 노드들을 정렬할 수 있음
```sql
SELECT employee_id, manager_id, LEVEL
FROM employees
CONNECT BY PRIOR employee_id = manager_id
START WITH manager_id IS NULL
ORDER SIBLINGS BY employee_name;

순방향 정렬:
기본적으로 ASC 정렬됨

ORDER SIBLINGS BY employee_name DESC;
DESC를 붙이면 역순 정렬됨
```

##### 📌 4. PIVOT / UNPIVOT
- 행을 열로 변환(PIVOT), 열을 행으로 변환(UNPIVOT)하는 기능
- 주로 보고서나 데이터 마트에서 사용
```sql
SELECT *
FROM (SELECT department, job_title, salary FROM employees)
PIVOT (
    SUM(salary) 
    FOR job_title IN ('Manager', 'Developer', 'Sales')
);
결과: (행 → 열 변환)

SELECT * 
FROM employees
UNPIVOT (
    salary FOR job_title IN (Manager, Developer, Sales)
);
결과: (열 → 행 변환)
```


##### 📌 5. 정규표현식 (Regular Expressions, REGEXP)
- 문자열 패턴을 검색, 매칭, 변환하는 SQL 기능
- 오라클: REGEXP_LIKE, REGEXP_SUBSTR, REGEXP_REPLACE, REGEXP_INSTR
- MySQL, PostgreSQL 등에서도 지원됨
```
SELECT * 
  FROM users 
 WHERE REGEXP_LIKE(email, '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$');

결과: 이메일정규화
```


#### 📝 특수 개념 정리

| 개념            | 설명 |
|----------------|--------------------------------------------------|
| `CONNECT BY`   | 계층형 데이터를 탐색 (부모-자식 관계 정의) |
| `ORDER SIBLINGS BY` | 계층형 질의에서 같은 부모를 가진 항목 정렬 |
| `PIVOT`        | 행을 열로 변환 |
| `UNPIVOT`      | 열을 행으로 변환 |
| `REGEXP_LIKE`  | 정규표현식으로 특정 패턴 검색 |


#### 📌 DROP/TRUNCATE/DELTE 차이
| 기능          | DROP               | TRUNCATE            | DELETE             |
|--------------|--------------------|---------------------|--------------------|
| **삭제 대상** | 테이블 + 데이터 모두 | 데이터만 삭제 (테이블 유지) | 특정 행 삭제 가능 |
| **ROLLBACK**  | ❌ 불가능 (복구 안됨) | ❌ 불가능 (복구 안됨) | ✅ 가능 (트랜잭션 내에서) |
| **WHERE 사용** | ❌ 불가능           | ❌ 불가능            | ✅ 가능 (조건 삭제) |
| **AUTO_INCREMENT 초기화** | ✅ 초기화됨 | ✅ 초기화됨 | ❌ 유지됨 |
| **속도**      | 가장 빠름 (구조까지 삭제) | 빠름 (전체 삭제) | 상대적으로 느림 (행 단위) |
| **SQL 종류**  | DDL (데이터 정의어) | DDL (데이터 정의어) | DML (데이터 조작어) |

