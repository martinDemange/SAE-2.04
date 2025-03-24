CREATE TABLE BIEN (
IDEBIEN NUMBER(6),
CATEGORIE VARCHAR(20), 
TYPE VARCHAR(20),
IDP NUMBER(6),
VILLE VARCHAR(20),
PRIX NUMBER(10, 2),
CONSTRAINT PK_BIEN PRIMARY KEY(IDEBIEN),
CONSTRAINT FK_BIEN FOREIGN KEY(IDEBIEN) REFERENCES ESPACE(IDERATTACH),
CONSTRAINT FK_BIEN2 FOREIGN KEY(IDP) REFERENCES PROPRIO(IDP));


-- TABLE ESPACE 
CREATE TABLE ESPACE (
    IDE NUMBER(6),
    DESIGNATION VARCHAR2(30),
    SUPERFICIE NUMBER(7,2),
    IDERATTACH NUMBER(6),   
    
    CONSTRAINT PK_IDE PRIMARY KEY (IDE),
    CONSTRAINT FK_IDERATTACH FOREIGN KEY (IDERATTACH) REFERENCES ESPACE (IDE) 
); 
