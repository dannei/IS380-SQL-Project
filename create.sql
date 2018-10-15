/* HW4: Create.txt */

set echo on


/* Drop and Create Tables */

drop table enrollments;

drop table courses;

drop table students;

create table Courses (CNum varchar2(8), Ctitle varchar2(25), Inst varchar2(25), primary key (CNum));

create table Students (SNum varchar2(3), SName varchar2(25), Major varchar2(20), GPA Number(3,2), primary key (SNum,SName));

create table Enrollments (SNum varchar2(3), CNum varchar2(8), Grade varchar2(1), primary key (SNum,CNum), constraint fk_enrollment_CNum foreign key (CNum) references Courses(Cnum));

/* Insert data into students */
insert into Students values ('101', 'Andy', 'IS', '3.2');
insert into Students values ('102', 'Betty', 'FIN', '1.8');
insert into Students values ('103', 'Cindy', 'IS', '3.8');

/* Insert data into Courses */
insert into Courses values ('IS380', 'Database', 'Lee');
insert into Courses values ('IS385', 'Systems', 'Smiths');
insert into Courses values ('IS355', 'Telecomm', 'Lee');

/* Insert data into Enrollments */
insert into Enrollments values ('101', 'IS380', 'B');
insert into Enrollments values ('101', 'IS385', 'A');
insert into Enrollments values ('102', 'IS380', 'A');
insert into Enrollments values ('103', 'IS355', 'B');

/* Q1. Display CNum, CTitle, Grade for Andy */
select Enrollments.CNum, Ctitle, Grade 
from Students, Enrollments, Courses 
where SName='Andy' and Students.SNum=Enrollments.SNum and Enrollments.CNum=Courses.CNum;




