/*Simple Query 1 - Results 1*/
/*Displays all the data of patients in alphabetical order of Patient Name*/ 
SELECT
    Person_ID as "Person ID",
    Health_Card_Number as "Health Card Number",
    Person_Name  as "Person Name",
    Email_Address as "Email Address",
    Birth_Date as "Birth Date",
    Patient_Address as "Address",
    Phone_Number as "Phone Number"
    FROM Patient
    ORDER BY Person_ID;

/*Simple Query 2 - Results 2*/
/*Displays all the data of staff by Employee ID*/
SELECT
    Person_ID as "Person ID",
    Employee_ID as "Employee ID",
    Person_Name as "Person Name",
    Email_Address as "Email Address",
    Birth_Date as "Birth Date",
    Staff_Address as "Address",
    Phone_Number as "Phone Number",
    Occupation  as "Occupation",
    Annual_Salary as "Annual Salary"
FROM Staff
ORDER BY Employee_ID;

/*Simple Query 3 - Results 3*/
/*Displays all the data of schedule by Employee ID*/
SELECT 
    Task as "Task",
    Work_Shift as "Work Shift",
    Employee_ID as "Employee ID"
FROM Schedule
ORDER BY Employee_ID;

/*Simple Query 4 - Results 4*/
/*Displays all the data of Patient Records by Health Card Number*/
SELECT 
    Health_Card_Number as "Health Card Number",
    Patient_ID as "Patient ID",
    Blood_Group as "Blood Group",
    Medication_History as "Medication History",
    Employee_ID as "Employee ID"
FROM Patient_Records
ORDER BY Health_Card_Number;
  
/*Simple Query 5 - Results 5*/
/*Displays all the data of Appointment by Appointment ID*/
SELECT 
    Appointment_ID as "Appointment ID",
    Type_Of_Appointment as "Type Of Appointment",
    Appointment_Date as "Appointment Date",
    Health_Card_Number as "Health Card Number"
FROM Appointment
ORDER BY Appointment_ID;

/*Simple Query 6 - Results 6*/
/*Insurance Company*/
/*Displays all the distinct insurance companies used by patients*/
SELECT
    Distinct COMPANY_NAME as "Company Name"
FROM Insurance_Company;

/*Simple Query 7 - Results 7*/
/*Patient Bill*/
SELECT
    Receipt_Number as "Receipt Number", 
    Health_Card_Number as "Health Card Number",
    Amount_Owed as "Amount Owed"
From Patient_Bill
Where Amount_Owed > 0;

/*Simple Query 8 - Results 8*/
/*Gets receptionist Employee ID*/
SELECT
    Employee_ID as "Receptionist Employee ID"
From Receptionist;

/*Simple Query 9 - Results 9*/
/*Gets assistant Employee ID*/
SELECT
    Employee_ID as "Assistant Employee ID"
From assistant;

/*Simple Query 10 - Results 10*/
/*Gets Doctor Employee ID*/
SELECT
    Employee_ID as "Doctor Employee ID"
From Doctor;

/*Simple Query 11 - Results 11*/
/*Returns Medical Clinic Location details*/
SELECT 
    Address_ID as "Address ID",
    Clinic_Address as "Clinic Address",
    Clinic_Postal_Code as "Clinic Postal Code",
    Clinic_City as "Clinic City",
    Clinic_Province as "Clinic Province"
FROM Clinic_Location;

/*Simple Query 12 - Results 12*/
/*Returns a patients health card number and insurance id*/
SELECT 
    Insurance_ID as "Insurance ID",
    Health_Card_Number as "Health Card Number"
FROM Insured_By;

/*Simple Query 13 - Results 13*/
/*Return Medical Clinic Details*/
SELECT 
    Clinic_ID as "Clinic ID",
    Clinic_Name as "Clinic Name",
    Clinic_Phone_Number as "Clinic Phone Number"
FROM MedicalClinic;

/*Simple Query 14 - Results 14*/
/*Returns health card numbers and their Reciepts*/
SELECT 
    Receipt_Number as "Receipt Number",
    Health_Card_Number as "Health Card Number"
FROM Pays
ORDER BY Receipt_Number;

/*Simple Query 15 - Results 15*/
/*Returns All the schedules in order of appointment ID*/
SELECT 
    Appointment_ID as "Appointment ID",
    Health_Card_Number as "Health Card Number"
FROM Schedules
ORDER BY Appointment_ID;

/*Advanced Query 1 - Results 16*/
/*Selects all patients that have insurance*/
SELECT p.Health_Card_Number as "Health Card Number", Person_Name as "Person Name", Amount_Covering as "Amount Covering"
FROM Patient p, Insured_By i, Insurance_Company ic
WHERE p.Health_Card_Number = i.Health_Card_Number
        AND i.Insurance_ID = ic.Insurance_ID
        AND Amount_Covering > 0
ORDER BY Amount_Covering ASC; 
        
/*Advanced Query 2 - Results 17*/
/*Selects all patients that don't have insurance */
SELECT p.Health_Card_Number as "Health Card Number", Person_Name as "Person Name", Amount_Covering as "Amount Covering"
FROM Patient p, Insured_By i, Insurance_Company ic
WHERE p.Health_Card_Number = i.Health_Card_Number
        AND i.Insurance_ID = ic.Insurance_ID
        AND Amount_Covering = 0; 
        
/*Advanced Query 3 - Results 18*/
/*Lists all patients that amount covering is greater than amount owed*/
SELECT p.Health_Card_Number as "Health Card Number", Person_Name as "Person Name", Amount_Covering as "Amount Covering", Amount_Owed as "Amount Owed"
FROM Patient p, Insured_By i, Insurance_Company ic, Patient_Bill pb
WHERE   p.Health_Card_Number = pb.Health_Card_Number
        AND p.Health_Card_Number = i.Health_Card_Number
        AND i.Insurance_ID = ic.Insurance_ID
        AND Amount_Covering > Amount_Owed 
ORDER BY Person_Name;
    
/*Interesting Advanced Query 1 - Results 19*/ 
/*Shows the minimum, maximum and average salary of all staff in the clinic.*/
SELECT MIN(Annual_Salary) as "Minimum Salary", MAX(Annual_Salary) as "Maximum Salary", AVG(Annual_Salary) as "Average Salary"
FROM Staff;

/*Interesting Advanced Query 2 - Results 20*/
/* Counts the number of patients and what type of appointments they have.*/
SELECT COUNT(DISTINCT Health_Card_Number), Type_Of_Appointment as "Type of Appointment"
FROM Appointment
GROUP BY Type_Of_Appointment;

/*Interesting Advanced Query 3 - Results 21*/
/* Counts the number of patients and what blood group they have.*/
SELECT COUNT(Health_Card_Number), Blood_Group as "Blood_Group"
FROM Patient_Records
GROUP BY Blood_Group;

/*Interesting Advanced Query 4 - Results 22*/
/*Shows patients name and health card number who do not have insurance company name as Manulife.*/
SELECT p.Health_Card_Number as "Health Card Number", Person_Name as "Person Name", Company_Name as "Company Name"
FROM Patient p, Insured_By i, Insurance_Company ic
WHERE   p.Health_Card_Number = i.Health_Card_Number
        AND i.Insurance_ID = ic.Insurance_ID
        AND Company_Name NOT IN
        (SELECT Company_Name
        FROM Insurance_Company
        WHERE Company_Name = 'Manulife');

/*Interesting Advanced Query 5 - Results 23*/
/*Shows the patients health card numbers if they either took laxatives or calcium carbonate in the past.*/
(SELECT pr.Health_Card_Number, Medication_History   
FROM Patient_Records pr
WHERE EXISTS(SELECT Medication_History
             FROM Patient_Records 
             WHERE pr.Medication_History = 'Laxatives') 
UNION
SELECT pr.Health_Card_Number, Medication_History  
FROM Patient_Records pr
WHERE EXISTS(SELECT Medication_History
             FROM Patient_Records 
             WHERE pr.Medication_History = 'Calcium Carbonate')
);