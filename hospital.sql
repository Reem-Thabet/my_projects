Create database hospital_DBB
use hospital_DBB

create table patients(
pt_id int primary key identity(1,1),
pt_name varchar(225),
pt_gender varchar(50),
pt_dob date ,
contact_number varchar(15),
pt_address varchar(255),
medical_history text)
insert into patients( pt_name ,pt_gender , pt_dob , contact_number , pt_address , medical_history)
values 
('John Doe', 'Male', '1985-07-12', '1234567890', '123 Elm St', 'Diabetes, Hypertension'),
('Jane Smith', 'Female', '1990-09-25', '0987654321', '456 Oak St', 'Asthma'),
 ('Michael Scott', 'Male', '1964-03-15', '2223334444', '789 Birch St', 'Hypertension'),
('Pam Beesly', 'Female', '1980-09-25', '9876543210', '456 Cedar St', 'None'),
('Dwight Schrute', 'Male', '1978-01-20', '5556667777', '123 Farm Ln', 'None'),
('Jim Halpert', 'Male', '1979-10-01', '1112223333', '321 Maple St', 'Back Pain');


create table doctors(
doc_id int primary key identity(1,1),
doc_name varchar(225),
doc_specialization varchar(100),
contact_number varchar(15),
doc_email varchar(100) )
insert into doctors( doc_name , doc_specialization , contact_number , doc_email)
values 
('Dr. Alice Johnson', 'Cardiologist', '5551234567', 'alice.j@hospital.com'),
('Dr. Robert Brown', 'Dermatologist', '5559876543', 'robert.b@hospital.com'),
('Dr. Meredith Palmer', 'Psychiatrist', '5553334444', 'meredith.p@hospital.com'),
('Dr. Stanley Hudson', 'Endocrinologist', '5557778888', 'stanley.h@hospital.com');


create table appointments(
appointmenr_id int primary key identity(1,1) ,
pt_id int foreign key references patients(pt_id),
doc_id int foreign key references doctors(doc_id),
appointment_date date ,
appointment_time time , 
status text  )
insert into appointments(pt_id , doc_id , appointment_date , appointment_time , status) 
values 
(1, 1, '2024-10-20', '10:00:00', 'Scheduled'),
(2, 2, '2024-10-21', '11:30:00', 'Scheduled'),
(3, 1, '2024-10-22', '09:00:00', 'Completed'),
(4, 3, '2024-10-23', '12:00:00', 'Scheduled'),
(5, 4, '2024-10-24', '14:00:00', 'Cancelled');

INSERT INTO appointments (pt_id, doc_id, appointment_date, appointment_time, status) 
VALUES 
(3, 1, '2024-12-20', '10:00:00', 'Scheduled'),
(5, 2, '2024-12-21', '11:30:00', 'Scheduled')
INSERT INTO Appointments (pt_id, doc_id, appointment_date, appointment_time, status) 
VALUES 
(2, 3, '2024-1-9', '10:00:00', 'Scheduled')



create table billing(
bill_id int primary key identity(1,1) ,
pt_id int foreign key references patients(pt_id),
doc_id int foreign key references doctors(doc_id),
bill_date date, 
amount decimal(10,2),
status text  )
insert into billing ( pt_id , doc_id, bill_date , amount , status)
values 
(1, 1, '2024-10-20', 200.00, 'Paid'),
(2, 2, '2024-10-21', 150.00, 'Pending'),
(3, 1, '2024-10-22', 300.00, 'Paid'),
(4, 3, '2024-10-23', 250.00, 'Pending'),
(5, 4, '2024-10-24', 400.00, 'Cancelled');


select* from doctors
select * from patients
select * from appointments
select * from billing 

--1-- 
select count(*) as total_patients from patients
--2--
select  pt_name , medical_history from patients where medical_history is not null and medical_history not like 'None'
--3--
select * from appointments where status like 'Scheduled'
--4--
select doc_id , count(*) as total_appointments  from appointments group by doc_id
--5--
select * from billing where status like 'Pending'
--6--
select pt_id, sum(amount) as total_bills from billing group by pt_id
--7--
select d.doc_name as doctor , p.pt_name as patient from appointments a join doctors d on a.doc_id = d.doc_id join patients p on a.pt_id=p.pt_id
order by d.doc_name
--8--
select * from billing where month(bill_date) = 10
--9--
select pt_id , count(distinct doc_id) as number_of_doctors from appointments group by pt_id having count(distinct doc_id) > 1
select p.pt_name , count(a.doc_id) as [total_visits] from appointments a inner join patients p on a.pt_id = p.pt_id group by p.pt_name 
having count(distinct a.doc_id)>1;
--10--
select d.doc_name , count(*) as total_appointments from appointments a join doctors d on a.doc_id = d.doc_id 
where month(a.appointment_date) = 10 group by d.doc_name 
select d.doc_name , count(a.doc_id) as [total appointments] from doctors as d inner join appointments as a on d.doc_id =a.doc_id
where format(a.appointment_date , 'MMMM')='October' group by doc_name
--11--
select d.doc_name , sum(b.amount) as total_income from billing b join doctors d on b.doc_id = d.doc_id 
where b.status like 'Paid' group by d.doc_name
--12--
select distinct p.pt_name from billing b join patients p on b.pt_id =p.pt_id where b.status like 'Pending'
select p.pt_name, b.bill_date, b.amount , b.status from billing b join patients p on b.pt_id =p.pt_id where b.status like 'Pending'
--13--
select distinct p.pt_name from appointments a join patients p on a.pt_id = p.pt_id where a.status like 'Cancelled'
select p.pt_name , a.appointment_date,a.appointment_time,a.status from appointments a join patients p on a.pt_id = p.pt_id 
where a.status like 'Cancelled'
--14--
select avg(amount) as average_bill_amount from billing 
--15--
select distinct appointment_date, count(*) as total_appointments from appointments group by appointment_date
select format(appointment_date , 'dddd') as day_name , format(appointment_date , 'MMMM') as month_name , format(appointment_date , 'yyyy') as year
,count(appointmenr_id) as total_appointments from appointments 
group by format(appointment_date , 'dddd'), format(appointment_date , 'MMMM'), format(appointment_date , 'yyyy')
--16--
select distinct p.pt_name from patients  p left join appointments a on p.pt_id = a.pt_id where a.appointment_date is null 
select p.pt_name , a.appointment_date from appointments a inner join patients p on a.pt_id = p.pt_id 
where a.appointment_date < dateadd(month , -6, cast('2024-12-14' as date))
--17--
select month(bill_date) as month , sum(amount) as total_revenue from billing where status like 'paid' group by month(bill_date)
select format(bill_date  , 'yyyy'), format(bill_date, 'MMMM'), sum(amount) from billing where status like 'Paid'
group by format(bill_date  , 'yyyy'), format(bill_date, 'MMMM')
--18--
select top 3 p.pt_name , count(*) as total_appointments from appointments a join patients p on a.pt_id=p.pt_id group by p.pt_name
order by count(*) desc



select p.pt_name , a.appointment_date from appointments a inner join patients p on a.pt_id = p.pt_id 
where a.appointment_date < dateadd(month , -6, cast('2024-12-14' as date))

select format(bill_date  , 'yyyy'), format(bill_date, 'MMMM'), sum(amount) from billing where status like 'Paid'
group by format(bill_date  , 'yyyy'), format(bill_date, 'MMMM')


select top 3 p.pt_name , count(a.pt_id) as [total visits] from patients p inner join appointments a on p.pt_id=a.pt_id
group by p.pt_name order by count (a.pt_id)desc
