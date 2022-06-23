r password: *******
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 5           
Server version: 10.6.7-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> CREATE TABLE student (  student_id INT PRIMARY KEY, name VARCHAR (20), major VARCHAR(20) );
ERROR 1046 (3D000): No database selected
MariaDB [(none)]> CREATE DATABASE student;
Query OK, 1 row affected (0.004 sec)

MariaDB [(none)]> use student;
Database changed
MariaDB [student]> CREATE TABLE CollegeStudent (  student_id INT PRIMARY KEY, name VARCHAR (20), major VARCHAR(20) );
Query OK, 0 rows affected (0.055 sec)

MariaDB [student]> show table;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '' at line 1
MariaDB [student]> show tables;
+-------------------+
| Tables_in_student |
+-------------------+
| collegestudent    |
+-------------------+
1 row in set (0.002 sec)

MariaDB [student]> describe student;
ERROR 1146 (42S02): Table 'student.student' doesn't exist
MariaDB [student]> describe collegestudent;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| student_id | int(11)     | NO   | PRI | NULL    |       |
| name       | varchar(20) | YES  |     | NULL    |       |
| major      | varchar(20) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
3 rows in set (0.014 sec)

MariaDB [student]> DROP TABLE student;
ERROR 1051 (42S02): Unknown table 'student.student'
MariaDB [student]>
MariaDB [student]> DROP TABLE Collegestudent;
Query OK, 0 rows affected (0.015 sec)

MariaDB [student]>
MariaDB [student]>
MariaDB [student]> describe collegestudent;
ERROR 1146 (42S02): Table 'student.collegestudent' doesn't exist
MariaDB [student]> CREATE TABLE CollegeStudent (  student_id INT PRIMARY KEY, name VARCHAR (20), major VARCHAR(20) );
Query OK, 0 rows affected (0.023 sec)

MariaDB [student]> describe student;
ERROR 1146 (42S02): Table 'student.student' doesn't exist
MariaDB [student]> describe cllegestudent;
ERROR 1146 (42S02): Table 'student.cllegestudent' doesn't exist
MariaDB [student]> describe collegestudent;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| student_id | int(11)     | NO   | PRI | NULL    |       |
| name       | varchar(20) | YES  |     | NULL    |       |
| major      | varchar(20) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
3 rows in set (0.014 sec)

MariaDB [student]> ALTER TABLE collegestudent ADD gpa decimal(3,2);
Query OK, 0 rows affected (0.023 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [student]> describe collegestudent table;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'table' at line 1
MariaDB [student]> describe collegestudent;
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| student_id | int(11)      | NO   | PRI | NULL    |       |
| name       | varchar(20)  | YES  |     | NULL    |       |
| major      | varchar(20)  | YES  |     | NULL    |       |
| gpa        | decimal(3,2) | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
4 rows in set (0.011 sec)

MariaDB [student]> ALTER TABLE collegestudent drop column gpa;
Query OK, 0 rows affected (0.023 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [student]> describe collegestudent;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| student_id | int(11)     | NO   | PRI | NULL    |       |
| name       | varchar(20) | YES  |     | NULL    |       |
| major      | varchar(20) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
3 rows in set (0.015 sec)

MariaDB [student]> INSERT INTO COLLEGESTUDENT VALUES ( 1, 'JACK','BIOLOGY' );
Query OK, 1 row affected (0.005 sec)

MariaDB [student]> SELECT * FROM COLLEGESTUDENT;
+------------+------+---------+
| student_id | name | major   |
+------------+------+---------+
|          1 | JACK | BIOLOGY |
+------------+------+---------+
1 row in set (0.000 sec)

MariaDB [student]> INSERT INTO COLLEGESTUDENT VALUES ( 2, 'KATE','SOCIALOGY' );
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> SELECT * FROM COLLEGESTUDENT;
+------------+------+-----------+
| student_id | name | major     |
+------------+------+-----------+
|          1 | JACK | BIOLOGY   |
|          2 | KATE | SOCIALOGY |
+------------+------+-----------+
2 rows in set (0.000 sec)

MariaDB [student]> INSERT INTO ( STUDENT_ID , NAME ) VALUES (2,'KATES');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '( STUDENT_ID , NAME ) VALUES (2,'KATES')' at line 1
MariaDB [student]> INSERT INTO COLLEGESTUDENT ( STUDENT_ID , NAME ) VALUES (2,'KATES');
ERROR 1062 (23000): Duplicate entry '2' for key 'PRIMARY'
MariaDB [student]> INSERT INTO COLLEGESTUDENT ( STUDENT_ID , NAME ) VALUES (3,'KATES');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> SELECT * FROM COLLEGESTUDENTS;
ERROR 1146 (42S02): Table 'student.collegestudents' doesn't exist
MariaDB [student]> SELECT * FROM COLLEGESTUDENT;
+------------+-------+-----------+
| student_id | name  | major     |
+------------+-------+-----------+
|          1 | JACK  | BIOLOGY   |
|          2 | KATE  | SOCIALOGY |
|          3 | KATES | NULL      |
+------------+-------+-----------+
3 rows in set (0.000 sec)

MariaDB [student]> DROP TABLE COLLEGESTUDENT;
Query OK, 0 rows affected (0.017 sec)

MariaDB [student]> CREATE TABLE STUDENTS ( STUDENT_ID INT, NAME VARCHAR (20) , MAJOR VARCHAR(20) DEFAULT 'UNDECIDED', PRIMARY KEY(STUDENT_ID));
Query OK, 0 rows affected (0.023 sec)

MariaDB [student]> SELECT * FROM STUDENTS;
Empty set (0.005 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(1, 'JACK', 'BIOLOGY');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(2, 'KATE', 'SOCIOLOGY');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(3, 'NULL', 'CHEMISTRY');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(4, 'JACK', 'BIOLOGY');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(5, 'JACLIN');
ERROR 1136 (21S01): Column count doesn't match value count at row 1
MariaDB [student]> INSERT INTO STUDENTS (STDENT_ID, NAME) VALUES (5, 'JACLIN');
ERROR 1054 (42S22): Unknown column 'STDENT_ID' in 'field list'
MariaDB [student]> INSERT INTO STUDENTS (STUDENT_ID, NAME) VALUES (5, 'JACLIN');
Query OK, 1 row affected (0.005 sec)

MariaDB [student]> SELECT * FROM STUDENTS;
+------------+--------+-----------+
| STUDENT_ID | NAME   | MAJOR     |
+------------+--------+-----------+
|          1 | JACK   | BIOLOGY   |
|          2 | KATE   | SOCIOLOGY |
|          3 | NULL   | CHEMISTRY |
|          4 | JACK   | BIOLOGY   |
|          5 | JACLIN | UNDECIDED |
+------------+--------+-----------+
5 rows in set (0.000 sec)

MariaDB [student]> DROP TABLE STUDENTS;
Query OK, 0 rows affected (0.025 sec)

MariaDB [student]> SELECT * FROM STUDENTS;
ERROR 1146 (42S02): Table 'student.students' doesn't exist
MariaDB [student]> CREATE TABLE STUDENTS ( STUDENT_ID INT, NAME VARCHAR (20) NOT NULL, MAJOR VARCHAR(20) DEFAULT 'UNDECIDED', PRIMARY KEY(STUDENT_ID));
Query OK, 0 rows affected (0.023 sec)

MariaDB [student]> DROP TABLE STUDENTS;
Query OK, 0 rows affected (0.173 sec)

MariaDB [student]> CREATE TABLE STUDENTS ( STUDENT_ID INT, NAME VARCHAR (20) NOT NULL, MAJOR VARCHAR(20) UNIQUE, PRIMARY KEY(STUDENT_ID));
Query OK, 0 rows affected (0.022 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(1, 'JACK', 'BIOLOGY');
Query OK, 1 row affected (0.008 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(2, 'KATE', 'SOCIOLOGY');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(3, 'NULL', 'CHEMISTRY');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(4, NULL, 'BIOLOGY');
ERROR 1048 (23000): Column 'NAME' cannot be null
MariaDB [student]> INSERT INTO STUDENTS VALUES(4, MARTIN, 'BIOLOGY');
ERROR 1054 (42S22): Unknown column 'MARTIN' in 'field list'
MariaDB [student]> INSERT INTO STUDENTS VALUES(4, 'MARTIN', 'BIOLOGY');
ERROR 1062 (23000): Duplicate entry 'BIOLOGY' for key 'MAJOR'
MariaDB [student]> DROP TABLE STUDENTS;
Query OK, 0 rows affected (0.016 sec)

MariaDB [student]> CREATE TABLE STUDENTS ( STUDENT_ID INT AUTO_INCREMENT, NAME VARCHAR (20) , MAJOR VARCHAR(20), PRIMARY KEY(STUDENT_ID));
Query OK, 0 rows affected (0.019 sec)

MariaDB [student]> SELECT * FROM STUDENTS;
Empty set (0.004 sec)

MariaDB [student]> INSERT INTO STUDENTS (NAME, MAJOR) VALUES ('JACLIN', 'BIOLOGY');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> INSERT INTO STUDENTS (NAME, MAJOR) VALUES ('JAK', 'SOCIOLGY');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> INSERT INTO STUDENTS (NAME, MAJOR) VALUES ('KATE', 'CSE');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> SELECT * FROM STUDENTS;
+------------+--------+----------+
| STUDENT_ID | NAME   | MAJOR    |
+------------+--------+----------+
|          1 | JACLIN | BIOLOGY  |
|          2 | JAK    | SOCIOLGY |
|          3 | KATE   | CSE      |
+------------+--------+----------+
3 rows in set (0.000 sec)

MariaDB [student]> UPDATE  STUDENTS  SET MAJOR='BIO' WHERE MAJOR='BIOLOGY';
Query OK, 1 row affected (0.005 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [student]> CREATE * FROM STUDENTS;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near '* FROM STUDENTS' at line 1
MariaDB [student]> SELECT * FROM STUDENTS;
+------------+--------+----------+
| STUDENT_ID | NAME   | MAJOR    |
+------------+--------+----------+
|          1 | JACLIN | BIO      |
|          2 | JAK    | SOCIOLGY |
|          3 | KATE   | CSE      |
+------------+--------+----------+
3 rows in set (0.000 sec)

MariaDB [student]> INSERT INTO STUDENTS (NAME, MAJOR) VALUES ('KATE', 'COMPUTER SCIENCE');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> UPDATE STUDENTS SET MAJOR = 'CSE' WHERE MAJOR= 'COMPUTER SCIENCE');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near ')' at line 1
MariaDB [student]> UPDATE STUDENTS SET MAJOR = 'CSE' WHERE MAJOR= 'COMPUTER SCIENCE';
Query OK, 1 row affected (0.003 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [student]> SELECT * FROM STUDENTS;
+------------+--------+----------+
| STUDENT_ID | NAME   | MAJOR    |
+------------+--------+----------+
|          1 | JACLIN | BIO      |
|          2 | JAK    | SOCIOLGY |
|          3 | KATE   | CSE      |
|          4 | KATE   | CSE      |
+------------+--------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> UPDATE STUDENTS SET MAJOR = 'MATHS' WHERE MAJOR= 'SOCIOLOGY';
Query OK, 0 rows affected (0.000 sec)
Rows matched: 0  Changed: 0  Warnings: 0

MariaDB [student]> SELECT * FROM STUDENTS;
+------------+--------+----------+
| STUDENT_ID | NAME   | MAJOR    |
+------------+--------+----------+
|          1 | JACLIN | BIO      |
|          2 | JAK    | SOCIOLGY |
|          3 | KATE   | CSE      |
|          4 | KATE   | CSE      |
+------------+--------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> UPDATE STUDENTS SET MAJOR = 'MATHS' WHERE MAJOR= 'SOCIOLGY';
Query OK, 1 row affected (0.003 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [student]> SELECT * FROM STUDENTS;
+------------+--------+-------+
| STUDENT_ID | NAME   | MAJOR |
+------------+--------+-------+
|          1 | JACLIN | BIO   |
|          2 | JAK    | MATHS |
|          3 | KATE   | CSE   |
|          4 | KATE   | CSE   |
+------------+--------+-------+
4 rows in set (0.000 sec)

MariaDB [student]> UPDATE STUDENTS SET MAJOR = 'MATHS' WHERE STUDENT_ID ='4';
Query OK, 1 row affected (0.007 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [student]> SELECT *FROM STUDENTS;
+------------+--------+-------+
| STUDENT_ID | NAME   | MAJOR |
+------------+--------+-------+
|          1 | JACLIN | BIO   |
|          2 | JAK    | MATHS |
|          3 | KATE   | CSE   |
|          4 | KATE   | MATHS |
+------------+--------+-------+
4 rows in set (0.000 sec)

MariaDB [student]> UPDATE STUDENT SET NAME ='TOM' , MAJOR= 'ACCOUNTS' WHERE STUDENT_ID=1;
ERROR 1146 (42S02): Table 'student.student' doesn't exist
MariaDB [student]> UPDATE STUDENTS SET NAME ='TOM' , MAJOR= 'ACCOUNTS' WHERE STUDENT_ID=1;
Query OK, 1 row affected (0.002 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [student]> SELECT * FROM STUDENTS;
+------------+------+----------+
| STUDENT_ID | NAME | MAJOR    |
+------------+------+----------+
|          1 | TOM  | ACCOUNTS |
|          2 | JAK  | MATHS    |
|          3 | KATE | CSE      |
|          4 | KATE | MATHS    |
+------------+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> INSERT INTO STUDENTS VALUES(97, 'E97', 'ACCOUNTS');
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> SELECT * FROM STUDENTS;
+------------+------+----------+
| STUDENT_ID | NAME | MAJOR    |
+------------+------+----------+
|          1 | TOM  | ACCOUNTS |
|          2 | JAK  | MATHS    |
|          3 | KATE | CSE      |
|          4 | KATE | MATHS    |
|         97 | E97  | ACCOUNTS |
+------------+------+----------+
5 rows in set (0.000 sec)

MariaDB [student]> DELETE FROM STUDENT WHERE STUDENT_ID='97';
ERROR 1146 (42S02): Table 'student.student' doesn't exist
MariaDB [student]> DELETE FROM STUDENTS WHERE STUDENT_ID='97';
Query OK, 1 row affected (0.003 sec)

MariaDB [student]> SELECT * FROM STUDENTS;
+------------+------+----------+
| STUDENT_ID | NAME | MAJOR    |
+------------+------+----------+
|          1 | TOM  | ACCOUNTS |
|          2 | JAK  | MATHS    |
|          3 | KATE | CSE      |
|          4 | KATE | MATHS    |
+------------+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]>
MariaDB [student]> SELECT NAME FROM STUDENTS;
+------+
| NAME |
+------+
| TOM  |
| JAK  |
| KATE |
| KATE |
+------+
4 rows in set (0.001 sec)

MariaDB [student]> SELECT MAJOR FROM STUDENTS;
+----------+
| MAJOR    |
+----------+
| ACCOUNTS |
| MATHS    |
| CSE      |
| MATHS    |
+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT STUDENT_ID FROM STUDENTS;
+------------+
| STUDENT_ID |
+------------+
|          1 |
|          2 |
|          3 |
|          4 |
+------------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT STUDENTS.NAME , STUDENTS.MAJOR FROM STUDENTS;
+------+----------+
| NAME | MAJOR    |
+------+----------+
| TOM  | ACCOUNTS |
| JAK  | MATHS    |
| KATE | CSE      |
| KATE | MATHS    |
+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT STUDENTS.STUDENT_ID, STUDENTS.NAME, STUDENTS.MAJOR FROM STUDENTS;
+------------+------+----------+
| STUDENT_ID | NAME | MAJOR    |
+------------+------+----------+
|          1 | TOM  | ACCOUNTS |
|          2 | JAK  | MATHS    |
|          3 | KATE | CSE      |
|          4 | KATE | MATHS    |
+------------+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT STUDENTS.NAME, STUDENTS.MAJOR FROM STUDENTS ORDER BY NAME;
+------+----------+
| NAME | MAJOR    |
+------+----------+
| JAK  | MATHS    |
| KATE | CSE      |
| KATE | MATHS    |
| TOM  | ACCOUNTS |
+------+----------+
4 rows in set (0.002 sec)

MariaDB [student]> SELECT STUDENTS.NAME, STUDENTS.MAJOR FROM STUDENTS ORDER BY NAME DESC;
+------+----------+
| NAME | MAJOR    |
+------+----------+
| TOM  | ACCOUNTS |
| KATE | CSE      |
| KATE | MATHS    |
| JAK  | MATHS    |
+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT STUDENTS.NAME, STUDENTS.MAJOR FROM STUDENTS ORDER BY MAJOR;
+------+----------+
| NAME | MAJOR    |
+------+----------+
| TOM  | ACCOUNTS |
| KATE | CSE      |
| JAK  | MATHS    |
| KATE | MATHS    |
+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT STUDENTS.NAME, STUDENTS.MAJOR FROM STUDENTS ORDER BY MAJOR DESC;
+------+----------+
| NAME | MAJOR    |
+------+----------+
| JAK  | MATHS    |
| KATE | MATHS    |
| KATE | CSE      |
| TOM  | ACCOUNTS |
+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT * FROM STUDENTS ORDER BY MAJOR, STUDENT_ID;
+------------+------+----------+
| STUDENT_ID | NAME | MAJOR    |
+------------+------+----------+
|          1 | TOM  | ACCOUNTS |
|          3 | KATE | CSE      |
|          2 | JAK  | MATHS    |
|          4 | KATE | MATHS    |
+------------+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT * FROM STUDENTS ORDER BY MAJOR, STUDENT_ID DESC;
+------------+------+----------+
| STUDENT_ID | NAME | MAJOR    |
+------------+------+----------+
|          1 | TOM  | ACCOUNTS |
|          3 | KATE | CSE      |
|          4 | KATE | MATHS    |
|          2 | JAK  | MATHS    |
+------------+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT * FROM STUDENT ORDER BY STUDENT_ID DESC LIMIT 2;
ERROR 1146 (42S02): Table 'student.student' doesn't exist
MariaDB [student]> SELECT * FROM STUDENTS ORDER BY STUDENT_ID DESC LIMIT 2;
+------------+------+-------+
| STUDENT_ID | NAME | MAJOR |
+------------+------+-------+
|          4 | KATE | MATHS |
|          3 | KATE | CSE   |
+------------+------+-------+
2 rows in set (0.000 sec)

MariaDB [student]> SELECT * FROM STUDENTS WHERE MAJOR='BIOLOGY';
Empty set (0.002 sec)

MariaDB [student]> SELECT * FROM STUDENTS WHERE MAJOR = 'MATHS';
+------------+------+-------+
| STUDENT_ID | NAME | MAJOR |
+------------+------+-------+
|          2 | JAK  | MATHS |
|          4 | KATE | MATHS |
+------------+------+-------+
2 rows in set (0.000 sec)

MariaDB [student]> SELECT NAME , MAJOR FROM STUDENT WHERE MAJOR = 'CHEMISTRY' OR NAME= 'JAK';
ERROR 1146 (42S02): Table 'student.student' doesn't exist
MariaDB [student]> SELECT NAME , MAJOR FROM STUDENTS WHERE MAJOR = 'CHEMISTRY' OR NAME= 'JAK';
+------+-------+
| NAME | MAJOR |
+------+-------+
| JAK  | MATHS |
+------+-------+
1 row in set (0.000 sec)

MariaDB [student]> SELECT NAME , MAJOR FROM STUDENTS WHERE MAJOR <> 'JAK';
+------+----------+
| NAME | MAJOR    |
+------+----------+
| TOM  | ACCOUNTS |
| JAK  | MATHS    |
| KATE | CSE      |
| KATE | MATHS    |
+------+----------+
4 rows in set (0.002 sec)

MariaDB [student]> SELECT NAME , MAJOR FROM STUDENTS WHERE NAME <> 'JAK';
+------+----------+
| NAME | MAJOR    |
+------+----------+
| TOM  | ACCOUNTS |
| KATE | CSE      |
| KATE | MATHS    |
+------+----------+
3 rows in set (0.000 sec)

MariaDB [student]> SELECT * FROM STUDENTS WHERE STUDENT_ID >= 2;
+------------+------+-------+
| STUDENT_ID | NAME | MAJOR |
+------------+------+-------+
|          2 | JAK  | MATHS |
|          3 | KATE | CSE   |
|          4 | KATE | MATHS |
+------------+------+-------+
3 rows in set (0.002 sec)

MariaDB [student]> SELECT * FROM STUDENTS WHERE STUDENT_ID <= 5;
+------------+------+----------+
| STUDENT_ID | NAME | MAJOR    |
+------------+------+----------+
|          1 | TOM  | ACCOUNTS |
|          2 | JAK  | MATHS    |
|          3 | KATE | CSE      |
|          4 | KATE | MATHS    |
+------------+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT * FROM STUDENTS WHERE MAJOR IN ('ACCOUNTS' , 'MATHS', 'CSE',);
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near ')' at line 1
MariaDB [student]> SELECT * FROM STUDENTS WHERE MAJOR IN ('ACCOUNTS' , 'MATHS', 'CSE');
+------------+------+----------+
| STUDENT_ID | NAME | MAJOR    |
+------------+------+----------+
|          1 | TOM  | ACCOUNTS |
|          2 | JAK  | MATHS    |
|          3 | KATE | CSE      |
|          4 | KATE | MATHS    |
+------------+------+----------+
4 rows in set (0.000 sec)

MariaDB [student]> SELECT * FROM STUDENTS WHERE MAJOR IN ('ACCOUNTS' , 'MATHS', 'CSE') AND STUDENT_ID >=3;
+------------+------+-------+
| STUDENT_ID | NAME | MAJOR |
+------------+------+-------+
|          3 | KATE | CSE   |
|          4 | KATE | MATHS |
+------------+------+-------+
2 rows in set (0.000 sec)

MariaDB [student]> CREATE DATABASE COMPANY;
Query OK, 1 row affected (0.001 sec)
