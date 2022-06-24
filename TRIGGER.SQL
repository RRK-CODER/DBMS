Enter password: *******
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 20
Server version: 10.6.7-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> use company;
Database changed
MariaDB [company]> create table trigger_test ( message VARCHAR(100));
Query OK, 0 rows affected (0.026 sec)

MariaDB [company]> delimiter $$
MariaDB [company]> create trigger my_trigger before insert on employee for each row begin insert into trigger_test values ( 'added new employee');
    -> end $$
Query OK, 0 rows affected (0.019 sec)

MariaDB [company]> delimiter ;
MariaDB [company]> insert into employee values (109, 'Oscar', 'Martinez', '1968-02-19','M', 69000,106,3);
Query OK, 1 row affected (0.024 sec)

MariaDB [company]> select * from trigger_test;
+--------------------+
| message            |
+--------------------+
| added new employee |
+--------------------+
1 row in set (0.000 sec)

MariaDB [company]> delimiter $$
MariaDB [company]> create trigger my_trigger before insert on employee for each row begin insert into trigger_test values ( 'NEW.first_name');
    -> end $$
ERROR 1359 (HY000): Trigger 'company.my_trigger' already exists
MariaDB [company]> create trigger our_trigger before insert on employee for each row begin insert into trigger_test values ( 'NEW.first_name');
    -> end $$
Query OK, 0 rows affected (0.026 sec)    

MariaDB [company]> insert into employee values (110, 'Kevin', 'Malone', '1978-02-19','M', 69000,106,3);
    -> end $$
Query OK, 1 row affected (0.007 sec)

ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'end' at line 1
MariaDB [company]> select * from our_trigger;
    -> end $$
ERROR 1146 (42S02): Table 'company.our_trigger' doesn't exist
MariaDB [company]> select * from trigger_test;
    -> end $$
+--------------------+
| message            |
+--------------------+
| added new employee |
| added new employee |
| NEW.first_name     |
+--------------------+
3 rows in set (0.000 sec)