

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

INSERT INTO Pilots (Pilote_Nom, Pilote_Adresse) 
VALUES 
('John Smith', '123 Avenue des Champs-Élysées, Paris'),
('Michael Johnson', '456 Broadway, New York'),
('Ahmed Hassan', '789 Sheikh Zayed Road, Dubai'),
('Hans Müller', '321 Friedrichstraße, Berlin'),
('Takeshi Yamamoto', '654 Shibuya Street, Tokyo');

INSERT INTO Vols (Ville_Depart, Ville_Arrive, Heur_Depart, Heur_Arrive, Pilote_ID, Avion_ID, Vol_Identification)
VALUES 
('Paris', 'London', '2025-02-16 08:00:00', '2025-02-16 09:30:00', 1, 1, 'IT100'),
('New York', 'Toronto', '2025-02-16 10:00:00', '2025-02-16 11:30:00', 2, 2, 'IT104'),
('Dubai', 'Cairo', '2025-02-17 12:00:00', '2025-02-17 14:30:00', 3, 3, 'IT100'),
('Berlin', 'Madrid', '2025-02-18 15:00:00', '2025-02-18 17:30:00', 4, 4, 'IT104'),
('Tokyo', 'Seoul', '2025-02-19 18:00:00', '2025-02-19 19:30:00', 5, 5, 'IT100');


-- Afficher le nom et l’adresse des pilotes assurant les vols IT100 et IT104

SELECT 
    Pilots.Pilote_Nom, 
    Pilots.Pilote_Adresse,
    Vols.Vol_Identification,
    Vols.Ville_Depart,
    Vols.Ville_Arrive

FROM Pilots
    INNER JOIN Vols
    ON Pilots.id = Vols.Pilote_ID
    WHERE Vols.Vol_Identification = "IT100" or Vols.Vol_Identification = "IT104";

SELECT 
    Pilots.Pilote_ID, 
    Pilots.Pilote_Nom 
FROM Pilots
    INNER JOIN Vols
    ON Pilots.Pilote_ID = Vols.Pilote_ID;

SELECT 
    Pilots.Pilote_ID, 
    Pilots.Pilote_Nom,
    Vols.Vol_Identification
FROM Pilots
    LEFT JOIN Vols
    ON Pilots.Pilote_ID = Vols.Pilote_ID
    WHERE Vols.Vol_Identification IS NOT NULL;

SELECT
    Pilots.Pilote_Nom, 
    Avions.Avion_Nom
FROM Pilots
INNER JOIN Vols
    ON Pilots.Pilote_ID = Vols.Pilote_ID
INNER JOIN Avions
    ON Avions.Avion_ID = Vols.Avion_ID
WHERE Avions.Avion_Nom = "AIRBUS";