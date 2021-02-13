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

INSERT INTO Aircraft VALUES(1, "boeing", 7484);
INSERT INTO Aircraft VALUES(2, "boeing", 8487);
INSERT INTO Aircraft VALUES(3, "jet", 4399);
INSERT INTO Aircraft VALUES(4, "jet", 474);
INSERT INTO Aircraft VALUES(5, "boeing", 846);

INSERT INTO Certified VALUES(9487, 1);
INSERT INTO Certified VALUES(9058, 2);
INSERT INTO Certified VALUES(985, 3);
INSERT INTO Certified VALUES(744, 4);
INSERT INTO Certified VALUES(1876, 5);

INSERT INTO Employees VALUES(9487, "john", 44783);
INSERT INTO Employees VALUES(9058, "dave", 48373);
INSERT INTO Employees VALUES(985, "maria",  7899);
INSERT INTO Employees VALUES(744, "gigi", 100474);
INSERT INTO Employees VALUES(1876, "ibu", 130846);

-- i

SELECT DISTINCT eid
FROM
    Aircraft
    NATURAL JOIN Certified
    NATURAL JOIN Employees
WHERE aname='boeing';

--ii

SELECT ename FROM Aircraft, Certified, Employees 
WHERE Aircraft.aid=Certified.aid 
AND Employees.eid = Certified.eid AND aname='boeing';

--iii

SELECT aid
FROM
    Aircraft
    CROSS JOIN (
        SELECT *
        FROM Flights
        WHERE [from]='bonn' and [to]='madras'
    )
WHERE cruisingrange >= distance;

--iv

SELECT Flights.flno
FROM 
    Employees
    NATURAL JOIN Aircraft
    NATURAL JOIN Certified
    NATURAL JOIN Flights 
WHERE Employees.salary > 100000
AND Flights.distance < Aircraft.cruisingrange 
AND Certified.aid = Aircraft.aid AND Certified.eid = Employees.eid;

--v

SELECT ename
FROM
    Employees
    NATURAL JOIN Certified
    NATURAL JOIN Aircraft
WHERE cruisingrange > 3000
EXCEPT
SELECT ename
FROM
    Employees
    NATURAL JOIN Certified
    NATURAL JOIN Aircraft
WHERE aname = 'boeing';

--vi

SELECT Employees.eid
FROM Employees 
WHERE Employees.salary = (SELECT MAX(Employees.salary) FROM Employees);

--vii

SELECT eid
FROM (
    SELECT eid, MAX(salary)
    FROM Employees
    WHERE salary < (SELECT MAX(salary) FROM Employees)
);
    
--viii

CREATE TEMPORARY VIEW Temp(eid, aircraftcount)
AS
    SELECT Certified.eid, COUNT (Certified.aid) 
FROM Certified 
GROUP BY Certified.eid;

SELECT Temp.eid 
FROM Temp
WHERE Temp.aircraftcount = (SELECT MAX(Temp.aircraftcount) FROM Temp);

--ix

SELECT eid
FROM Employees
NATURAL JOIN Certified
GROUP BY eid
HAVING COUNT(*) = 3;

--x

SELECT SUM (Employees.salary) FROM Employees;