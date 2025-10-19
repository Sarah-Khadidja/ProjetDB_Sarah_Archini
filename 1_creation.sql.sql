CREATE DATABASE DSK_co_DB;
USE DSK_co_DB;

CREATE TABLE Client(
   id_client INT,
   nom_client VARCHAR(50) NOT NULL,
   prenom_client VARCHAR(50) NOT NULL,
   email_client VARCHAR(50) NOT NULL,
   telephone_client INT NOT NULL,
   adresse_client VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_client),
   UNIQUE(nom_client),
   UNIQUE(email_client),
   UNIQUE(telephone_client),
   UNIQUE(adresse_client)
);

CREATE TABLE fournisseur(
   id_fournisseur INT,
   nom_fournisseur VARCHAR(50) NOT NULL,
   contact_fournisseur INT NOT NULL,
   pays_fournisseur VARCHAR(50) NOT NULL,
   adresse_fournisseur VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_fournisseur),
   UNIQUE(nom_fournisseur),
   UNIQUE(contact_fournisseur),
   UNIQUE(adresse_fournisseur)
);

CREATE TABLE Vehicule(
   id_vehicule INT,
   marque VARCHAR(50) NOT NULL,
   prix_achat DECIMAL(15,2) NOT NULL,
   prix_vente DECIMAL(15,2) NOT NULL,
   id_vehicule_1 INT NOT NULL,
   PRIMARY KEY(id_vehicule),
   FOREIGN KEY(id_vehicule_1) REFERENCES Vehicule(id_vehicule)
);

CREATE TABLE Commande(
   id_commande VARCHAR(50),
   date_commande DATE NOT NULL,
   montant_total DECIMAL(15,2) NOT NULL,
   id_client INT NOT NULL,
   PRIMARY KEY(id_commande),
   FOREIGN KEY(id_client) REFERENCES Client(id_client)
);

CREATE TABLE paiement(
   id_paiement INT,
   date_paiement DATE NOT NULL,
   id_commande VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_paiement),
   FOREIGN KEY(id_commande) REFERENCES Commande(id_commande)
);

CREATE TABLE Livraison(
   id_fournisseur INT,
   id_vehicule INT,
   id_commande VARCHAR(50),
   date_livraison VARCHAR(50),
   PRIMARY KEY(id_fournisseur, id_vehicule, id_commande),
   FOREIGN KEY(id_fournisseur) REFERENCES fournisseur(id_fournisseur),
   FOREIGN KEY(id_vehicule) REFERENCES Vehicule(id_vehicule),
   FOREIGN KEY(id_commande) REFERENCES Commande(id_commande)
);

