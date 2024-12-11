

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


INSERT INTO BDE (ID_Bde, Nom_du_bde, nmbr, Email, num) VALUES
(1, 'BDE 1', 120, 'contact@bde-centrale.com', '01 23 45 67 89'),
(2, 'BDE 2', 100, 'bde@polytech.com', '02 34 56 78 90'),
(3, 'BDE 3', 80, 'contact@bdeiut.org', '03 45 67 89 01');


ALTER TABLE BDE 
ADD CONSTRAINT unique_email_bde UNIQUE (Email);

ALTER TABLE BDE 
ADD CONSTRAINT chk_nmbr_positive CHECK (nmbr >= 0);



INSERT INTO Ecole (ID_Ecole, Nom_ecol, Email, localisation, date_creation, ID_Bde) VALUES
(1, 'YouCode', 'admin@YouCode.edu', 'Maroc', '2018-05-01', 1),
(2, '1337', 'contact@1337.fr', 'Maroc', '2020-01-01', 2),
(3, 'x', 'info@iutlyon.fr', 'Y', '2000-01-01', 3);


ALTER TABLE Ecole 
ADD CONSTRAINT fk_bde FOREIGN KEY (ID_Bde) REFERENCES BDE(ID_Bde);

ALTER TABLE Ecole 
ADD CONSTRAINT chk_date_creation CHECK (date_creation <= CURRENT_DATE);



INSERT INTO Roles (ID_Role, nmbr_role, Statut) VALUES
(1, 1, 'Président'),
(2, 2, 'Vice-président'),
(3, 3, 'Trésorier'),
(4, 4, 'Secrétaire'):
(5, 5, 'Membre actif');


ALTER TABLE Roles 
ADD CONSTRAINT chk_nmbr_role CHECK (nmbr_role > 0);

ALTER TABLE Roles 
ADD CONSTRAINT chk_statut CHECK (Statut <> '');


INSERT INTO MembreBDE (ID_Membre, nom, prenom, email, Dated_adhesion) VALUES
(1, 'ahmed', 'bobo', 'ahmed.bobo@email.com', '2022-09-01'),
(2, 'sara', 'sarita', 'sara.sarit@email.com', '2022-09-01'),
(3, 'said', 'saidi', 'said.saidi@email.com', '2022-09-01');


ALTER TABLE MembreBDE 
ADD CONSTRAINT unique_email_membre UNIQUE (email);

ALTER TABLE MembreBDE 
ADD CONSTRAINT chk_dated_adhesion CHECK (Dated_adhesion <= CURRENT_DATE);


INSERT INTO Event (ID_Event, nom_event, description, date_, local, budget, mbr_bde_respo) VALUES
(1, 'Soirée d_intégration', 'Soirée d_accueil pour les nouveaux membres.', '2024-01-20 20:00:00', 'YouSoufia', 5000, 1),
(2, 'Chante', 'Concert organisé avec des artistes locaux.', '2024-03-15 18:00:00', 'youssoufia', 7000, 2),
(3, 'Workshop', 'Atelier pour apprendre la programmation avec des professionnels.', '2024-02-10 10:00:00', 'YouCode', 2000, 3);


ALTER TABLE Event 
ADD CONSTRAINT chk_budget CHECK (budget >= 0);

ALTER TABLE Event 
ADD CONSTRAINT chk_date_future CHECK (date_ >= CURRENT_TIMESTAMP);



INSERT INTO Sponsor (ID_Sponsor, nom_du_spon, numero, email, Montant_sponsorise) VALUES
(1, 'Société Alpha', '0123456789', 'contact@alpha.com', 5000),
(2, 'TechWorld', '0987654321', 'hello@techworld.com', 7000),
(3, 'GreenEnergy', '1231231234', 'info@greenenergy.com', 3000);


ALTER TABLE Sponsor 
ADD CONSTRAINT chk_montant_positive CHECK (Montant_sponsorise >= 0);

ALTER TABLE Sponsor 
ADD CONSTRAINT unique_numero UNIQUE (numero);

ALTER TABLE Sponsor 
ADD CONSTRAINT unique_email_sponsor UNIQUE (email);


INSERT INTO Participent (ID_Participent, Nom, Prenom, Email, Statut) VALUES
(1, 'yassir', 'mahir', 'yassir.mahir@email.com', 'Étudiant'),
(2, 'zakariya', 'kardach', 'zakariya.kardach@email.com', 'Étudiant'),
(3, 'ilyas', 'tergui', 'ilyas.tergui@email.com', 'Invité');


ALTER TABLE Participent 
ADD CONSTRAINT unique_email_participent UNIQUE (Email);

ALTER TABLE Participent 
ADD CONSTRAINT chk_statut_participent CHECK (Statut <> '');


INSERT INTO Participer (ID_Participent, ID_Event) VALUES
(1, 1),
(2, 2),
(3, 1),
(3, 2);


ALTER TABLE Participer 
ADD CONSTRAINT fk_participent FOREIGN KEY (ID_Participent) REFERENCES Participent(ID_Participent);

ALTER TABLE Participer 
ADD CONSTRAINT fk_event FOREIGN KEY (ID_Event) REFERENCES Event(ID_Event);

INSERT INTO Responsable (ID_Membre, ID_Event) VALUES
(1, 1),
(2, 2),
(3, 3);

ALTER TABLE Responsable 
ADD CONSTRAINT fk_responsable_event FOREIGN KEY (ID_Event) REFERENCES Event(ID_Event);

ALTER TABLE Responsable 
ADD CONSTRAINT fk_responsable_membre FOREIGN KEY (ID_Membre) REFERENCES MembreBDE(ID_Membre);


INSERT INTO Sponsorer (ID_Sponsor, ID_Event) VALUES
(1, 1),
(2, 2),
(3, 3);

ALTER TABLE Sponsorer 
ADD CONSTRAINT fk_sponsor_event FOREIGN KEY (ID_Event) REFERENCES Event(ID_Event);

ALTER TABLE Sponsorer 
ADD CONSTRAINT fk_sponsor FOREIGN KEY (ID_Sponsor) REFERENCES Sponsor(ID_Sponsor);


INSERT INTO Spon_Event (ID_Sponsor, ID_Event, list_event_spon) VALUES
(1, 1, 'Soirée d_intégration'),
(1, 2, 'Concert de bienfaisance'),
(2, 2, 'Concert de bienfaisance'),
(3, 3, 'Atelier de programmation');


ALTER TABLE Spon_Event 
ADD CONSTRAINT fk_spon_event FOREIGN KEY (ID_Event) REFERENCES Event(ID_Event);

ALTER TABLE Spon_Event 
ADD CONSTRAINT fk_spon_event_sponsor FOREIGN KEY (ID_Sponsor) REFERENCES Sponsor(ID_Sponsor);

