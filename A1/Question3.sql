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
INSERT INTO Suppliers VALUES(3, "Green Supplier", "2 Rainbow Road");
INSERT INTO Suppliers VALUES(4, "Everything Supplier", "777 Wallstreet");

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

-- ii

-- iii

-- iv

-- v

-- vi

-- vii

-- viii

-- ix

-- x

-- xi

-- xii
