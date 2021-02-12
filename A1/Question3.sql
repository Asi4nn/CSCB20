-- create the database

DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS Parts;
DROP TABLE IF EXISTS Catalog;

CREATE TABLE IF NOT EXISTS Suppliers(
    sid     INTEGER PRIMARY KEY,
    sname   TEXT,
    address TEXT
);

CREATE TABLE IF NOT EXISTS Parts(
    pid     INTEGER PRIMARY KEY,
    pname   TEXT,
    color   TEXT
);

CREATE TABLE IF NOT EXISTS Catalog(
    sid     INTEGER,
    pid     INTEGER,
    cost    REAL,
    PRIMARY KEY("sid", "pid")
);

INSERT INTO Suppliers VALUES(0, "Wheel Supplier", "123 Industrial Dr");
INSERT INTO Suppliers VALUES(1, "Wrench Supplier", "321 Industrial Dr");
INSERT INTO Suppliers VALUES(2, "Red Supplier", "1 Rainbow Road");
INSERT INTO Suppliers VALUES(3, "Green Supplier", "1065 Military Trail");
INSERT INTO Suppliers VALUES(4, "Canada Suppliers", "777 Wallstreet");

INSERT INTO Parts VALUES(0, "Red Wheel", "red");
INSERT INTO Parts VALUES(1, "Green Wheel", "green");
INSERT INTO Parts VALUES(2, "Yellow Wheel", "yellow");
INSERT INTO Parts VALUES(3, "Red Wrench", "red");
INSERT INTO Parts VALUES(4, "Green Wrench", "green");
INSERT INTO Parts VALUES(5, "Yellow Wrench", "yellow");

INSERT INTO Catalog VALUES(0, 0, 20);
INSERT INTO Catalog VALUES(0, 1, 20.5);
INSERT INTO Catalog VALUES(0, 2, 21);
INSERT INTO Catalog VALUES(1, 3, 50);
INSERT INTO Catalog VALUES(1, 4, 50.5);
INSERT INTO Catalog VALUES(1, 5, 51);
INSERT INTO Catalog VALUES(2, 0, 22);
INSERT INTO Catalog VALUES(2, 3, 23);
INSERT INTO Catalog VALUES(3, 1, 22);
INSERT INTO Catalog VALUES(3, 4, 23);
INSERT INTO Catalog VALUES(4, 0, 15);
INSERT INTO Catalog VALUES(4, 1, 15);
INSERT INTO Catalog VALUES(4, 2, 15);
INSERT INTO Catalog VALUES(4, 3, 40);
INSERT INTO Catalog VALUES(4, 4, 40);
INSERT INTO Catalog VALUES(4, 5, 40);

-- i

SELECT DISTINCT sname 
FROM 
    Parts NATURAL JOIN
    Catalog NATURAL JOIN
    Suppliers 
WHERE color = 'red';

-- ii
SELECT Suppliers.sid FROM Parts, Catalog WHERE color = ‘red’
    UNION
    SELECT Suppliers.sid FROM Parts, Catalog WHERE color = ‘green’

-- iii

SELECT DISTINCT sid
FROM 
    Parts NATURAL JOIN
    Catalog NATURAL JOIN
    Suppliers 
WHERE color = 'red' OR address = '1065 Military Trail';

-- iv
SELECT Suppliers.sid FROM Parts, Catalog WHERE color = ‘red’
    INTERSECT
    SELECT Suppliers.sid FROM Parts, Catalog WHERE color = ‘green’

-- v

SELECT sid
FROM 
    Parts NATURAL JOIN
    Catalog
WHERE pid IN (SELECT pid FROM Parts)
GROUP BY sid
HAVING COUNT(*) = (
    SELECT COUNT(*) FROM Parts
);

-- vi
SELECT Catalog.sid FROM Catalog 
WHERE NOT EXISTS (SELECT Parts.pid FROM Parts 
WHERE Parts.color=’red’ AND NOT EXISTS (SELECT Catalog2.sid FROM Catalog2 
WHERE Catalog2.sid=Catalog.sid AND Catalog2.pid=Parts.pid))

-- vii

SELECT sid
FROM 
    Parts
    NATURAL JOIN Catalog
WHERE pid IN (
    SELECT pid FROM Parts WHERE color='red'
)
GROUP BY sid
HAVING COUNT(*) = (
    SELECT COUNT(*) FROM Parts WHERE color='red'
)
UNION
SELECT sid
FROM 
    Parts
    NATURAL JOIN Catalog
WHERE pid IN (
    SELECT pid FROM Parts WHERE color='green'
)
GROUP BY sid
HAVING COUNT(*) = (
    SELECT COUNT(*) FROM Parts WHERE color='green'
);

-- viii
SELECT Catalog.sid FROM Catalog 
WHERE NOT EXISTS (SELECT Parts.pid FROM Parts WHERE Parts.color=’red’ 
AND NOT EXISTS (SELECT Catalog2.sid FROM Catalog2 WHERE Catalog2.sid=Catalog.sid AND Catalog2.pid=Parts.pid))
UNION
SELECT Catalog.sid FROM Catalog 
WHERE NOT EXISTS (SELECT Parts.pid FROM Parts WHERE Parts.color=’green’ 
AND NOT EXISTS (SELECT Catalog3.sid FROM Catalog3 WHERE Catalog3.sid=Catalog.sid AND Catalog3.pid=Parts.pid))

-- ix

CREATE TEMPORARY VIEW SPC(sid, pid, cost)
AS
    SELECT sid, pid, cost
FROM
    Parts
    NATURAL JOIN Catalog
    NATURAL JOIN Suppliers;

SELECT DISTINCT t1.sid, t2.sid
FROM
    SPC AS t1
    CROSS JOIN SPC AS t2
WHERE (t1.cost > t2.cost AND t1.pid = t2.pid);

-- x
SELECT Catalog.pid FROM Catalog 
WHERE EXISTS (SELECT Catalog2.sid FROM Catalog2 
WHERE Catalog2.sid != Catalog.sid AND Catalog2.pid = Catalog.pid)

-- xi

SELECT pid
FROM
    Parts
    NATURAL JOIN Catalog
    NATURAL JOIN Suppliers
WHERE 
    cost = (
        SELECT MAX(cost) 
        FROM (Parts 
                NATURAL JOIN Catalog 
                NATURAL JOIN Suppliers)
        WHERE sname="Canada Suppliers"
    );

-- xii
SELECT Catalog.pid FROM Catalog 
WHERE Catalog.cost<200 AND NOT EXISTS (SELECT Catalog2.pid FROM Catalog2 
WHERE Catalog2.pid=Catalog.pid AND Catalog2.sid=Suppliers.sid)