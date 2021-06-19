# Quarkus & Kubernetes


# DB
## 1. DB의 종류
### SQL Base
  - MySQL, MariaDB, (Oracle, MSSQL)
  - 장점: 데이터간의 연동 쉬움
  - 단점: 개발 어려움

### Document Base (NoSQL)
  - AWS DynamoDB, **MongoDB**
  - 장점: 개발 쉬움, 중간에 구조 변경 쉬움
  - 단점: 최적화 & 데이터간 연동 어려움

## 2. DB 선택
- DB 사용 목적: User, Device list, Reservation status 등의 정보 관리
- MongoDB - 현재 회사에서 사용중, 회사에서 활용될 서비스이기에 추후에 공유 쉬움 & 빠른 개발 가능


# REST API
## 1. REST (Representational State Transfer) 란?
- Backend에서 서버에서 클라이언트로 데이터를 전달하는 방식
## 2. REST API Method List
- HTTP POST: 등록(create)
- HTTP GET: 데이터 불러오기
- HTTP PUT: 생성 & 수정
- HTTP DELETE: 삭제
- HTTP PATCH: 일부만 수정
- OPTIONS: 자원 상태 확인

# Flutter & Dart
