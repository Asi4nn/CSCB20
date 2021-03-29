DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Feedback;

CREATE TABLE IF NOT EXISTS Users(
    id        INTEGER PRIMARY KEY,
    name      TEXT,
    username  TEXT,
	password  TEXT,
	email     TEXT,
	usertype  TEXT
);

CREATE TABLE IF NOT EXISTS Marks(
    id              INTEGER,
    name            TEXT,
    A1 mark         INTEGER,
	A2 mark         INTEGER,
	A3 mark         INTEGER,
	final exam mark INTEGER,
    username        TEXT
);

CREATE TABLE IF NOT EXISTS Feedback(
    id   INTEGER,
    q1   TEXT,
    q2   TEXT,
	q3   TEXT,
	q4   TEXT
);






INSERT INTO Users VALUES(1001, "instr1", "instructor1",	"instructor1", "instructor1@gmail.com", "instructor");
INSERT INTO Users VALUES(1002, "instr2", "instructor2", "instructor2", "instructor2@gmail.com", "instructor");
INSERT INTO Users VALUES(1003,	"instr3", "instructor3", "instructor3",	"instructor3@gmail.com", "instructor");
INSERT INTO Users VALUES(2001,	"stud1", "student1", "student1", "student1@gmail.com", "student");
INSERT INTO Users VALUES(2002,	"stud2", "student2", "student2", "student2@gmail.com", "student");
INSERT INTO Users VALUES(2003,	"stud3", "student3", "student3", "student3@gmail.com", "student");
INSERT INTO Users VALUES(2004,	"stud4", "student4", "student4", "student4@gmail.com", "student");
INSERT INTO Users VALUES(2005,	"stud5", "student5", "student5", "student5@gmail.com", "student");
INSERT INTO Users VALUES(2006,	"stud6", "student6", "student6", "student6@gmail.com", "student");
INSERT INTO Users VALUES(2007,	"stud7", "student7", "student7", "student7@gmail.com", "student");

INSERT INTO Marks VALUES(2001,	"stud1", 20, 21, 24, 88, "student1");
INSERT INTO Marks VALUES(2002,	"stud2", 25, 28, 27, 82, "student2");
INSERT INTO Marks VALUES(2003,	"stud3", 22, 29, 24, 89, "student3");
INSERT INTO Marks VALUES(2004,	"stud4", 28, 27, 27, 87, "student4");
INSERT INTO Marks VALUES(2005,	"stud5", 21, 29, 26, 90, "student5");
INSERT INTO Marks VALUES(2006,	"stud6", 28, 25, 20, 98, "student6");
INSERT INTO Marks VALUES(2007,	"stud7", 28, 26, 23, 91, "student7");

INSERT INTO Feedback VALUES(1001,	"teaching feeedback1", "improve teaching1", "lab feedback1", "improve lab1");
INSERT INTO Feedback VALUES(1003,	"teaching feeedback2", "improve teaching2", "lab feedback2", "improve lab2");
INSERT INTO Feedback VALUES(1002,	"teaching feeedback3", "improve teaching3", "lab feedback3", "improve lab3");
