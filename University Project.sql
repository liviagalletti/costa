-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `University` DEFAULT CHARACTER SET utf8 ;
USE `University` ;

-- -----------------------------------------------------
-- Table `University`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`college` ;

CREATE TABLE IF NOT EXISTS `University`.`college` (
  `college_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`college_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`department` ;

CREATE TABLE IF NOT EXISTS `University`.`department` (
  `department_code` VARCHAR(10) NOT NULL,
  `departments_name` VARCHAR(30) NULL,
  `college_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`department_code`),
  INDEX `fk_department_college1_idx` (`college_name` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_name`)
    REFERENCES `University`.`college` (`college_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`course` ;

CREATE TABLE IF NOT EXISTS `University`.`course` (
  `course_num` INT NOT NULL,
  `course_title` VARCHAR(100) NULL,
  `credits` INT NULL,
  `department_code` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`course_num`),
  INDEX `fk_course_department1_idx` (`department_code` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_code`)
    REFERENCES `University`.`department` (`department_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`faculty` ;

CREATE TABLE IF NOT EXISTS `University`.`faculty` (
  `faculty_fname` VARCHAR(50) NOT NULL,
  `faculty_lname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`faculty_fname`, `faculty_lname`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`section` ;

CREATE TABLE IF NOT EXISTS `University`.`section` (
  `year` YEAR NOT NULL,
  `term` VARCHAR(10) NOT NULL,
  `section_num` INT NOT NULL,
  `capacity` INT NULL,
  `course_num` INT NOT NULL,
  `faculty_fname` VARCHAR(50) NOT NULL,
  `faculty_lname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`year`, `term`, `section_num`),
  INDEX `fk_section_course1_idx` (`course_num` ASC) VISIBLE,
  INDEX `fk_section_faculty1_idx` (`faculty_fname` ASC, `faculty_lname` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_num`)
    REFERENCES `University`.`course` (`course_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_fname` , `faculty_lname`)
    REFERENCES `University`.`faculty` (`faculty_fname` , `faculty_lname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`students` ;

CREATE TABLE IF NOT EXISTS `University`.`students` (
  `students_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `gender` ENUM('f', 'm') NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(2) NULL,
  `birthdate` DATE NULL,
  PRIMARY KEY (`students_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `University`.`enrollment` (
  `year` YEAR NOT NULL,
  `term` VARCHAR(10) NOT NULL,
  `section_num` INT NOT NULL,
  `students_id` INT NOT NULL,
  `course_num` INT NOT NULL,
  PRIMARY KEY (`year`, `term`, `section_num`, `students_id`),
  INDEX `fk_section_has_students_students1_idx` (`students_id` ASC) VISIBLE,
  INDEX `fk_section_has_students_section1_idx` (`year` ASC, `term` ASC, `section_num` ASC) VISIBLE,
  INDEX `fk_section_has_students_course1_idx` (`course_num` ASC) VISIBLE,
  CONSTRAINT `fk_section_has_students_section1`
    FOREIGN KEY (`year` , `term` , `section_num`)
    REFERENCES `University`.`section` (`year` , `term` , `section_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_has_students_students1`
    FOREIGN KEY (`students_id`)
    REFERENCES `University`.`students` (`students_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_has_students_course1`
    FOREIGN KEY (`course_num`)
    REFERENCES `University`.`course` (`course_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE university;

INSERT INTO college (college_name) VALUES
('College of Physical Science and Engineering'),
('College of Business and Communication'),
('College of Language and Letters');


INSERT INTO department (department_code, departments_name, college_name) VALUES 
('CIT', 'Computer Information Technology', 'College of Physical Science and Engineering'),
('ECON', 'Economics', 'College of Business and Communication'),
('HUM', 'Humanities and Philosophy', 'College of Language and Letters');

INSERT INTO course (course_num, course_title, credits, department_code) VALUES
(111, 'Intro to Databases', 3, 'CIT'),
(388, 'Econometrics', 4, 'ECON'),
(150, 'Micro Economics', 3, 'ECON'),
(376, 'Classical Heritage', 2, 'HUM');

INSERT INTO faculty (faculty_fname, faculty_lname) VALUES
('Marty', 'Morring'),
('Nate', 'Norris'),
('Ben', 'Barrus'),
('John', 'Jensen'),
('Bill', 'Barney');

INSERT INTO section (year, term, section_num, capacity, course_num, faculty_fname, faculty_lname) 
VALUES 
(2019, 'Fall', 1, 30, 111, 'Marty', 'Morring'),
(2019, 'Fall', 2, 50, 150, 'Nate', 'Norris'),
(2019, 'Fall', 3, 50, 150, 'Nate', 'Norris'),
(2019, 'Fall', 4, 35, 388, 'Ben', 'Barrus'),
(2019, 'Fall', 5, 30, 376, 'John', 'Jensen'),
(2018, 'Winter', 6, 30, 111, 'Marty', 'Morring'),
(2018, 'Winter', 7, 35, 111, 'Bill', 'Barney'),
(2018, 'Winter', 8, 50, 150, 'Nate', 'Norris'),
(2018, 'Winter', 9, 50, 150, 'Nate', 'Norris'),
(2018, 'Winter', 10, 30, 376, 'John', 'Jensen');

INSERT INTO students (students_id, first_name, last_name, gender, city, state, birthdate) VALUES
(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
(2, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
(3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
(4, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
(5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
(6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
(7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
(8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
(9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
(10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');


INSERT INTO enrollment (year, term, section_num, students_id, course_num) 
VALUES 
(2018, 'Winter', 6, 6, 111),
(2018, 'Winter', 7, 7, 111),
(2018, 'Winter', 8, 7, 150),
(2018, 'Winter', 9, 7, 376),
(2019, 'Fall', 5, 4, 376),
(2018, 'Winter', 8, 9, 150),
(2019, 'Fall', 4, 2, 388),
(2019, 'Fall', 4, 3, 388),
(2019, 'Fall', 4, 5, 388),
(2019, 'Fall', 5, 5, 376),
(2019, 'Fall', 1, 1, 111),
(2019, 'Fall', 2, 1, 150),
(2018, 'Winter', 7, 8, 150),
(2018, 'Winter', 9, 10, 111);

-- 01
SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %e, %Y') AS formatted_birthdate
FROM students
WHERE MONTH(birthdate) = 9
ORDER BY last_name;

-- 02 
SELECT 
    first_name, 
    last_name, 
    FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) AS years,
    DATEDIFF('2017-01-05', DATE_ADD(birthdate, INTERVAL FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) YEAR)) AS days,
    CONCAT(FLOOR(DATEDIFF('2017-01-05', birthdate) / 365), ' years ', 
           DATEDIFF('2017-01-05', DATE_ADD(birthdate, INTERVAL FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) YEAR)), ' days') AS age_label
FROM students
ORDER BY years DESC, days DESC;


-- 03 
SELECT s.first_name, s.last_name
FROM students s
INNER JOIN enrollment e ON s.students_id = e.students_id
INNER JOIN section sec ON e.year = sec.year AND e.term = sec.term AND e.section_num = sec.section_num
WHERE sec.faculty_fname = 'John' AND sec.faculty_lname = 'Jensen'
ORDER BY s.last_name;

-- 04
SELECT DISTINCT fac.faculty_fname, fac.faculty_lname
FROM faculty fac
INNER JOIN section sec ON fac.faculty_fname = sec.faculty_fname AND fac.faculty_lname = sec.faculty_lname
INNER JOIN enrollment e ON sec.year = e.year AND sec.term = e.term AND sec.section_num = e.section_num
INNER JOIN students s ON e.students_id = s.students_id
WHERE s.first_name = 'Bryce'
ORDER BY fac.faculty_lname;

-- 05
SELECT DISTINCT stu.first_name, stu.last_name
FROM students stu
INNER JOIN enrollment e ON stu.students_id = e.students_id
INNER JOIN section sec ON e.year = sec.year AND e.term = sec.term AND e.section_num = sec.section_num
INNER JOIN course c ON e.course_num = c.course_num
WHERE c.course_title = 'Econometrics' AND sec.year = 2019 AND sec.term = 'Fall'
ORDER BY stu.last_name;

-- 06
SELECT d.department_code, c.course_num, c.course_title
FROM students s
JOIN enrollment e ON s.students_id = e.students_id
JOIN section sec ON e.year = sec.year AND e.term = sec.term AND e.section_num = sec.section_num
JOIN course c ON e.course_num = c.course_num
JOIN department d ON c.department_code = d.department_code
WHERE s.first_name = 'Bryce' AND s.last_name = 'Carlson' AND sec.year = 2018 AND sec.term = 'Winter'
ORDER BY c.course_title;

-- 07
SELECT term, year, COUNT(students_id) AS num_students
FROM enrollment
WHERE year = 2019 AND term = 'Fall';

-- 08
SELECT c.college_name, COUNT(DISTINCT co.course_num) AS num_courses
FROM college c
JOIN department d ON c.college_name = d.college_name
JOIN course co ON d.department_code = co.department_code
GROUP BY c.college_name
ORDER BY c.college_name;

-- 09
SELECT sec.faculty_fname, sec.faculty_lname, SUM(sec.capacity) AS total_capacity
FROM section sec
WHERE sec.year = 2018 AND sec.term = 'Winter'
GROUP BY sec.faculty_fname, sec.faculty_lname
ORDER BY total_capacity ASC;

-- 10
SELECT s.last_name, s.first_name, SUM(c.credits) AS total_credits
FROM students s
JOIN enrollment e ON s.students_id = e.students_id
JOIN section sec ON e.year = sec.year AND e.term = sec.term AND e.section_num = sec.section_num
JOIN course c ON e.course_num = c.course_num
WHERE e.year = 2019 AND e.term = 'Fall'
GROUP BY s.students_id
HAVING total_credits > 3
ORDER BY total_credits DESC;

