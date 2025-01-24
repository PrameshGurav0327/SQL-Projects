-- ====================================== Here Is Our DataBase ======================================== Section A ======

CREATE DATABASE Chemistry_Laboratory_Management;

DROP DATABASE Chemistry_Laboratory_Management;

USE Chemistry_Laboratory_Management;

-- ======================================== DataBase Section End ==========================================

-- =============================== TABLE 1 ====================================================== Section B

CREATE TABLE Equipment (
equipment_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
name VARCHAR(50),
type VARCHAR(70),
availability_status VARCHAR(50) NOT NULL, 
Location VARCHAR(100), 
Purchase date NOT NULL, 
Equipment_condition VARCHAR(100))
;

DESC Equipment;

DROP TABLE Equipment;


INSERT INTO Equipment (equipment_id, name , type,  availability_status, Location, Purchase, Equipment_condition)
VALUES (1, "Bunsen Burner", "Heating Equipment", "Available", "Lab A-General", "2022-02-15", "Good"),
(2, "Analytical Balance", "General Laboratory Tools", "IN USE", "LAB B-Weighing", "2021-12-10", "Excellent"),
(3, "Fume Hood", "Protective And Safety", "Available","Lab C-Safty","2020-03-20","Good"),
(4, "Rotary Evaporator","Analytical Instrument","Available","Lab D-Analysis","2023-01-10","Good"),
(5, "Glass Reactor","General Laboratory Tool","Available","Lab E-Synthesis","2022-06-15","Good"),
(6, "pH Meter","Analytical Instrument","Available","Lab F-Chemistry","2023-07-01","Excellent"),
(7, "Hot Plate","Heating", "IN USE","Lab G-Processing","2021-04-18","Good"),
(8, "Distillation Apparatus", "Analytical Instrument","Available","Lab h-Chemistry","2022-09-12","Excellent"),
(9, "Magnetic Stirrer", "General Laboratory Tools","Available","Lab I-Mixing","2023-02-25","Execellent"),
(10, "UV-VIS Spectrometer", "Analytical Instrument","Available","Lab J-Analysis","2021-11-15","Good"),
(11, "Titration Setup", "Analytical","IN USE","Lab K-Chemistry","2022-03-10","Good"),
(12, "Vaccume Pump", "General Laboratory Tools","Available","Lab L-Chemistry","2020-08-22","Fair"),
(13, "Melting Point Apparatus", "Testing And Dignostic Tool","Available","Lab M-Analysis","2023-05-20","Excellent"),
(14, "Soxhlet Extractor", "General Laboratory Tool","Available","Lab N-Synthesis","2022-10-15","Good"),
(15, "Calorimeter", "Analytical Instrument","Available","Lab O-Thermodynamics","2021-06-30","Good")
;

ALTER TABLE Equipment
ADD COLUMN EQ_USE_LOCATION VARCHAR(50) AFTER Equipment_condition;

SELECT DISTINCT type FROM Equipment
WHERE equipment_id = (1,5);

UPDATE Equipment
SET  EQ_USE_LOCATION = "Lab K - Chemistry"
WHERE equipment_id = 11;

DELETE FROM Equipment
WHERE  EQ_USE_LOCATION = "Lab B - Weighing";

SELECT name , type,  availability_status
FROM Equipment
LIMIT 5;


DELETE FROM Equipment
WHERE equipment_id = 1;

SELECT * FROM Equipment;

SELECT e.name, e.availability_status, ei.Staff_ID, ei.Lab_Location
FROM Equipment e
JOIN Equipment_in_Use ei ON e.equipment_id = ei.equipment_id;

SELECT e.name, ei.Staff_ID
FROM Equipment e
RIGHT JOIN Equipment_in_Use ei ON e.equipment_id = ei.equipment_id;

SELECT e.name, ei.Staff_ID
FROM Equipment e
LEFT JOIN Equipment_in_Use ei ON e.equipment_id = ei.equipment_id;

-- ===================================== Table 1 End ========================================

-- =================================== Table 2 ======================================================== Section 3 ==========

DROP TABLE Staff_Details;

CREATE TABLE Staff_Details (
Staff_ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
Staff_Member VARCHAR(70),
Role_ VARCHAR(200) NOT NULL,
Contact_Email VARCHAR(50) NOT NULL)
-- Contact_No VARCHAR(50) NOT NULL)
;

DESC Staff_Details;

INSERT INTO Staff_Details(Staff_ID,	Staff_Member, Role_,Contact_Email)
VALUES 
(1, "Dr. Emma Carter", "Laboratory Manager", "emma.carter12@gmail.com"),
(2, "John Smith", "Chemistry Technician", "john.smith123@gmail.com"),
(3, "Sarah Johnson", "Safety Officer", "sarah.johnson1234@gmail.com"),
(4, "Michael Brown", "Research Analyst","michael.brown321@gmail.com"),
(5,  "Emily Davis", "Inventory Manager", "emily.davis21@gmail.com");

SELECT * FROM Staff_Details;

SELECT Staff_Member, Role_
FROM Staff_Details
LIMIT 2;

UPDATE Staff_Details
SET Contact_Email="emma.c12@gmail.com"
WHERE Staff_ID = 1;

-- =================================== Table 2 End ========================================================


-- ============================ Table 3 =================================

DROP TABLE Equipment_in_Use;

CREATE TABLE Equipment_in_Use (
    equipment_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR(50),
    Staff_ID INT,
    Lab_Location VARCHAR(70),
    Start_Date DATE NOT NULL,
    -- Expected_End_Date DATE,
    FOREIGN KEY (equipment_id) REFERENCES Equipment (equipment_id),
    FOREIGN KEY (Staff_ID) REFERENCES Staff_Details (Staff_ID)
);

DESC Equipment_in_Use;


INSERT INTO Equipment_in_Use (
    equipment_id, name, Staff_ID, Lab_Location, Start_Date
)	
VALUES
    (2, "Analytical Balance", 2, "Lab B - Weighing", "2023-12-01"), -- "2023-12-05"
    (7, "Hot Plate", 3, "Lab G - Processing", "2023-11-25"), --  "2023-12-10"
    (11, "Spectrophotometer", 4, "Lab H - Analysis", "2023-12-03"); -- "2023-12-12"

DELETE FROM Equipment_in_Use
WHERE equipment_id = 11;

SELECT * FROM Equipment_in_Use;

SELECT equipment_id, name, Staff_ID, Lab_Location, Start_Date 
FROM Equipment_in_Use
LIMIT 1; 

ALTER TABLE Equipment_in_Use
ADD COLUMN Expected_End_Date DATE AFTER Start_Date;

UPDATE Equipment_in_Use
SET Expected_End_Date = '2023-12-05'
WHERE equipment_id = 2; 

UPDATE Equipment_in_Use
SET Expected_End_Date = '2023-12-10'
WHERE equipment_id = 7;

UPDATE Equipment_in_Use
SET Expected_End_Date = '2023-12-12'
WHERE equipment_id = 11; 


-- ============================ Table 3 End =================================

--  ==================================== Table 4 ============================================ Section C ========
DROP TABLE Inventory_Table;

CREATE TABLE Inventory_Table(
Inventory_ID INT PRIMARY KEY NOT NULL,
Name VARCHAR(50),
Type VARCHAR(75),
Quantity VARCHAR(70),
Storage_Location VARCHAR(100),
Last_Updated DATE NOT NULL
);

DESC Inventory_Table;

INSERT INTO Inventory_Table (Inventory_ID, Name, Type, Quantity, Storage_Location, Last_Updated)
VALUES(1,"Test Tube","Glassware","200","Lab A-Glass Cabinet","2023-12-10"),
(2,"Beakers","Glassware","150","Lab B-General Shelf","2023-11-28"),
(3,"Graduated Cylinders","Glassware","100","Lab C- Measurement Area","2023-11-25"),
(4,"Pipettes","Tools","300","Lab D-Storage Room","2023-12-01"),
(5,"Sodium Hydroxide (NaOH)","Chemicals","20 kg","Lab E- Chemical","2023-11-30"),
(6,"Hydrochloric Acid(HCL)","Chemicals","5 L","Lab F- Acid Cabinet","2023-12-05"),
(7,"Safety Gloves","Safety Equipment","200 pairs","Lab G- Safety Zone","2023-12-09"),
(8,"Lab Coats","Safety Equipment","50","Lab H- Locker Room","2023-12-08"),
(9,"Distilled Water","Chemical","20 L","Lab I- Water Storage","2023-12-07"),
(10,"Ethanol","Chemical","5 L","Lab J-Flammable Cabinet","2023-12-06");

SELECT Name,Quantity,Last_Updated FROM Inventory_Table
WHERE  Inventory_ID=9;

SELECT * FROM Inventory_Table;

SELECT Inventory_ID, Name, Type, Quantity FROM Inventory_Table
LIMIT 5;


SELECT Name, Type, Quantity, Storage_Location FROM Inventory_Table
LIMIT 3,7;

UPDATE  Inventory_Table
SET Quantity =  (78 - 28)
WHERE Inventory_ID = 10;



-- ================================Table 4 End ====================================================

-- ====================================== Table 5 ============================================================ Section D ===========

CREATE TABLE Test_Records (
Test_ID  INT PRIMARY KEY NOT NULL,
Sample_ID VARCHAR(50),
Test_Type VARCHAR(150),
Result VARCHAR(100),
Date DATE NOT NULL,
Inventory_ID INT,
FOREIGN KEY (Inventory_ID) REFERENCES Inventory_Table(Inventory_ID)
);

DESC Test_Records;

DROP TABLE Test_Records;


INSERT INTO Test_Records (Test_ID, Sample_ID, Test_Type, Result, Date,Inventory_ID)
VALUES 
(1, "S-001", "Acid-Base Titration", "Successful", "2023-12-01",5), -- NaOH
(2, "S-002", "Solubility Test", "Pass", "2023-11-28",9),          -- Distilled Water
(3, "S-003", "Reaction Kinetics", "Completed", "2023-11-30",10), -- Ethanol
(4, "S-004", "pH Measurement", "Neutral (7)", "2023-12-05",6),   -- HCL
(5, "S-005", "Boiling Point Analysis", "100°C", "2023-12-07",NULL); -- Distilled Water


SELECT * FROM Test_Records;

SELECT * FROM Test_Records
LIMIT 2;

-- ============================Table 5 End ====================================



-- ============== To see all Databases ================

SHOW DATABASES;

USE Chemistry_Laboratory_Management;

-- ============================ PROCEDURE ====================================

CREATE VIEW EquipmentView AS
SELECT 
    equipment_id,
    name AS equipment_name,
    type AS equipment_type,
    availability_status,
    Location AS storage_location,
    Purchase AS purchase_date,
    Equipment_condition
FROM 
    Equipment;
    
    
SELECT * FROM EquipmentView;


DROP VIEW EquipmentView;