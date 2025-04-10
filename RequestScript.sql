/* Q1 */

SELECT Categorie, Type, COUNT(*) AS NombreDeBiens
FROM BIEN
GROUP BY Categorie, Type;

/* Q2 */

SELECT E.IdE, E.Designation
FROM ESPACE E
CONNECT BY IDERATTACH = PRIOR IDE
START WITH IDE = 945;

/* Q3 */

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

/* Q4 */

SELECT b.Ville, COUNT(*) AS NombreMaisons
FROM BIEN b
WHERE b.Categorie = 'Maison de ville'
GROUP BY b.Ville
HAVING COUNT(*) > 10;

/* Q5 */

SELECT b.IdEBien, b.Categorie, b.Type, b.Ville, b.Prix,
       (b.Prix - (SELECT MIN(Prix) FROM BIEN)) AS EcartPrix
FROM BIEN b;

/* Q6 */

SELECT b.IdEBien, b.Categorie, b.Type, b.Ville, b.Prix,
       (b.Prix - (SELECT MIN(b2.Prix)
                  FROM BIEN b2
                  WHERE b2.Categorie = b.Categorie)) AS EcartPrix
FROM BIEN b;

/* Q7 */

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

/* Q8 */

WITH TotalCategories AS (
    SELECT COUNT(DISTINCT Categorie) AS Total
    FROM BIEN
)
SELECT 
    p.IdP, 
    p.Nom, 
    p.Prénom
FROM 
    PROPRIO p
JOIN 
    BIEN b ON p.IdP = b.IdP#
GROUP BY 
    p.IdP, p.Nom, p.Prénom
HAVING 
    COUNT(DISTINCT b.Categorie) = (SELECT Total FROM TotalCategories);

/*Q9*/

WITH T091 AS (
    SELECT IDE
    FROM ESPACE
    WHERE DESIGNATION = 'TERRASSE'
)
SELECT E.IdE
FROM ESPACE E, T091 
WHERE IDERATTACH IS NULL
CONNECT BY E.IDE = PRIOR E.IDERATTACH
START WITH E.IDE = T091.IDE;

/* Q10 */

WITH
T101(CAT105) AS (
    SELECT CATEGORIE AS CAT105
    FROM BIEN
    WHERE IDP = 105
)
SELECT IDP, T101.CAT105
FROM BIEN, T101
WHERE CATEGORIE = T101.CAT105;

/* Q11 */

/* CREATION OF THE VIEW */
CREATE OR REPLACE VIEW V11 (CATEGORIE, PRIXMIN ) AS
SELECT CATEGORIE, MIN(PRIX)
FROM BIEN
GROUP BY CATEGORIE;
/* USE OF THE VIEW FOR THE DEMANDED REQUEST */
SELECT B.IDEBIEN, B.CATEGORIE, B.PRIX, V11.PRIXMIN, B.PRIX - V11.PRIXMIN AS ECART_PRIX
FROM BIEN B, V11
WHERE V11.CATEGORIE = B.CATEGORIE
ORDER BY B.IDEBIEN;