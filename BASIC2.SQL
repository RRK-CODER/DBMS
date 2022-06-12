Enter password: *******
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 15
Server version: 10.6.7-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> use company;
Database changed
MariaDB [company]> create table employee ( emp_id PRIMARY KEY, first_name VARCHAR(40) , last_name VARCHAR(40) , birth_day DATE, sex VARCHAR(1), salary INT, super_id INT , branch_id INT );
ERROR 4161 (HY000): Unknown data type: 'PRIMARY'
MariaDB [company]> create table employee ( emp_id INT PRIMARY KEY, first_name VARCHAR(40) , last_name VARCHAR(40) , birth_day DATE, sex VARCHAR(1), salary INT, super_id INT , branch_id INT );
Query OK, 0 rows affected (0.048 sec)

MariaDB [company]> create table branch ( branch_id INT PRIMARY KEY, branch_name VARCHAR(40), mgr_id INT, mgr_start_date DATE, FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL);
Query OK, 0 rows affected (0.023 sec)

MariaDB [company]> ALTER TABLE EMPLOYEE ADD FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;
Query OK, 0 rows affected (0.066 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [company]> alter table employee add foreign key (super_id) references employee(emp_id) on delete set null;
Query OK, 0 rows affected (0.066 sec)
Records: 0  Duplicates: 0  Warnings: 0

MariaDB [company]> create table client (client_id INT PRIMARY KEY, client_name VARCHAR (40), branch_id INT, FOREIGN KEY(branch_id) references branch(branch_id) on delete set null);
Query OK, 0 rows affected (0.020 sec)

MariaDB [company]> create table works_with ( emp_id INT, client_id INT, total_sales INT, PRIMARY KEY(emp_id, client_id), foreign key(emp_id) references employee(emp_id) on delete cascade, foreign key(client_id) references client(client_id) on delete cascade);
Query OK, 0 rows affected (0.025 sec)

MariaDB [company]> create table branch_supplier ( branch_id INT, supllier_name VARCHAR(40), supply_type VARCHAR(40), PRIMARY KEY( branch_id,supplier_name), FOREIGN KEY(branch_id) references branch(branch_id) on delete set null);
ERROR 1072 (42000): Key column 'supplier_name' doesn't exist in table
MariaDB [company]> create table branch_supplier ( branch_id INT, supplier_name VARCHAR(40), supply_type VARCHAR(40), PRIMARY KEY( branch_id,supplier_name), FOREIGN KEY(branch_id) references branch(branch_id) on delete set null);
ERROR 1005 (HY000): Can't create table `company`.`branch_supplier` (errno: 150 "Foreign key constraint is incorrectly formed")
MariaDB [company]> create table branch_supplier ( branch_id INT, supplier_name VARCHAR(40), supply_type VARCHAR(40), PRIMARY KEY( branch_id,supplier_name), FOREIGN KEY(branch_id) references branch(branch_id) on delete cascade);
Query OK, 0 rows affected (0.020 sec)

MariaDB [company]> insert into employee values(100, 'David', 'Wallace', '1967-11-17', 'm' , 250000, null,null);
Query OK, 1 row affected (0.015 sec)

MariaDB [company]> insert into employee values(101, 'Jan', 'Levinson', '1961-05-11', 'f' , 110000, 100, 1);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`company`.`employee`, CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL)
MariaDB [company]> insert into branch values(1,'Corporate', 100 , '2006-02-09');
Query OK, 1 row affected (0.010 sec)

MariaDB [company]> update employee set branch_id =1 where emp_id = 100;
Query OK, 1 row affected (0.003 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [company]> insert into employee values(101, 'Jan', 'Levinson', '1961-05-11', 'f' , 110000, 100, 1);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> insert into employee values(102, 'Michael','Scott', '1964-03-15', 'm' , 75000, 100, 2);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`company`.`employee`, CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL)
MariaDB [company]> insert into employee values(102, 'Michael','Scott', '1964-03-15', 'm' , 75000, 100, null);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> UPDATE employee
    -> SET branch_id = 2
    -> WHERE emp_id = 102;
Query OK, 1 row affected (0.003 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [company]> INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
Query OK, 1 row affected (0.002 sec)

MariaDB [company]> INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);
Query OK, 1 row affected (0.004 sec)

MariaDB [company]> INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> UPDATE employee
    -> SET branch_id = 3
    -> WHERE emp_id = 106;
Query OK, 1 row affected (0.003 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [company]> INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');Bye

MariaDB [company]> INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
Query OK, 1 row affected (0.009 sec)

MariaDB [company]> INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
Query OK, 1 row affected (0.004 sec)

MariaDB [company]> INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
Query OK, 1 row affected (0.002 sec)

MariaDB [company]> INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
Query OK, 1 row affected (0.002 sec)

MariaDB [company]> INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
Query OK, 1 row affected (0.002 sec)

MariaDB [company]> INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');
Query OK, 1 row affected (0.001 sec)

MariaDB [company]> INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
Query OK, 1 row affected (0.007 sec)

MariaDB [company]> INSERT INTO client VALUES(401, 'Lackawana Country', 2);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO client VALUES(402, 'FedEx', 3);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO client VALUES(405, 'Times Newspaper', 3);
Query OK, 1 row affected (0.005 sec)

MariaDB [company]> INSERT INTO client VALUES(406, 'FedEx', 2);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO works_with VALUES(105, 400, 55000);
Query OK, 1 row affected (0.009 sec)

MariaDB [company]> INSERT INTO works_with VALUES(102, 401, 267000);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO works_with VALUES(108, 402, 22500);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO works_with VALUES(107, 403, 5000);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO works_with VALUES(108, 403, 12000);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO works_with VALUES(105, 404, 33000);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO works_with VALUES(107, 405, 26000);
Query OK, 1 row affected (0.004 sec)

MariaDB [company]> INSERT INTO works_with VALUES(102, 406, 15000);
Query OK, 1 row affected (0.003 sec)

MariaDB [company]> INSERT INTO works_with VALUES(105, 406, 130000);
Query OK, 1 row affected (0.022 sec)

MariaDB [company]> select * from employee;
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    100 | David      | Wallace   | 1967-11-17 | m    | 250000 |     NULL |         1 |
|    101 | Jan        | Levinson  | 1961-05-11 | f    | 110000 |      100 |         1 |
|    102 | Michael    | Scott     | 1964-03-15 | m    |  75000 |      100 |         2 |
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |      102 |         2 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
9 rows in set (0.000 sec)

MariaDB [company]> select * from branch;
+-----------+-------------+--------+----------------+
| branch_id | branch_name | mgr_id | mgr_start_date |
+-----------+-------------+--------+----------------+
|         1 | Corporate   |    100 | 2006-02-09     |
|         2 | Scranton    |    102 | 1992-04-06     |
|         3 | Stamford    |    106 | 1998-02-13     |
+-----------+-------------+--------+----------------+
3 rows in set (0.000 sec)

MariaDB [company]> select * from client;
+-----------+---------------------+-----------+
| client_id | client_name         | branch_id |
+-----------+---------------------+-----------+
|       400 | Dunmore Highschool  |         2 |
|       401 | Lackawana Country   |         2 |
|       402 | FedEx               |         3 |
|       403 | John Daly Law, LLC  |         3 |
|       404 | Scranton Whitepages |         2 |
|       405 | Times Newspaper     |         3 |
|       406 | FedEx               |         2 |
+-----------+---------------------+-----------+
7 rows in set (0.000 sec)

MariaDB [company]> select * from works_with ;
+--------+-----------+-------------+
| emp_id | client_id | total_sales |
+--------+-----------+-------------+
|    102 |       401 |      267000 |
|    102 |       406 |       15000 |
|    105 |       400 |       55000 |
|    105 |       404 |       33000 |
|    105 |       406 |      130000 |
|    107 |       403 |        5000 |
|    107 |       405 |       26000 |
|    108 |       402 |       22500 |
|    108 |       403 |       12000 |
+--------+-----------+-------------+
9 rows in set (0.000 sec)

MariaDB [company]> select * from branch supplier;
+-----------+-------------+--------+----------------+
| branch_id | branch_name | mgr_id | mgr_start_date |
+-----------+-------------+--------+----------------+
|         1 | Corporate   |    100 | 2006-02-09     |
|         2 | Scranton    |    102 | 1992-04-06     |
|         3 | Stamford    |    106 | 1998-02-13     |
+-----------+-------------+--------+----------------+
3 rows in set (0.002 sec)

MariaDB [company]> select * from employee ordered by salary;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'by salary' at line 1
MariaDB [company]> select * from employee order by salary;
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |      102 |         2 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
|    102 | Michael    | Scott     | 1964-03-15 | m    |  75000 |      100 |         2 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    101 | Jan        | Levinson  | 1961-05-11 | f    | 110000 |      100 |         1 |
|    100 | David      | Wallace   | 1967-11-17 | m    | 250000 |     NULL |         1 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
9 rows in set (0.003 sec)

MariaDB [company]> select * from employee order by salary desc;
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    100 | David      | Wallace   | 1967-11-17 | m    | 250000 |     NULL |         1 |
|    101 | Jan        | Levinson  | 1961-05-11 | f    | 110000 |      100 |         1 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    102 | Michael    | Scott     | 1964-03-15 | m    |  75000 |      100 |         2 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |      102 |         2 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
9 rows in set (0.001 sec)

MariaDB [company]> select * from employee order by sex, first_name, last_name;
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
|    101 | Jan        | Levinson  | 1961-05-11 | f    | 110000 |      100 |         1 |
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    100 | David      | Wallace   | 1967-11-17 | m    | 250000 |     NULL |         1 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    102 | Michael    | Scott     | 1964-03-15 | m    |  75000 |      100 |         2 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |      102 |         2 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
9 rows in set (0.002 sec)

MariaDB [company]> select first_name as forename , last_name as surname from employee;
+----------+----------+
| forename | surname  |
+----------+----------+
| David    | Wallace  |
| Jan      | Levinson |
| Michael  | Scott    |
| Angela   | Martin   |
| Kelly    | Kapoor   |
| Stanley  | Hudson   |
| Josh     | Porter   |
| Andy     | Bernard  |
| Jim      | Halpert  |
+----------+----------+
9 rows in set (0.002 sec)

MariaDB [company]> select distinct sex from employee;
+------+
| sex  |
+------+
| m    |
| f    |
+------+
2 rows in set (0.004 sec)

MariaDB [company]> select distinct branch_id from employee;
+-----------+
| branch_id |
+-----------+
|         1 |
|         2 |
|         3 |
+-----------+
3 rows in set (0.002 sec)

MariaDB [company]> select count (emp_id) from employee;
ERROR 1630 (42000): FUNCTION company.count does not exist. Check the 'Function Name Parsing and Resolution' section in the Reference Manual
MariaDB [company]> select count(emp_id) from employee;
+---------------+
| count(emp_id) |
+---------------+
|             9 |
+---------------+
1 row in set (0.003 sec)

MariaDB [company]> select count(super_id) from employee;
+-----------------+
| count(super_id) |
+-----------------+
|               8 |
+-----------------+
1 row in set (0.000 sec)

MariaDB [company]> select count(super_id) from employee where sex='f' and birth_date > '1970-01-01';
ERROR 1054 (42S22): Unknown column 'birth_date' in 'where clause'
MariaDB [company]> select count(super_id) from employee where sex='f' and birth date > '1970-01-01';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'date > '1970-01-01'' at line 1
MariaDB [company]> select count(super_id) from employee where sex='f' and birth day > '1970-01-01';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'day > '1970-01-01'' at line 1
MariaDB [company]> select count(super_id) from employee where sex='f' and birth_day > '1970-01-01';
+-----------------+
| count(super_id) |
+-----------------+
|               2 |
+-----------------+
1 row in set (0.004 sec)

MariaDB [company]> select avg(salary) from employee;
+-------------+
| avg(salary) |
+-------------+
|  92888.8889 |
+-------------+
1 row in set (0.002 sec)

MariaDB [company]> select avg(salary) from employee where sex='m';
+-------------+
| avg(salary) |
+-------------+
| 101333.3333 |
+-------------+
1 row in set (0.000 sec)

MariaDB [company]> select sum(salary) from employee;
+-------------+
| sum(salary) |
+-------------+
|      836000 |
+-------------+
1 row in set (0.000 sec)

MariaDB [company]> select sum(salary) from employee where sex='m';
+-------------+
| sum(salary) |
+-------------+
|      608000 |
+-------------+
1 row in set (0.000 sec)

MariaDB [company]> select count (sex) from employee;
ERROR 1630 (42000): FUNCTION company.count does not exist. Check the 'Function Name Parsing and Resolution' section in the Reference Manual
MariaDB [company]> select count(sex) from employee;
+------------+
| count(sex) |
+------------+
|          9 |
+------------+
1 row in set (0.000 sec)

MariaDB [company]> select count(sex), sex from employee;
+------------+------+
| count(sex) | sex  |
+------------+------+
|          9 | m    |
+------------+------+
1 row in set (0.000 sec)

MariaDB [company]> select count(sex), sex from employee where group by sex;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'group by sex' at line 1
MariaDB [company]> select count(sex), sex from employee group by sex;
+------------+------+
| count(sex) | sex  |
+------------+------+
|          3 | f    |
|          6 | m    |
+------------+------+
2 rows in set (0.002 sec)

MariaDB [company]> select sum (total_sales) , emp_id from works_with group by emp_id;
ERROR 1630 (42000): FUNCTION company.sum does not exist. Check the 'Function Name Parsing and Resolution' section in the Reference Manual
MariaDB [company]> select sum(total_sales) , emp_id from works_with group by emp_id;
+------------------+--------+
| sum(total_sales) | emp_id |
+------------------+--------+
|           282000 |    102 |
|           218000 |    105 |
|            31000 |    107 |
|            34500 |    108 |
+------------------+--------+
4 rows in set (0.000 sec)

MariaDB [company]> select sum(total_sales) , client_id from works_with group by client_id;
+------------------+-----------+
| sum(total_sales) | client_id |
+------------------+-----------+
|            55000 |       400 |
|           267000 |       401 |
|            22500 |       402 |
|            17000 |       403 |
|            33000 |       404 |
|            26000 |       405 |
|           145000 |       406 |
+------------------+-----------+
7 rows in set (0.001 sec)

MariaDB [company]> select * from client where client_name like '%LLC';
+-----------+--------------------+-----------+
| client_id | client_name        | branch_id |
+-----------+--------------------+-----------+
|       403 | John Daly Law, LLC |         3 |
+-----------+--------------------+-----------+
1 row in set (0.002 sec)

MariaDB [company]> select * from branch_supplier where supplier_name like '%label';
Empty set (0.001 sec)

MariaDB [company]> select * from branch_supplier where supplier_name like '%labels';
+-----------+---------------------+--------------+
| branch_id | supplier_name       | supply_type  |
+-----------+---------------------+--------------+
|         2 | J.T. Forms & Labels | Custom Forms |
+-----------+---------------------+--------------+
1 row in set (0.000 sec)

MariaDB [company]> select * from branch_supplier where supplier_name like '%lables';
+-----------+-----------------+--------------+
| branch_id | supplier_name   | supply_type  |
+-----------+-----------------+--------------+
|         3 | Stamford Lables | Custom Forms |
+-----------+-----------------+--------------+
1 row in set (0.000 sec)

MariaDB [company]> select * from branch_supplier where supplier_name like '% lable %';
Empty set (0.000 sec)

MariaDB [company]> select * from branch_supplier where supplier_name like '% label %';
Empty set (0.000 sec)

MariaDB [company]> select * from employee where birth_date LIKE '____-10%';
ERROR 1054 (42S22): Unknown column 'birth_date' in 'where clause'
MariaDB [company]> select * from employee where birth_day LIKE '____-10%';
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
1 row in set (0.002 sec)

MariaDB [company]> select * from employee where birth_day LIKE '____-02%';
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |      102 |         2 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |      102 |         2 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
2 rows in set (0.001 sec)

MariaDB [company]> select * from employee where birth_day LIKE '____-06%';
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |      102 |         2 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
1 row in set (0.000 sec)

MariaDB [company]> select * from client where client_name like
    -> select * from client where client_name like '%school%';
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'select * from client where client_name like '%school%'' at line 2
MariaDB [company]> select * from client where client_name like '%school%';
+-----------+--------------------+-----------+
| client_id | client_name        | branch_id |
+-----------+--------------------+-----------+
|       400 | Dunmore Highschool |         2 |
+-----------+--------------------+-----------+
1 row in set (0.001 sec)

MariaDB [company]> select first_name from employee UNION  select branch_name from branch;
+------------+
| first_name |
+------------+
| David      |
| Jan        |
| Michael    |
| Angela     |
| Kelly      |
| Stanley    |
| Josh       |
| Andy       |
| Jim        |
| Corporate  |
| Scranton   |
| Stamford   |
+------------+                                                         ┌───────────────────────────┐
12 rows in set (0.004 sec)                                             │Enter command number:      │
                                                                       └───────────────────────────┘
MariaDB [company]> select first_name,last_name from employee UNION  select branch_name, branch_id from branch;
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| David      | Wallace   |
| Jan        | Levinson  |
| Michael    | Scott     |
| Angela     | Martin    |
| Kelly      | Kapoor    |
| Stanley    | Hudson    |
| Josh       | Porter    |
| Andy       | Bernard   |
| Jim        | Halpert   |
| Corporate  | 1         |
| Scranton   | 2         |
| Stamford   | 3         |
+------------+-----------+
12 rows in set (0.002 sec)

MariaDB [company]> select first_name from employee UNION  select branch_name from branch UNION select client_name from client;
+---------------------+
| first_name          |
+---------------------+
| David               |
| Jan                 |
| Michael             |
| Angela              |
| Kelly               |
| Stanley             |
| Josh                |
| Andy                |
| Jim                 |
| Corporate           |
| Scranton            |
| Stamford            |
| Dunmore Highschool  |
| Lackawana Country   |
| FedEx               |
| John Daly Law, LLC  |
| Scranton Whitepages |
| Times Newspaper     |
+---------------------+
18 rows in set (0.003 sec)

MariaDB [company]> select first_name as Company_Names from employee UNION  select branch_name from branch UNION select client_name from client;
+---------------------+
| Company_Names       |
+---------------------+
| David               |
| Jan                 |
| Michael             |
| Angela              |
| Kelly               |
| Stanley             |
| Josh                |
| Andy                |
| Jim                 |
| Corporate           |
| Scranton            |
| Stamford            |
| Dunmore Highschool  |
| Lackawana Country   |
| FedEx               |
| John Daly Law, LLC  |
| Scranton Whitepages |
| Times Newspaper     |
+---------------------+
18 rows in set (0.001 sec)

MariaDB [company]> select client_name from client union select supplier_name from branch_supplier;
+---------------------+
| client_name         |
+---------------------+
| Dunmore Highschool  |
| Lackawana Country   |
| FedEx               |
| John Daly Law, LLC  |
| Scranton Whitepages |
| Times Newspaper     |
| Hammer Mill         |
| J.T. Forms & Labels |
| Uni-ball            |
| Patriot Paper       |
| Stamford Lables     |
+---------------------+
11 rows in set (0.000 sec)

MariaDB [company]> select client_name,branch_id from client union select supplier_name, branch_id from branch_supplier;
+---------------------+-----------+
| client_name         | branch_id |
+---------------------+-----------+
| Dunmore Highschool  |         2 |
| Lackawana Country   |         2 |
| FedEx               |         3 |
| John Daly Law, LLC  |         3 |
| Scranton Whitepages |         2 |
| Times Newspaper     |         3 |
| FedEx               |         2 |
| Hammer Mill         |         2 |
| J.T. Forms & Labels |         2 |
| Uni-ball            |         2 |
| Hammer Mill         |         3 |
| Patriot Paper       |         3 |
| Stamford Lables     |         3 |
| Uni-ball            |         3 |
+---------------------+-----------+
14 rows in set (0.000 sec)

MariaDB [company]> select client_name,client.branch_id from client union select supplier_name, branch_supplier.branch_id from branch_supplier;
+---------------------+-----------+
| client_name         | branch_id |
+---------------------+-----------+
| Dunmore Highschool  |         2 |
| Lackawana Country   |         2 |
| FedEx               |         3 |
| John Daly Law, LLC  |         3 |
| Scranton Whitepages |         2 |
| Times Newspaper     |         3 |
| FedEx               |         2 |
| Hammer Mill         |         2 |
| J.T. Forms & Labels |         2 |
| Uni-ball            |         2 |
| Hammer Mill         |         3 |
| Patriot Paper       |         3 |
| Stamford Lables     |         3 |
| Uni-ball            |         3 |
+---------------------+-----------+
14 rows in set (0.002 sec)

MariaDB [company]> select salary from employee union select total_sales from works_with;
+--------+
| salary |
+--------+
| 250000 |
| 110000 |
|  75000 |
|  63000 |
|  55000 |
|  69000 |
|  78000 |
|  65000 |
|  71000 |
| 267000 |
|  15000 |
|  33000 |
| 130000 |
|   5000 |
|  26000 |
|  22500 |
|  12000 |
+--------+
17 rows in set (0.003 sec)

MariaDB [company]> insert into branch values ( 4, 'buffalo' , NULL ,NULL);
Query OK, 1 row affected (0.004 sec)

MariaDB [company]> select * from branch;
+-----------+-------------+--------+----------------+
| branch_id | branch_name | mgr_id | mgr_start_date |
+-----------+-------------+--------+----------------+
|         1 | Corporate   |    100 | 2006-02-09     |
|         2 | Scranton    |    102 | 1992-04-06     |
|         3 | Stamford    |    106 | 1998-02-13     |
|         4 | buffalo     |   NULL | NULL           |
+-----------+-------------+--------+----------------+
4 rows in set (0.000 sec)

MariaDB [company]> select employee.emp_id, employee.first_name, branch.branch_name  from employee join branch on employee.emp_id = branch.mgr_id;
+--------+------------+-------------+
| emp_id | first_name | branch_name |
+--------+------------+-------------+
|    100 | David      | Corporate   |
|    102 | Michael    | Scranton    |
|    106 | Josh       | Stamford    |
+--------+------------+-------------+
3 rows in set (0.002 sec)

MariaDB [company]> select employee.emp_id, employee.first_name, branch.branch_name  from employee left join branch on employee.emp_id = branch.mgr_id;
+--------+------------+-------------+
| emp_id | first_name | branch_name |
+--------+------------+-------------+
|    100 | David      | Corporate   |
|    102 | Michael    | Scranton    |
|    106 | Josh       | Stamford    |
|    101 | Jan        | NULL        |
|    103 | Angela     | NULL        |
|    104 | Kelly      | NULL        |
|    105 | Stanley    | NULL        |
|    107 | Andy       | NULL        |
|    108 | Jim        | NULL        |
+--------+------------+-------------+
9 rows in set (0.003 sec)

MariaDB [company]> select employee.emp_id, employee.first_name, branch.branch_name  from employee right join branch on employee.emp_id = branch.mgr_id;
+--------+------------+-------------+
| emp_id | first_name | branch_name |
+--------+------------+-------------+
|    100 | David      | Corporate   |
|    102 | Michael    | Scranton    |
|    106 | Josh       | Stamford    |
|   NULL | NULL       | buffalo     |
+--------+------------+-------------+
4 rows in set (0.001 sec)

MariaDB [company]> select works_with.emp_id from works_with where works_with.total_sales>30000;
+--------+
| emp_id |
+--------+
|    102 |
|    105 |
|    105 |
|    105 |
+--------+
4 rows in set (0.001 sec)

MariaDB [company]> select employee.first_name , employee.last_name from employee where emp_id IN (select works_with.emp_id from works_with where works_with.total_sales>30000);
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Michael    | Scott     |
| Stanley    | Hudson    |
+------------+-----------+
2 rows in set (0.004 sec)

MariaDB [company]> select branch.branch_id from branch where branch.mgr_id=102;
+-----------+
| branch_id |
+-----------+
|         2 |
+-----------+
1 row in set (0.003 sec)

MariaDB [company]> select client.client_name from client where client.brach_id=( select branch.branch_id from branch where branch.mgr_id=102);
ERROR 1054 (42S22): Unknown column 'client.brach_id' in 'where clause'
MariaDB [company]> select client.client_name from client where client.branch_id=( select branch.branch_id from branch where branch.mgr_id=102);
+---------------------+
| client_name         |
+---------------------+
| Dunmore Highschool  |
| Lackawana Country   |
| Scranton Whitepages |
| FedEx               |
+---------------------+
4 rows in set (0.003 sec)

MariaDB [company]> select client.client_name from client where client.branch_id=( select branch.branch_id from branch where branch.mgr_id=102 limit 1);
+---------------------+
| client_name         |
+---------------------+
| Dunmore Highschool  |
| Lackawana Country   |
| Scranton Whitepages |
| FedEx               |
+---------------------+
4 rows in set (0.002 sec)

MariaDB [company]>  delete from employee where emp_id =102;
Query OK, 1 row affected (0.007 sec)

MariaDB [company]> select * from employee;
+--------+------------+-----------+------------+------+--------+----------+-----------+
| emp_id | first_name | last_name | birth_day  | sex  | salary | super_id | branch_id |
+--------+------------+-----------+------------+------+--------+----------+-----------+
|    100 | David      | Wallace   | 1967-11-17 | m    | 250000 |     NULL |         1 |
|    101 | Jan        | Levinson  | 1961-05-11 | f    | 110000 |      100 |         1 |
|    103 | Angela     | Martin    | 1971-06-25 | F    |  63000 |     NULL |         2 |
|    104 | Kelly      | Kapoor    | 1980-02-05 | F    |  55000 |     NULL |         2 |
|    105 | Stanley    | Hudson    | 1958-02-19 | M    |  69000 |     NULL |         2 |
|    106 | Josh       | Porter    | 1969-09-05 | M    |  78000 |      100 |         3 |
|    107 | Andy       | Bernard   | 1973-07-22 | M    |  65000 |      106 |         3 |
|    108 | Jim        | Halpert   | 1978-10-01 | M    |  71000 |      106 |         3 |
+--------+------------+-----------+------------+------+--------+----------+-----------+
8 rows in set (0.000 sec)

MariaDB [company]> select * from branch;
+-----------+-------------+--------+----------------+
| branch_id | branch_name | mgr_id | mgr_start_date |
+-----------+-------------+--------+----------------+
|         1 | Corporate   |    100 | 2006-02-09     |
|         2 | Scranton    |   NULL | 1992-04-06     |
|         3 | Stamford    |    106 | 1998-02-13     |
|         4 | buffalo     |   NULL | NULL           |
+-----------+-------------+--------+----------------+
4 rows in set (0.000 sec)

MariaDB [company]> delete from branch where_id =2;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'where_id =2' at line 1
MariaDB [company]> delete from branch where branch_id =2;
Query OK, 1 row affected (0.004 sec)

MariaDB [company]> select * from branch_supplier;
+-----------+-----------------+------------------+
| branch_id | supplier_name   | supply_type      |
+-----------+-----------------+------------------+
|         3 | Hammer Mill     | Paper            |
|         3 | Patriot Paper   | Paper            |
|         3 | Stamford Lables | Custom Forms     |
|         3 | Uni-ball        | Writing Utensils |
+-----------+-----------------+------------------+
4 rows in set (0.000 sec)

MariaDB [company]> select * from branch;
+-----------+-------------+--------+----------------+
| branch_id | branch_name | mgr_id | mgr_start_date |
+-----------+-------------+--------+----------------+
|         1 | Corporate   |    100 | 2006-02-09     |
|         3 | Stamford    |    106 | 1998-02-13     |
|         4 | buffalo     |   NULL | NULL           |
+-----------+-------------+--------+----------------+
3 rows in set (0.000 sec)