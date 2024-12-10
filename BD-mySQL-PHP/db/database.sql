

CREATE DATABASE GestionEventBde;
CREATE TABLE MembreBDE(
   ID_Membre INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(50),
   Dated_adhesion DATE,
   PRIMARY KEY(ID_Membre),
   FOREIGN KEY(ID_Bde),
   FOREIGN KEY(ID_Role)

);

CREATE TABLE Roles(
   ID_Role INT,
   nmbr_role INT,
   Statut VARCHAR,
   PRIMARY KEY(ID_Role)
);

CREATE TABLE Event(
   ID_Event INT,
   nom_event VARCHAR(50),
   description VARCHAR(10000),
   date_ DATETIME,
   local VARCHAR(100),
   budget DOUBLE,
   mbr_bde_respo INT,
   PRIMARY KEY(ID_Event)
);

CREATE TABLE Sponsor(
   ID_Sponsor INT,
   nom_du_spon VARCHAR(50),
   numero VARCHAR(50),
   email VARCHAR(50),
   Montant_sponsorise DOUBLE,
   PRIMARY KEY(ID_Sponsor)
);

CREATE TABLE Participent(
   ID_Participent INT,
   Nom VARCHAR(300),
   Prenom VARCHAR(100),
   Email VARCHAR(400),
   Statut VARCHAR(100),
   PRIMARY KEY(ID_Participent)
);

CREATE TABLE BDE(
   ID_Bde INT,
   Nom_du_bde VARCHAR(100),
   nmbr INT, 
   Email VARCHAR(400),
   num VARCHAR(100),
   PRIMARY KEY(ID_Bde)
);

CREATE TABLE Ecole(
   ID_Ecole INT,
   Nom_ecol VARCHAR(300),
   Email VARCHAR(400),
   localisation VARCHAR(400),
   date_creation DATE,
   PRIMARY KEY(ID_Ecole),
   FOREIGN KEY(ID_Bde)
);

CREATE TABLE Participer(
   ID_Participent INT,
   ID_Event INT,
   PRIMARY KEY(ID_Event, ID_Participent),
   FOREIGN KEY(ID_Participent) REFERENCES Participent(ID_Participent),
   FOREIGN KEY(ID_Event) REFERENCES Event(ID_Event)
);

CREATE TABLE Responsable(
   ID_Membre INT,
   ID_Event INT,
   PRIMARY KEY(ID_Event, ID_Membre),
   FOREIGN KEY(ID_Event) REFERENCES Event(ID_Event),
   FOREIGN KEY(ID_Membre) REFERENCES MembreBDE(ID_Membre)
);

CREATE TABLE Sponsorer(
   ID_Sponsor INT,
   ID_Event INT,
   PRIMARY KEY(ID_Event, ID_Sponsor),
   FOREIGN KEY(ID_Event) REFERENCES Event(id_evenement),
   FOREIGN KEY(ID_Sponsor) REFERENCES Sponsor(ID_Sponsor)
);

CREATE TABLE Spon_Event(
   ID_Sponsor INT,
   ID_Event INT,
   list_event_spon VARCHAR(1000),
   PRIMARY KEY(ID_Event, ID_Sponsor),
   FOREIGN KEY(ID_Event) REFERENCES Event(id_evenement),
   FOREIGN KEY(ID_Sponsor) REFERENCES Sponsor(ID_Sponsor)
);
