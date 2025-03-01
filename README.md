# SQL(Structured-Query Language)

## Part 1. Conecpt
### 1. 모델링 (Modeling)
```
데이터베이스 모델링은 현실 세계의 데이터를 체계적으로 구조화하는 과정, 주로 ERD(Entity-Relationship Diagram)를 사용하여 데이터 간의 관계를 정의.
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

##### 스키마의 종류 및 관점
- **외부 스키마 (사용자 관점)**: 사용자 또는 응용 프로그램이 바라보는 데이터 구조
- **개념 스키마 (설계자 관점)**: 전체적인 논리적 구조를 정의
- **내부 스키마 (개발자 관점)**: 데이터의 물리적 저장 구조 및 최적화를 담당

### 3. 정규형 (Normalization)
```
데이터의 중복을 최소화하고 일관성을 유지하기 위한 데이터베이스 설계 과정입니다.
```

##### 정규화 단계 및 예시
- **1NF (제1정규형)**: 원자성 유지 (각 컬럼은 단일 값만 가짐)
  - 예: `이름 | 전화번호` → 전화번호가 여러 개일 경우 분리 필요
- **2NF (제2정규형)**: 부분 함수 종속 제거 (기본키의 부분 집합이 결정자가 되는 관계 제거)
  - 예: `학생ID, 과목코드 | 교수명` → 과목코드만으로 교수명이 결정된다면 분리 필요
- **3NF (제3정규형)**: 이행적 함수 종속 제거 (비키 속성이 다른 비키 속성을 결정하는 관계 제거)
  - 예: `학번 | 학과코드 | 학과이름` → 학과코드로 학과이름을 찾을 수 있다면 분리 필요
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
-- **주 식별자**: 기본키 (PK)로 사용되는 속성
-- **보조 식별자**: 보조적인 식별 용도로 사용되는 속성
- **2) 비식별자 (Non-Identifier)**: 데이터의 구분에는 사용되지 않지만 정보 제공을 위해 존재하는 속성

### 6. DDL / DML / DCL 개념

- **1) DDL (Data Definition Language)**:데이터베이스 구조를 정의하는 SQL 명령어
-- `CREATE` (테이블, 뷰, 인덱스 생성)
-- `ALTER` (구조 변경)
-- `DROP` (삭제)
-- `TRUNCATE` (모든 데이터 삭제, 구조는 유지)

- **2) DML (Data Manipulation Language)**:데이터를 조회하고 조작하는 SQL 명령어
-- `SELECT` (데이터 조회)
-- `INSERT` (데이터 삽입)
-- `UPDATE` (데이터 수정)
-- `DELETE` (데이터 삭제)
-- `MERGE` (두 개의 테이블을 조합하여 삽입, 수정, 삭제 수행)
-- `CALL` (저장 프로시저 실행)
-- `EXPLAIN PLAN` (SQL 실행 계획 확인)
-- `LOCK TABLE` (테이블 잠금)

- **3) DCL (Data Control Language)**:데이터베이스의 권한을 관리하는 SQL 명령어
-- `GRANT` (사용자에게 권한 부여)
-- `REVOKE` (사용자의 권한 회수)
-- `COMMIT` (변경 사항 저장)
-- `ROLLBACK` (변경 사항 취소)
-- `SAVEPOINT` (특정 시점으로 롤백 가능하도록 저장)

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
```
SELECT NULLIF(100, 100), NULLIF(100, 200) FROM DUAL; 
결과: NULL, 100
```

##### `3. COALESCE(expression1, expression2, ...)`
- NULL이 아닌 첫 번째 값 반환
- 여러 인자 중 NULL이 아닌 첫 번째 값을 반환합니다.
- NVL과 달리 여러 개의 인자를 받을 수 있어 더 유연합니다.
```
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
-- 앞쪽 제거
```
SELECT TRIM(LEADING '0' FROM '0001234') FROM DUAL;
결과: '1234'
```

##### 2. TRAILING
-- 뒤쪽 제거
```
SELECT TRIM(TRAILING '!' FROM 'Hello!!!') FROM DUAL;
결과: 'Hello'
```
##### 3. BOTH
-- 양쪽 제거
```
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






