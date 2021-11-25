-- CREATE DATABASE school;
USE school;

CREATE TABLE student (
	id INT PRIMARY KEY AUTO_INCREMENT,
	bmst VARCHAR(45),
	std_name VARCHAR(45) NOT NULL,
	birth DATE NOT NULL,
	phone VARCHAR(45) NOT NULL,
	email VARCHAR(45),
	address VARCHAR(45)
);

CREATE TABLE major (
	id INT PRIMARY KEY AUTO_INCREMENT,
	major_name VARCHAR(45) NOT NULL,
	professor VARCHAR(45) NOT NULL,
	is_active ENUM('is_active', 'inactive') NOT NULL,
	duration INT,
	weekly_hours INT
);

CREATE TABLE admission (
	std_id INT NOT NULL,
	major_id INT NOT NULL
);
ALTER TABLE admission ADD CONSTRAINT admission_std_key FOREIGN KEY (std_id) REFERENCES student(id);
ALTER TABLE admission ADD CONSTRAINT admission_major_key FOREIGN KEY (major_id) REFERENCES major(id);

CREATE TABLE class (
	id INT PRIMARY KEY AUTO_INCREMENT,
	num INT NOT NULL UNIQUE,
	class_date DATE NOT NULL,
	major_id INT NOT NULL
);
ALTER TABLE class ADD CONSTRAINT class_major_key FOREIGN KEY (major_id) REFERENCES major(id);

CREATE TABLE class_enroll (
	id INT PRIMARY KEY AUTO_INCREMENT,
	std_id INT NOT NULL,
    class_id INT NOT NULL
);

ALTER TABLE class_enroll 
	ADD CONSTRAINT class_enroll_std_id FOREIGN KEY (std_id) REFERENCES student(id) ON DELETE CASCADE,
    ADD CONSTRAINT class_enroll_class_id FOREIGN KEY (class_id) REFERENCES class(id) ON DELETE CASCADE;

INSERT INTO student(std_name, birth, phone, email) VALUES('Alana','1999-12-04','(85) 9 XXXX-XXXX','name@teste.com');
INSERT INTO student(std_name, birth, phone, email) VALUES('Carla','1997-05-10','(85) 9 XXXX-XXXX','name@teste.com');
INSERT INTO student(std_name, birth, phone, email) VALUES('Joana','2001-12-04','(85) 9 XXXX-XXXX','name@teste.com');
INSERT INTO student(std_name, birth, phone, email) VALUES('Ana','2000-07-13','(85) 9 XXXX-XXXX','name@teste.com');
INSERT INTO student(std_name, birth, phone, email) VALUES('Carlos','1999-08-09','(85) 9 XXXX-XXXX','name@teste.com');
INSERT INTO student(std_name, birth, phone, email) VALUES('Arlan','2000-10-24','(85) 9 XXXX-XXXX','name@teste.com');

INSERT INTO major(major_name, professor, is_active, duration, weekly_hours) VALUES('Biology', 'Armando', 'is_active', 800, 20);
INSERT INTO major(major_name, professor, is_active, duration, weekly_hours) VALUES('History', 'Lucas', 'is_active', 800, 30);
INSERT INTO major(major_name, professor, is_active, duration, weekly_hours) VALUES('Math', 'Mariana', 'is_active', 1000, 20);
INSERT INTO major(major_name, professor, is_active, duration, weekly_hours) VALUES('Physics', 'Julia', 'inactive', 800, 20);

INSERT INTO admission VALUES(1, 3);
INSERT INTO admission VALUES(2, 2);
INSERT INTO admission VALUES(3, 2);
INSERT INTO admission VALUES(4, 2);
INSERT INTO admission VALUES(5, 1);
INSERT INTO admission VALUES(6, 1);

INSERT INTO class(num, class_date, major_id) VALUES(1, '2021-01-01', 2);
INSERT INTO class(num, class_date, major_id) VALUES(2, '2021-01-02', 2);
INSERT INTO class(num, class_date, major_id) VALUES(3, '2021-01-03', 3);
INSERT INTO class(num, class_date, major_id) VALUES(4, '2021-01-04', 1);
INSERT INTO class(num, class_date, major_id) VALUES(5, '2021-01-05', 1);
INSERT INTO class(num, class_date, major_id) VALUES(6, '2021-01-06', 2);

INSERT INTO class_enroll(std_id, class_id) VALUES(1, 3);
INSERT INTO class_enroll(std_id, class_id) VALUES(2, 2);
INSERT INTO class_enroll(std_id, class_id) VALUES(3, 1);
INSERT INTO class_enroll(std_id, class_id) VALUES(4, 6);
INSERT INTO class_enroll(std_id, class_id) VALUES(5, 4);
INSERT INTO class_enroll(std_id, class_id) VALUES(6, 4);

SELECT * FROM student;
SELECT * FROM major;
SELECT * FROM admission;
SELECT * FROM class;
SELECT * FROM class_enroll;

-- STUDENT COUNT BY MAJOR
SELECT m.major_name, COUNT(s.id) as std_count 
	FROM major as m JOIN student as s JOIN admission as a
    ON a.std_id = s.id AND a.major_id = m.id
	GROUP BY m.id;

-- CLASS NUM BY STUDENT NAME
SELECT  c.num, s.std_name
	FROM class_enroll as cls_en JOIN class as c JOIN student as s
    ON cls_en.std_id = s.id AND cls_en.class_id = c.id;

-- STUDENT COUNT BY CLASS
SELECT c.num, COUNT(s.id)
	FROM class_enroll as cls_en JOIN class as c JOIN student as s
    ON cls_en.class_id = c.id AND cls_en.std_id = s.id
    GROUP BY c.num;

-- SELECT BY INITIAL STUDENT NAME CHAR
SELECT *
	FROM student as s
    WHERE s.std_name LIKE 'A%';

/*
drop table class_enroll;
drop table class;
drop table admission;
drop table student;
drop table major;
*/