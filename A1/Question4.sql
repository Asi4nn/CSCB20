DROP TABLE IF EXISTS Flights;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS Certified;
DROP TABLE IF EXISTS Employees;

CREATE TABLE IF NOT EXISTS Flights(
    flno        INTEGER PRIMARY KEY,
    [from]      TEXT,
    [to]        TEXT,
	distance    INTEGER,
	departs     TIME,
	arrives     TIME
);

CREATE TABLE IF NOT EXISTS Aircraft(
    aid             INTEGER PRIMARY KEY,
    aname           TEXT,
    cruisingrange   INTEGER
);

CREATE TABLE IF NOT EXISTS Certified(
    eid     INTEGER,
    aid     INTEGER,
    PRIMARY KEY("eid", "aid")
);

CREATE TABLE IF NOT EXISTS Employees(
    eid     INTEGER PRIMARY KEY,
    ename   TEXT,
    salary  INTEGER
);

INSERT INTO Flights VALUES(12, "bonn", "madras", 190, "2:30:00", "4:45:00");
INSERT INTO Flights VALUES(13, "ottawa", "montreal", 2000, "3:45:00", "5:50:00");
INSERT INTO Flights VALUES(14, "bhutan", "china", 3890, "2:00:00", "6:00:00");
INSERT INTO Flights VALUES(15, "india", "pakistan", 4079, "3:50:00", "1:00:00");
INSERT INTO Flights VALUES(16, "delhi", "dubai", 700, "4:15:00", "6:30:00");

INSERT INTO Aircraft VALUES(9487, "boeing", 7484);
INSERT INTO Aircraft VALUES(9058, "boeing", 8487);
INSERT INTO Aircraft VALUES(985, "jet", 4399);
INSERT INTO Aircraft VALUES(744, "jet", 474);
INSERT INTO Aircraft VALUES(1876, "boeing", 846);

INSERT INTO Certified VALUES(9487, 7484);
INSERT INTO Certified VALUES(9058, 8487);
INSERT INTO Certified VALUES(985, 4399);
INSERT INTO Certified VALUES(744, 474);
INSERT INTO Certified VALUES(1876, 846);

INSERT INTO Employees VALUES(9487, "john", 44783);
INSERT INTO Employees VALUES(9058, "dave", 48373);
INSERT INTO Employees VALUES(985, "maria",  7899);
INSERT INTO Employees VALUES(744, "gigi", 88474);
INSERT INTO Employees VALUES(1876, "ibu", 30846);

-- i

--ii
SELECT ename FROM Aircraft, Certified, Employees 
WHERE Aircraft.aid=Certified.aid 
AND Employees.eid = Certified.eid AND aname=’boeing’

--iii

--iv
SELECT Flights.flno FROM Employees, Aircraft, Certified, Flights 
WHERE Employees.salary > 100,000 
AND Flights.distance < Aircraft.cruisingrange 
AND Certified.aid = Aircraft.aid AND Certified.eid = Employees.eid
--v
--vi
SELECT Employees.eid 
FROM Employees 
WHERE Employees.salary = (SELECT MAX Employees1.salary FROM Employees1)

--vii

--viii

--ix

--x
SELECT SUM (Employees.salary) FROM Employees