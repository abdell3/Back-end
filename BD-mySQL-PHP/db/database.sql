

CREATE DATABASE GestionEventBde;
CREATE TABLE Membre(
   ID_Membre_ INT,
   nom VARCHAR(150),
   prenom VARCHAR(150),
   email VARCHAR(150),
   Role_ VARCHAR(150),
   Datedadhesion DATE,
   PRIMARY KEY(ID_Membre_)
);

CREATE TABLE Evenement(
   id_evenement INT,
   nom_ VARCHAR(150),
   description VARCHAR(750),
   date_ DATETIME,
   lieu VARCHAR(50),
   budget_ DOUBLE,
   membresBde INT,
   PRIMARY KEY(id_evenement)
);

CREATE TABLE Sponsors(
   id_sponsors INT,
   nom_ VARCHAR(150),
   contact_ VARCHAR(150),
   Montantsponsorise DOUBLE,
   Telecontact VARCHAR(50),
   PRIMARY KEY(id_sponsors)
);

CREATE TABLE Participant(
   ID_Participant_ INT,
   Nom_ VARCHAR(250),
   Email_ VARCHAR(250),
   Statut_ VARCHAR(50),
   Prenom_ VARCHAR(50),
   PRIMARY KEY(ID_Participant_)
);

CREATE TABLE organiser(
   ID_Membre_ INT,
   id_evenement INT,
   PRIMARY KEY(ID_Membre_, id_evenement),
   FOREIGN KEY(ID_Membre_) REFERENCES Membre(ID_Membre_),
   FOREIGN KEY(id_evenement) REFERENCES Evenement(id_evenement)
);

CREATE TABLE Soutien_(
   id_evenement INT,
   id_sponsors INT,
   PRIMARY KEY(id_evenement, id_sponsors),
   FOREIGN KEY(id_evenement) REFERENCES Evenement(id_evenement),
   FOREIGN KEY(id_sponsors) REFERENCES Sponsors(id_sponsors)
);

CREATE TABLE sinscrir(
   id_evenement INT,
   ID_Participant_ INT,
   PRIMARY KEY(id_evenement, ID_Participant_),
   FOREIGN KEY(id_evenement) REFERENCES Evenement(id_evenement),
   FOREIGN KEY(ID_Participant_) REFERENCES Participant(ID_Participant_)
);
