-- ============================================
-- DONNÉES D'EXEMPLE : Ventes E-Commerce
-- ============================================

-- Catégories de produits
INSERT INTO categories VALUES (1, 'Électronique');
INSERT INTO categories VALUES (2, 'Vêtements');
INSERT INTO categories VALUES (3, 'Alimentation');
INSERT INTO categories VALUES (4, 'Sport');

-- Produits
INSERT INTO produits VALUES (1, 'Smartphone X12', 1, 699.99);
INSERT INTO produits VALUES (2, 'Casque Bluetooth', 1, 89.99);
INSERT INTO produits VALUES (3, 'T-shirt Premium', 2, 29.99);
INSERT INTO produits VALUES (4, 'Veste Hiver', 2, 149.99);
INSERT INTO produits VALUES (5, 'Café Bio 500g', 3, 12.50);
INSERT INTO produits VALUES (6, 'Raquette Tennis', 4, 79.99);
INSERT INTO produits VALUES (7, 'Chaussures Running', 4, 119.99);
INSERT INTO produits VALUES (8, 'Tablette Pro', 1, 499.99);

-- Clients
INSERT INTO clients VALUES (1, 'Alice', 'Martin', 'alice.martin@email.com', '2023-01-15');
INSERT INTO clients VALUES (2, 'Bob', 'Dupont', 'bob.dupont@email.com', '2023-02-20');
INSERT INTO clients VALUES (3, 'Claire', 'Bernard', 'claire.b@email.com', '2023-03-10');
INSERT INTO clients VALUES (4, 'David', 'Petit', 'david.p@email.com', '2023-04-05');
INSERT INTO clients VALUES (5, 'Emma', 'Leroy', 'emma.leroy@email.com', '2023-05-18');

-- Commandes
INSERT INTO commandes VALUES (1, 1, '2024-01-10', 789.98, 'livré');
INSERT INTO commandes VALUES (2, 2, '2024-01-15', 89.99, 'livré');
INSERT INTO commandes VALUES (3, 1, '2024-02-03', 149.99, 'livré');
INSERT INTO commandes VALUES (4, 3, '2024-02-14', 179.98, 'livré');
INSERT INTO commandes VALUES (5, 4, '2024-03-01', 12.50, 'livré');
INSERT INTO commandes VALUES (6, 2, '2024-03-20', 499.99, 'livré');
INSERT INTO commandes VALUES (7, 5, '2024-04-05', 199.98, 'en cours');
INSERT INTO commandes VALUES (8, 3, '2024-04-18', 79.99, 'livré');
INSERT INTO commandes VALUES (9, 1, '2024-05-02', 119.99, 'livré');
INSERT INTO commandes VALUES (10, 5, '2024-05-15', 29.99, 'annulé');

-- Détails commandes
INSERT INTO details_commandes VALUES (1, 1, 1, 1, 699.99);
INSERT INTO details_commandes VALUES (2, 1, 2, 1, 89.99);
INSERT INTO details_commandes VALUES (3, 2, 2, 1, 89.99);
INSERT INTO details_commandes VALUES (4, 3, 4, 1, 149.99);
INSERT INTO details_commandes VALUES (5, 4, 3, 2, 59.98);
INSERT INTO details_commandes VALUES (6, 4, 2, 1, 89.99);  -- correction: détail ajouté
INSERT INTO details_commandes VALUES (7, 5, 5, 1, 12.50);
INSERT INTO details_commandes VALUES (8, 6, 8, 1, 499.99);
INSERT INTO details_commandes VALUES (9, 7, 6, 1, 79.99);
INSERT INTO details_commandes VALUES (10, 7, 3, 4, 119.96);
INSERT INTO details_commandes VALUES (11, 8, 6, 1, 79.99);
INSERT INTO details_commandes VALUES (12, 9, 7, 1, 119.99);
INSERT INTO details_commandes VALUES (13, 10, 3, 1, 29.99);
