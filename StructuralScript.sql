/*
-------------------------------------------------------------------------------
//////////////////////////////CREATION DES TABLES//////////////////////////////
-------------------------------------------------------------------------------
*/

CREATE TABLE PROPRIO (
    IDP NUMBER(6),
    NOM VARCHAR2(20),
    PRENOM VARCHAR2(20),
    CONSTRAINT PK_PROPRIO PRIMARY KEY (IDP)
);

CREATE TABLE BIEN (
    IDEBIEN NUMBER(6),
    CATEGORIE VARCHAR(20), 
    TYPE VARCHAR(20),
    IDP NUMBER(6),
    VILLE VARCHAR(20),
    PRIX NUMBER(10, 2),
    CONSTRAINT PK_BIEN PRIMARY KEY(IDEBIEN),
    CONSTRAINT FK_BIEN FOREIGN KEY(IDEBIEN) REFERENCES ESPACE(IDERATTACH),
    CONSTRAINT FK_BIEN2 FOREIGN KEY(IDP) REFERENCES PROPRIO(IDP)
);

/*
-------------------------------------------------------------------------------
/////////////////////////////SUPRESSION DES TABLES/////////////////////////////
-------------------------------------------------------------------------------
*/
/*
DROP TABLE PROPRIO CASCADE CONSTRAINTS;
DROP TABLE BIEN CASCADE CONSTRAINTS;
DROP TABLE ESPACE CASCADE CONSTRAINTS;
*/