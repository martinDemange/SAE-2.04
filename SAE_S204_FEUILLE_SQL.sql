--Q1

SELECT Categorie, Type, COUNT(*) AS NombreDeBiens
FROM BIEN
GROUP BY Categorie, Type;

--Q2

SELECT E.IdE, E.Designation
FROM ESPACE E
CONNECT BY IDERATTACH = PRIOR IDE
START WITH IDE = 945;

--Q3

SELECT p.IdP, p.Nom, p.Prénom
FROM PROPRIO p
WHERE NOT EXISTS (
    SELECT 1
    FROM BIEN b
    WHERE b.IdP = p.IdP
    AND b.Ville = 'Marseille'
);

-- autre méthode avec NULL

SELECT p.IdP, p.Nom, p.Prénom
FROM PROPRIO p
LEFT JOIN BIEN b ON p.IdP = b.IdP AND b.Ville = 'Marseille'
WHERE b.IdEBien IS NULL;

--Q4

SELECT b.Ville, COUNT(*) AS NombreMaisons
FROM BIEN b
WHERE b.Categorie = 'Maison de ville'
GROUP BY b.Ville
HAVING COUNT(*) > 10;

--Q5

SELECT b.IdEBien, b.Categorie, b.Type, b.Ville, b.Prix,
       (b.Prix - (SELECT MIN(Prix) FROM BIEN)) AS EcartPrix
FROM BIEN b;

--Q6

SELECT b.IdEBien, b.Categorie, b.Type, b.Ville, b.Prix,
       (b.Prix - (SELECT MIN(b2.Prix)
                  FROM BIEN b2
                  WHERE b2.Categorie = b.Categorie)) AS EcartPrix
FROM BIEN b;

--Q7

SELECT b.IdP, p.Nom, p.Prénom, COUNT(b.IdEBien) AS NombreTotalBiens
FROM BIEN b
JOIN PROPRIO p ON b.IdP = p.IdP
WHERE b.IdP IN (
    SELECT b2.IdP
    FROM BIEN b2
    WHERE b2.Categorie = 'Studio'
    GROUP BY b2.IdP
    HAVING COUNT(b2.IdEBien) >= 2
)
GROUP BY b.IdP, p.Nom, p.Prénom;