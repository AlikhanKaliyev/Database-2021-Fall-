--1a
select course_id,title
from course
where credits > 3;
--1b
select room_number
from classroom
where building = 'Watson' or building = 'Packard';
--1c
select course_id,title
from course
where dept_name = 'Comp. Sci.';
--1d
select course.course_id, title
from course,section
where course.course_id = section.course_id and section.semester = 'Fall';
--1e
select id,name
from student
where tot_cred > 45 and tot_cred < 90;
--1f
select id,name
from student
where name like '%a'
or name like '%e'
or name like '%u'
or name like '%i'
or name like '%o';
--1g
select course.course_id,course.title
from course,prereq
where course.course_id = prereq.course_id and  prereq.prereq_id = 'CS-101';
--2a
select dept_name,avg(salary) as average
from instructor
group by dept_name
order by average asc;
--2b
select building,count(course_id ) as number
from section
group by building
order by number desc
limit 1;
--2c
select dept_name,count(course_id) as number
from course
group by dept_name
order by number asc
limit 5;
--2d
select distinct student.id,student.name
from student,takes
where student.id = takes.id and takes.course_id like 'CS%';
--2e
select distinct id,name
from instructor
where dept_name = 'Biology'
or dept_name = 'Philosophy'
or dept_name = 'Music';
--2f
select distinct instructor.id,instructor.name
from instructor,teaches
where teaches.year = 2018 and teaches.id = instructor.id and teaches.id not in (select teaches.id
      from teaches
      where teaches.year= 2017);

--3a
select distinct student.id,student.name
from student,takes
where takes.grade ='A' or takes.grade = 'A-'
order by name asc;

--3b
select distinct advisor.i_id
from advisor,takes
where takes.grade = 'B-'
or takes.grade = 'C+'
or takes.grade = 'C-'
or takes.grade = 'F+'
or takes.grade = 'F'
or takes.grade = 'F-'
or takes.grade = NULL;
--3c
select distinct course.dept_name
from course
where course.dept_name not in
      (select distinct course.dept_name
       from course,
            takes
       where course.course_id = takes.course_id
         and (takes.grade = 'C' or takes.grade = 'C-' or takes.grade = 'F' or takes.grade = 'F-'
           or takes.grade = 'C+' or takes.grade = 'F+')
      );

--3d
select instructor.id ,instructor.name
from instructor
where instructor.id not in
(
select  distinct instructor.id
from instructor,course,takes,teaches
where instructor.id = teaches.id and takes.grade like 'A%'
and teaches.course_id = course.course_id and teaches.course_id = takes.course_id
);
--3e
select  distinct course.course_id,course.title
from course,section,time_slot
where course.course_id = section.course_id and section.time_slot_id = time_slot.time_slot_id
and time_slot.end_hr <13;

