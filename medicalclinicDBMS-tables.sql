/*DROPPING TABLES and VIEWS*/
DROP VIEW  medicalclinic.Blood_Group_O;
DROP VIEW  medicalclinic.Urgent_Appointments;
DROP VIEW  medicalclinic.Rich_Staff;
DROP TABLE medicalclinic.Schedules;
DROP TABLE medicalclinic.Insured_By;
DROP TABLE medicalclinic.Pays;
DROP TABLE medicalclinic.Schedule;
DROP TABLE medicalclinic.Clinic_Location;
DROP TABLE medicalclinic.MedicalClinic;
DROP TABLE medicalclinic.Patient_Records;
DROP TABLE medicalclinic.Assistant;
DROP TABLE medicalclinic.Doctor;
DROP TABLE medicalclinic.Receptionist;
DROP TABLE medicalclinic.Appointment;
DROP TABLE medicalclinic.Insurance_Company;
DROP TABLE medicalclinic.Patient_Bill;
DROP TABLE medicalclinic.Staff;
DROP TABLE medicalclinic.Patient;

/*CREATING TABLES*/

/*Strong Entity: Patient*/
/*Holds personal information about each Patient*/
CREATE TABLE medicalclinic.Patient(
    Person_ID VARCHAR(10),
    Health_Card_Number VARCHAR(18),
    Person_Name VARCHAR(35) NOT NULL,
    Email_Address VARCHAR(40) NOT NULL,
    Birth_Date VARCHAR(10) NOT NULL,
    Patient_Address VARCHAR(40) NOT NULL,
    Phone_Number VARCHAR(14) NOT NULL,
    PRIMARY KEY (Person_ID, Health_Card_Number)
);

/*Strong Entity: Staff*/
/*Holds personal information about each Staff*/
CREATE TABLE medicalclinic.Staff(
    Person_ID VARCHAR(10),
    Employee_ID VARCHAR(25),
    Person_Name VARCHAR(35) NOT NULL,
    Email_Address VARCHAR(40) NOT NULL,
    Birth_Date VARCHAR(10) NOT NULL,
    Staff_Address VARCHAR(40) NOT NULL,
    Phone_Number VARCHAR(14) NOT NULL,
    Occupation  VARCHAR(20) NOT NULL,
    Annual_Salary DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (Person_ID, Employee_ID)
);

CREATE INDEX idx_health_card_number_ref ON medicalclinic.Patient (Health_Card_Number);

/*Weak Entity: Patient Bill*/
/*This holds Receipt number and the amount owed by patient*/
CREATE TABLE medicalclinic.Patient_Bill(
    Receipt_Number VARCHAR(14),
    Amount_Owed DECIMAL(7,2) NOT NULL,
    Health_Card_Number VARCHAR(18) NOT NULL,
    FOREIGN KEY (Health_Card_Number) REFERENCES medicalclinic.Patient(Health_Card_Number),
    PRIMARY KEY(Receipt_Number)
);

/*Strong Entity: Insurance_Company*/
/*covers some amount ($) of patient bill*/
CREATE TABLE medicalclinic.Insurance_Company(
    Insurance_ID VARCHAR(20),
    Company_Name VARCHAR(30) NOT NULL,
    Amount_Covering Decimal(6,2) NOT NULL,
    PRIMARY KEY (Insurance_ID)
);

/*Weak Entity: Appointment*/
CREATE TABLE medicalclinic.Appointment(
    Appointment_ID VARCHAR(20),
    Type_Of_Appointment VARCHAR(30) NOT NULL,
    Appointment_Date VARCHAR(18) NOT NULL,
    Health_Card_Number VARCHAR(18) NOT NULL,
    FOREIGN KEY (Health_Card_Number) REFERENCES Patient(Health_Card_Number),
    PRIMARY KEY (Appointment_ID)
);

CREATE INDEX idx_employee_id_ref ON medicalclinic.Staff (Employee_ID);

/*Strong Entity: Receptionist*/
CREATE TABLE medicalclinic.Receptionist(
   Employee_ID VARCHAR(25) NOT NULL,
   FOREIGN KEY (Employee_ID) REFERENCES medicalclinic.Staff(Employee_ID),
   PRIMARY KEY (Employee_ID)
);

/*Strong Entity: Doctor*/
CREATE TABLE medicalclinic.Doctor(
    Employee_ID VARCHAR(25) NOT NULL,
    FOREIGN KEY (Employee_ID) REFERENCES medicalclinic.Staff(Employee_ID),
    PRIMARY KEY (Employee_ID)
);

/*Strong Entity: Assistant*/
CREATE TABLE medicalclinic.Assistant(
   Employee_ID VARCHAR(25) NOT NULL,
   FOREIGN KEY (Employee_ID) REFERENCES medicalclinic.Staff(Employee_ID),
   PRIMARY KEY (Employee_ID)
);

/*Weak Entity: Patient Records*/
CREATE TABLE medicalclinic.Patient_Records(
    Health_Card_Number VARCHAR(18) NOT NULL,
    Patient_ID VARCHAR(12),
    Blood_Group VARCHAR(12) NOT NULL,
    Medication_History VARCHAR(50) NOT NULL,
    Employee_ID VARCHAR(25) NOT NULL,    
    FOREIGN KEY (Employee_ID) REFERENCES medicalclinic.Staff(Employee_ID),
    FOREIGN KEY (Health_Card_Number) REFERENCES medicalclinic.Patient(Health_Card_Number),   
    PRIMARY KEY (Patient_ID, Health_Card_Number)
);

/*Strong Entity: Medical Clinic*/
CREATE TABLE medicalclinic.MedicalClinic(
    Clinic_ID VARCHAR(10) PRIMARY KEY,
    Clinic_Name VARCHAR(35) NOT NULL,
    Clinic_Phone_Number VARCHAR(19)
);

/*Strong Entity: Location*/
CREATE TABLE medicalclinic.Clinic_Location(
    Address_ID VARCHAR(10) PRIMARY KEY,
    Clinic_Address VARCHAR(40) NOT NULL,
    Clinic_Postal_Code VARCHAR(30) NOT NULL,
    Clinic_City VARCHAR(30) NOT NULL,
    Clinic_Province VARCHAR(30) NOT NULL
);

/*Weak Entity: Schedule*/
CREATE TABLE medicalclinic.Schedule(
    Task VARCHAR(60) NOT NULL,
    Work_Shift VARCHAR(75) NOT NULL,
    Employee_ID VARCHAR(25) NOT NULL,
    FOREIGN KEY (Employee_ID) REFERENCES medicalclinic.Staff(Employee_ID),
    PRIMARY KEY (Employee_ID)
);

CREATE INDEX idx_receipt_number_ref ON medicalclinic.Patient_Bill(Receipt_Number);

/*Relationship: between Patient and Patient_Bills*/
CREATE TABLE medicalclinic.Pays(
    Health_Card_Number VARCHAR(18),
    Receipt_Number VARCHAR(14),
    FOREIGN KEY (Health_Card_Number) REFERENCES medicalclinic.Patient(Health_Card_Number),
    FOREIGN KEY (Receipt_Number) REFERENCES medicalclinic.Patient_Bill(Receipt_Number),
    PRIMARY KEY(Health_Card_Number,Receipt_Number) 
);

CREATE INDEX idx_insurance_id_ref ON medicalclinic.Insurance_Company(Insurance_ID);

/*Relationship: between Patient and Insurance_Company*/ 
CREATE TABLE medicalclinic.Insured_By(
    Insurance_ID VARCHAR(20),
    Health_Card_Number VARCHAR(18),
    FOREIGN KEY(Insurance_ID) REFERENCES medicalclinic.Insurance_Company(Insurance_ID),
    FOREIGN KEY (Health_Card_Number) REFERENCES medicalclinic.Patient(Health_Card_Number),
    PRIMARY KEY(Insurance_ID,Health_Card_Number) 
);

CREATE INDEX idx_appointment_id_ref ON medicalclinic.Appointment(Appointment_ID);

/*Weak Relationship: between Patient and Appointments*/
CREATE TABLE medicalclinic.Schedules(
    Appointment_ID VARCHAR(20),
    Health_Card_Number VARCHAR(18),
    FOREIGN KEY(Appointment_ID) REFERENCES medicalclinic.Appointment(Appointment_ID),
    FOREIGN KEY (Health_Card_Number) REFERENCES medicalclinic.Patient(Health_Card_Number),
    PRIMARY KEY(Appointment_ID,Health_Card_Number) 
);

/*POPULATING TABLES*/

/*Patient(Person_ID, Health_Card_Number, Person_Name, Email_Address, Birth_Date, Patient_Address, Phone_Number)*/
INSERT INTO Patient VALUES ('1','1111111111AA', 'Maria', 'maria@gmail.com', '01/01/1992', '300 Victoria St Toronto ON M5B 2K3', '4166141231');
INSERT INTO Patient VALUES ('2','1111111111AB', 'Nushi', 'nushi@gmail.com', '02/02/1995', '315 Victoria St Toronto ON M5B 2K3', '4166141232');
INSERT INTO Patient VALUES ('3','1111111111AC', 'Mohammed', 'mohammed@gmail.com', '03/03/1998', '330 Victoria St Toronto ON M5B 2K3', '4166141233');
INSERT INTO Patient VALUES ('4','1111111111AD', 'Jose', 'jose@gmail.com', '04/04/1996', '345 Victoria St Toronto ON M5B 2K3', '4166141234');
INSERT INTO Patient VALUES ('5','1111111111AE', 'Muhammad', 'muhammad@gmail.com', '05/05/1993', '360 Victoria St Toronto ON M5B 2K3', '4166141235');

/*Staff(Person_ID, Employee_ID, Person_Name, Email, Birth_Date, Address, Phone Number, Occupation, Salary)*/
INSERT INTO Staff VALUES ('6','142698745896','Fabel','fabel@gmail.com','09/05/2000','25 Main Street Toronto ON M1K2A7','4165229874','Doctor','300000.00');
INSERT INTO Staff VALUES ('7', '987516479531', 'Olivia', 'olivia@gmail.com', '07/03/1985', '96 Church Street Toronto ON M3H9B8', '4169856556', 'Receptionist', '80000.00');
INSERT INTO Staff VALUES ('8', '846597895211', 'William', 'william@gmail.com', '01/06/1995', '65 Elm Street Toronto ON M0X3L4', '4165447809', 'Assistant', '30000.00');

/*Receptionist(Employee_ID)*/
INSERT INTO Receptionist VALUES ('987516479531');

/*Doctor(Employee_ID)*/
insert into Doctor values ('142698745896');

/*Assistant(Employee_ID)*/
insert into Assistant values ('846597895211');

/*MedicalClinic (Clinic_ID, Clinic_Name, Phone Numer)*/
insert into MedicalClinic values ('1', 'First Priority Medical', '4162312123');

/*Clinic_Location (Address_ID, Clinic_Address, Clinic_Postal Code, Clinic_City, Clinic Province)*/
insert into Clinic_Location values ('1', '96 Yonge Street', 'M9F2J0', 'Toronto',  'Ontario');

/*Patient_Bill(Receipt_Number, Amount_Owed, Health_Card_Number)*/
insert into Patient_Bill values ('1', 55.99,'1111111111AA'); 
insert into Patient_Bill values ('2', 95.67,'1111111111AB'); 
insert into Patient_Bill values ('3', 151.45,'1111111111AC'); 
insert into Patient_Bill values ('4', 55.22,'1111111111AD'); 
insert into Patient_Bill values ('5', 225.33,'1111111111AE');

/*Insurance Company(Insurance_ID, Company_Name, Amount_Covering)*/
insert into Insurance_Company values ('1', 'Green Shield Canada', 500.00);
insert into Insurance_Company values ('2', 'Blue Cross Canada', 1000.00);
insert into Insurance_Company values ('3', 'Manulife', 250.00);
insert into Insurance_Company values ('4', 'Manulife', 1500.00);
insert into Insurance_Company values ('5', 'NA', 0);

/*Appointment (Appointment_ID, Type_Of_Appointment, Appointment_Date, Health_Card_Number)*/
insert into Appointment values ('1', 'Monthly Check Up', '2022-12-13 13:00', '1111111111AA');
insert into Appointment values ('2', 'Urgent Appointment', '2022-12-22 15:00', '1111111111AB');
insert into Appointment values ('3', 'Minor Illness Examination', '2022-12-02 9:00', '1111111111AC');
insert into Appointment values ('4', 'Urgent Appointment', '2022-12-01 8:00', '1111111111AD');
insert into Appointment values ('5', 'Blood Pressure Test', '2022-12-20 18:00', '1111111111AE');

/*Schedule (Task, Work_Shift, Employee_ID)*/
insert into Schedule values ('Examining Patients', 'Mon - Fri, 9:00 - 17:00', '142698745896');
insert into Schedule values ('Assisting Doctor', 'Mon - Fri, 9:00 - 17:00', '846597895211');
insert into Schedule values ('Communicating with Visitors and Overlooking Activities', 'Mon - Fri, 9:00 - 17:00', '987516479531');


/*Pays(Health_Card_Number, Reciet_Number)*/
insert into Pays values ('1111111111AA', '1');
insert into Pays values ('1111111111AB', '2');
insert into Pays values ('1111111111AC', '3');
insert into Pays values ('1111111111AD', '4');
insert into Pays values ('1111111111AE', '5');

/*Insured_By(Insurance_ID,Health_Card_Number)*/
insert into Insured_By values ('1','1111111111AA');
insert into Insured_By values ('2','1111111111AB');
insert into Insured_By values ('3','1111111111AC');
insert into Insured_By values ('4','1111111111AD');
insert into Insured_By values ('5','1111111111AE');

/* Schedules(Appointment_ID, Health_Card_Number)*/
insert into Schedules values ('1', '1111111111AA');
insert into Schedules values ('2', '1111111111AB');
insert into Schedules values ('3', '1111111111AC');
insert into Schedules values ('4', '1111111111AD');
insert into Schedules values ('5', '1111111111AE');

/*Patient_Records (Health_Card_Number, Patient_ID, Blood_Group, Medication_History, Employee_ID)*/
insert into Patient_Records values ('1111111111AA', '1', 'O','Laxatives','987516479531' );
insert into Patient_Records values ('1111111111AB', '2', 'AB','Calcium Carbonate','987516479531' );
insert into Patient_Records values ('1111111111AC', '3', 'A','Insulin','987516479531' );
insert into Patient_Records values ('1111111111AD', '4', 'B','Painkillers','987516479531' );
insert into Patient_Records values ('1111111111AE', '5', 'O','Xanax','987516479531' );

/*VIEW 1 */
/*Lists all staff who are rich (have annual salary > 50000)*/
CREATE VIEW Rich_Staff AS
SELECT Person_Name, Annual_Salary
FROM Staff
WHERE Annual_Salary > 50000;    

/*VIEW 2*/
/*Lists all Patients with that have Urgent Appointments*/
CREATE VIEW Urgent_Appointments AS
SELECT p.Person_Name as "Person Name", Type_Of_Appointment as "Type Of Appointment"
FROM Patient p, Appointment a
WHERE p.Health_Card_Number = a.Health_Card_Number
      AND Type_Of_Appointment = 'Urgent Appointment';    

/*VIEW 3*/
/* Lists all Patients that have blood group O.*/
CREATE VIEW Blood_Group_O AS
SELECT p.Person_Name as "Person Name", Blood_Group as "Blood Group"
FROM Patient p, Patient_Records pr
WHERE p.Health_Card_Number = pr.Health_Card_Number
      AND Blood_Group = 'O';  