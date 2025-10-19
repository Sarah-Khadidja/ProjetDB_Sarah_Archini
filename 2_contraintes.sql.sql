
ALTER TABLE Vehicule
ADD CONSTRAINT chk_prix_a
CHECK (prix_achat>=0);
ALTER TABLE Vehicule
ADD CONSTRAINT chk_prix_v
CHECK (prix_vente>=0);
ALTER TABLE Commande
ADD CONSTRAINT chk_montant
CHECK (montant_total>=0);
ALTER TABLE Vehicule 
ADD CONSTRAINT chk_vehicule_vente_ge_achat
CHECK (prix_vente> prix_achat);
ALTER TABLE Client
ADD CONSTRAINT chk_tel_client
CHECK ( CHAR_LENGTH(telephone_client) BETWEEN 8 AND 15);
