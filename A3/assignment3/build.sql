DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Feedback;

CREATE TABLE IF NOT EXISTS Users(
    username  TEXT PRIMARY KEY,
    name      TEXT,
    password  TEXT,
	email     TEXT,
	usertype  TEXT
);

CREATE TABLE IF NOT EXISTS Marks(
    username     TEXT PRIMARY KEY,
    name         TEXT,
    A1           INTEGER,
	A2           INTEGER,
	A3           INTEGER,
	final        INTEGER,
    A1_reason    TEXT,
    A2_reason    TEXT,
    A3_reason    TEXT,
    final_reason TEXT
);

CREATE TABLE IF NOT EXISTS Feedback(
    username   TEXT,
    q1         TEXT,
    q2         TEXT,
	q3         TEXT,
	q4         TEXT
);


INSERT INTO Users VALUES("instructor1", "instr1", "instructor1", "instructor1@gmail.com", "instructor");
INSERT INTO Users VALUES("instructor2", "instr2", "instructor2", "instructor2@gmail.com", "instructor");
INSERT INTO Users VALUES("instructor3", "instr3", "instructor3", "instructor3@gmail.com", "instructor");
INSERT INTO Users VALUES("student1", "stud1", "student1", "student1@gmail.com", "student");
INSERT INTO Users VALUES("student2", "stud2", "student2", "student2@gmail.com", "student");
INSERT INTO Users VALUES("student3", "stud3", "student3", "student3@gmail.com", "student");
INSERT INTO Users VALUES("student4", "stud4", "student4", "student4@gmail.com", "student");
INSERT INTO Users VALUES("student5", "stud5", "student5", "student5@gmail.com", "student");
INSERT INTO Users VALUES("student6", "stud6", "student6", "student6@gmail.com", "student");
INSERT INTO Users VALUES("student7", "stud7", "student7", "student7@gmail.com", "student");

INSERT INTO Marks VALUES("student1", "stud1", 20, 21, 24, 88, "error in grading part1", NULL, NULL, NULL);
INSERT INTO Marks VALUES("student2", "stud2", 25, 28, 27, 82, NULL, NULL, NULL, NULL);
INSERT INTO Marks VALUES("student3", "stud3", 22, 29, 24, 89, NULL, "please regarde part2", NULL, NULL);
INSERT INTO Marks VALUES("student4", "stud4", 28, 27, 27, 87, NULL, NULL, NULL, NULL);
INSERT INTO Marks VALUES("student5", "stud5", 21, 29, 26, 90, NULL, NULL, "please regrade part2", NULL);
INSERT INTO Marks VALUES("student6", "stud6", 28, 25, 20, 98, NULL, NULL, NULL, NULL);
INSERT INTO Marks VALUES("student7", "stud7", 28, 26, 23, 91, NULL, NULL, "part1 question incorrect", NULL);

INSERT INTO Feedback VALUES("instructor1", "teaching feeedback1", "improve teaching1", "lab feedback1", "improve lab1");
INSERT INTO Feedback VALUES("instructor2",	"teaching feeedback2", "improve teaching2", "lab feedback2", "improve lab2");
INSERT INTO Feedback VALUES("instructor3",	"teaching feeedback3", "improve teaching3", "lab feedback3", "improve lab3");
