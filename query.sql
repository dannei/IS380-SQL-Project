set echo on

spool e:query.txt
/* Q1. Display CNum, CTitle, Grade for Andy */
select Enrollments.CNum, Ctitle, Grade 
from Students, Enrollments, Courses 
where SName='Andy' and Students.SNum=Enrollments.SNum and Enrollments.CNum=Courses.CNum;

/* Q2. Display SNum, SName of students who took Is380 */
select Enrollments.SNum, Sname
from Students, Enrollments
where CNum='IS380' and Students.SNum=Enrollments.SNum;

/* Q3. Display SNum, SName of students who took Is380 and got a A */
select Enrollments.SNum, Sname
from Students, Enrollments
where CNum='IS380' and Students.SNum=Enrollments.SNum and Grade='A';

/* Q4. Display SNum, SName of students who took Is380 and IS majors */
select Enrollments.SNum, Sname
from Students, Enrollments
where CNum='IS380' and Students.SNum=Enrollments.SNum and Major='IS';

/* Q5. Display SNum and SName of IS students who received an 'A' in Is380 */
select Enrollments.SNum, Sname
from Students, Enrollments
where CNum='IS380' and Students.SNum=Enrollments.SNum and Major='IS' and Grade='A';

spool off

