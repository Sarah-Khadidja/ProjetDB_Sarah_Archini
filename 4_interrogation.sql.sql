-- Lister les véhicules disponibles entre 20000 et 40000 €
SELECT id_vehicule, marque, prix_vente FROM Vehicule WHERE prix_vente BETWEEN 20000 AND 40000;
-- Rechercher les véhicules d'une marque spécifique (par exemple Toyota)
SELECT id_vehicule, marque, prix_vente FROM Vehicule WHERE marque = 'Toyota';
-- Afficher tous les véhicules disponibles triés par prix croissant
SELECT id_vehicule, marque, prix_vente FROM Vehicule ORDER BY prix_vente ASC;
-- Lister les vehicules d'un prix inférieur ou égal à 30000€
SELECT id_vehicule, marque, prix_vente FROM Vehicule WHERE prix_vente<=30000;
-- Afficher uniquement les marques distinctes disponibles dans le stock
SELECT DISTINCT marque FROM Vehicule;
-- Afficher les 5 véhicules les moins chers
SELECT id_vehicule, marque, prix_vente FROM Vehicule ORDER BY prix_vente ASC LIMIT 5;
-- Analyse des commandes et paiements (acteur:responsable des ventes)
-- Compter le nombre total de véhicules vendus 
SELECT COUNT(*) AS nb_vehicules_vendus FROM Livraison;
-- Calculer le montant moyen payé par commande
SELECT AVG(montant_total) AS montant_moyen_par_commande FROM Commande ;
-- Calculer le montant total des ventes par client
SELECT id_client, SUM(montant_total) AS total_ventes FROM Commande GROUP BY id_client;
-- Moyenne des prix par marque
SELECT marque, AVG(prix_vente) AS prix_moyen FROM Vehicule GROUP BY marque;
-- Nombre de véhicules disponibles
SELECT COUNT(*) AS nb_total_vehicules FROM Vehicule;
-- Suivi des commandes, livraisons et relations client-fournisseur( Responsable logistique et ventes)
-- Afficher toutes les commandes ainsi que l'id des clients
SELECT c.id_commande,c.id_client, c.date_commande, c.montant_total FROM Commande c JOIN Client cl ON c.id_client = cl.id_client;
-- Afficher les paiements associés aux clients et aux commandes
SELECT p.id_paiement, cl.nom_client, c.id_commande, p.date_paiement FROM Paiement p JOIN Commande c ON p.id_commande = c.id_commande JOIN Client cl ON c.id_client =cl.id_client;
-- Lister les véhicules livrés avec leur commande et le client concerné
SELECT v.marque, c.id_commande,cl.nom_client, l.date_livraison FROM Vehicule v JOIN Livraison l ON v.id_vehicule=l.id_vehicule JOIN Commande c ON l.id_commande = c.id_commande JOIN Client cl ON c.id_client = cl.id_client;
-- Lister toutes les commandes passées après une certaine date
SELECT id_commande , id_client, date_commande, montant_total FROM Commande WHERE date_commande >='2025-01-01';
-- Afficher les clients, leurs commandes et les fournisseurs liés aux véhicules de ces commandes
SELECT cl.id_client, cl.nom_client, cl.prenom_client, c.id_commande, c.date_commande, f.id_fournisseur, f.nom_fournisseur FROM Client cl JOIN Commande c ON cl.id_client = c.id_client JOIN Livraison l ON c.id_commande = l.id_commande
JOIN fournisseur f ON l.id_fournisseur = f.id_fournisseur ORDER BY cl.id_client, c.id_commande;
-- Organisation de la livraison( responsable logistique)
-- Lister les livraisons de véhicules de certaines marques
SELECT id_commande, id_vehicule, date_livraison FROM Livraison WHERE id_vehicule IN (
    SELECT id_vehicule
    FROM Vehicule
    WHERE marque IN ('Toyota', 'Audi'));
    -- Trouver les fournisseurs dont un seul véhicule n'a pas encore été livré
    SELECT *FROM Fournisseur f WHERE NOT EXISTS (
    SELECT 1
    FROM Livraison l
    WHERE l.id_fournisseur = f.id_fournisseur);
    -- Trouver les commandes dont la date de livraison est plus proche que toutes les autres livraisons
    SELECT id_commande, date_livraison FROM Livraison WHERE date_livraison < ALL(
    SELECT date_livraison FROM Livraison WHERE date_livraison IS NOT NULL);
    -- Clients n'ayant jamais reçu de livraison
    SELECT cl.id_client, cl.nom_client, cl.prenom_client FROM Client cl WHERE cl.id_client NOT IN (
    SELECT c.id_client
    FROM Commande c
    JOIN Livraison l ON c.id_commande = l.id_commande;
    -- Identifier les livraisons premiums
    SELECT v.marque, v.prix_vente, f.nom_fournisseur FROM Livraison l
JOIN Vehicule v ON l.id_vehicule = v.id_vehicule
JOIN Fournisseur f ON l.id_fournisseur = f.id_fournisseur
WHERE v.prix_vente > (
    SELECT AVG(prix_vente)
    FROM Vehicule);
    -- Trouver les livraisons associées à des clients qui ont payé un montant total supérieur à 50000€
    SELECT cl.nom_client, v.marque, f.nom_fournisseur FROM Livraison l
JOIN Commande c ON l.id_commande = c.id_commande
JOIN Client cl ON c.id_client = cl.id_client
JOIN Vehicule v ON l.id_vehicule = v.id_vehicule
JOIN Fournisseur f ON l.id_fournisseur = f.id_fournisseur
WHERE c.id_client IN (
    SELECT id_client
    FROM Commande
    GROUP BY id_client
    HAVING SUM(montant_total) > 50000);
    
    
