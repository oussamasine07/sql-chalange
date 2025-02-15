

CREATE DATABASE air_plain;

USE air_plain;

CREATE TABLE Avions (
    Avion_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Avion_Nom VARCHAR(255) NOT NULL,
    Avion_Capacite INT NOT NULL,
    Avion_Localite VARCHAR(255) NOT NULL
);


CREATE TABLE Pilots (
    Pilote_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Pilote_Nom VARCHAR(255) NOT NULL,
    Pilote_Adresse VARCHAR(255) NOT NULL
);


CREATE TABLE Vols (
    Vol_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Ville_Depart VARCHAR(255) NOT NULL,
    Ville_Arrive VARCHAR(255) NOT NULL,
    Heur_Depart TIMESTAMP DEFAULT NOW(),
    Heur_Arrive TIMESTAMP DEFAULT NOW(),
    Pilote_ID INT NOT NULL,
    Avion_ID INT NOT NULL,
    FOREIGN KEY (Pilote_ID) REFERENCES Pilots(Pilote_ID),
    FOREIGN KEY (Avion_ID) REFERENCES Avions(Avion_ID)
);

INSERT INTO Avions 
    (Avion_Nom, Avion_Capacite, Avion_Localite)
VALUES 
    ("AIRBUS", 300, "BENI MALLAL"),
    ("B737",250,"CASA"),
    ("B737",150,"RABAT");

SELECT * FROM Avions;
SELECT * FROM Avions ORDER BY Avion_Nom DESC;
SELECT 
    Avion_Nom,
    Avion_Capacite 
FROM 
    Avions;

SELECT DISTINCT 
    Avion_Localite 
FROM Avions;

SELECT * FROM Avions
WHERE Avion_Localite = "RABAT" OR Avion_Localite = "CASA";

UPDATE Avions 
    SET Avion_Capacite = 220
WHERE Avion_ID = 2;

DELETE FROM Avions 
WHERE Avion_Capacite < 200;

SELECT 
    MAX(Avion_Capacite) AS "Capacite maximal",
    MIN(Avion_Capacite) AS "Capacite minimal",
    AVG(Avion_Capacite) AS "Capacite Moyenne"
FROM Avions

SELECT * FROM Avions 
WHERE Avion_Capacite = (
    SELECT 
        MIN(Avion_Capacite)
    FROM Avions
);

SELECT * FROM Avions
WHERE Avion_Capacite > (
    SELECT 
        AVG(Avion_Capacite)
    FROM Avions
);

ALTER TABLE Vols 
ADD COLUMN Vol_Identification VARCHAR(255) not null;
