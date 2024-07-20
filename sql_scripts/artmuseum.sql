DROP DATABASE IF EXISTS ARTMUSEUM;
CREATE DATABASE ARTMUSEUM; 
USE ARTMUSEUM;

DROP TABLE IF EXISTS EPOCH;
CREATE TABLE EPOCH (
    Ep_Type    varchar(30),
    Ep_Description varchar(250),
    primary key(Ep_Type)
);

INSERT into EPOCH (Ep_Type, Ep_Description)
VALUES
("Renaissance","Revival of art, science, and humanism in 14th–17th century Europe"),
("Modern","Diverse, experimental, challenging traditions, reflects 20th-century cultural shifts, abstract expressions"),
("Baroque","Drama, emotion, contrast, ornamentation, religious themes, dynamic energy"),
("Contemporary","A diverse range of styles, mediums, and approaches, reflecting the rapidly changing nature of the world and the influence of various cultural, technological, and social factors"),
("Neoclassical","Symmetrical, classical motifs, columns, pediments—Neoclassical architecture is order and elegance.");



DROP TABLE IF EXISTS COUNTRYINFO;
CREATE TABLE COUNTRYINFO (
    Country    varchar(30),
    Coun_Description varchar(250),
    primary key(Country)
);

INSERT into COUNTRYINFO (Country, Coun_Description)
VALUES
("Netherlands","Low-lying, tulips, windmills, canals, progressive, cultural diversity, historic art"),
("Germany","Central European nation with rich history, culture, and economic influence"),
("Italy","Historic, artistic, cultural epicenter; Mediterranean beauty, renowned cuisine, and influential heritage"),
("England","Historic, diverse, cultural hub; known for literature, monarchy, and landscapes"),
("Spain","Vibrant culture, diverse landscapes, rich history, Mediterranean charm, flamenco music"),
("France","Cultural hub at the center of the Renaissance movement");



DROP TABLE IF EXISTS ARTIST;
CREATE TABLE ARTIST (
    A_Name     varchar(30) not null,
    Date_Born  varchar(10) not null,
    Date_Died  varchar(10),
    Country_of_Origin varchar(30) not null,
    Epoch      varchar(30) not null,
    Main_Style varchar(30) not null,
    A_Description varchar(250) not null,
    primary key(A_Name), foreign key(Country_of_Origin) references COUNTRYINFO(Country) ON DELETE CASCADE ON UPDATE CASCADE,
    foreign key(Epoch) references EPOCH(Ep_Type) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT into ARTIST (A_name, Date_Born, Date_Died, Country_of_Origin, Epoch, Main_Style, A_Description)
VALUES
("Dirck Vellert","1480","1547","Netherlands","Renaissance","Northern Renaissance","Northern Renaissance Dutch artist"),
("Hans Holbein the Younger","1497","1543","Germany","Renaissance","Italian Renaissance","Masterful portraitist capturing Renaissance personalities with meticulous realism and detail"),
("Pietro Torrigiano","1472","1528","Italy","Renaissance","Renaissance/Classical","Italian sculptor, known for Michelangelo rivalry and bust of Henry VII."),
("Jacob Halder","1557","1608","England","Renaissance","Armorer","Master armorer at the royal workshops at Greenwich"),
("Pablo Picasso","1881","1973","Spain","Modern","Cubism,Surrealism","Innovative 20th-century artist, co-founder of Cubism, prolific creator"),
("Della Robbia, Andrea","1435","1525","Italy","Renaissance","Italian Renaissance","Italian Renaissance sculptor, renowned for glazed terracotta works, including Madonna reliefs and decorative art"),
("Desiderio da Settignano","1430","1464","Italy","Renaissance","Italian Renaissance","Renaissance sculptor, painter, elegance, classical influence, emotional expression"),
("Dupré, Guillaume","1574","1647","France","Baroque","Sculpture","French sculptor and engraver during the Baroque period. Known for his medals and portrait sculptures"),
("Jean-Michel Othoniel","1964",NULL,"France","Contemporary","Sculpture-installation","Contemporary artist known for intricate glass sculptures exploring identity and memory."),
("Hector Martin Lefuel","1810","1880","France","Neoclassical","Neoclassicalism","Neoclassical architect known for Louvre contributions during Second Empire in France");



DROP TABLE IF EXISTS ART_OBJECT;
CREATE TABLE ART_OBJECT (
    ID_no       varchar(6) not null,
    Artist      varchar(30) not null,
    Year_created        varchar(4) default null,
    Title               varchar(100) not null,
    AO_Description         varchar(250) not null,
    primary key (ID_no), foreign key (Artist) references ARTIST(A_Name) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO ART_OBJECT(ID_no, Artist, Year_created, Title, AO_Description)
VALUES
("AM-001","Dirck Vellert","1530","Martyrdom of the Seven Maccabee Brothers and Their Mother","Stained glass depiction of King Antiochus IV Epiphanes murdering a Jewish family for their refusal to eat pork"),
("AM-002","Hans Holbein the Younger","1532","Portrait of a Man in Royal Livery","Portrait of man wearing English royal livery"),
("AM-003","Pietro Torrigiano","1510","Portrait Bust of John Fisher, Bishop of Rochester","Sculpted reverence: Fisher's bishopric captured in detailed Renaissance bust"),
("AM-004","Jacob Halder","1586","Armor Garniture of George Clifford (1558-1605), Third Earl of Cumberland","The Cumberland armor is part of a garniture for field and tournament use"),
("AM-005","Pablo Picasso","1912","Violin and Grapes","The fluctuating planes in a shallow space are characteristic of Analytic Cubism and the modernist emphasis on the picture surface"),
("AM-006","Pablo Picasso","1914","The Absinthe Glass","Spanish artist's evocative exploration of intoxication"),
("AM-007","Della Robbia, Andrea","1460","Saint Bishop (Saint Bonaventure?)","Standing, halo, crook and gauntlet, covered with a cope over his robe, a cardinal's hat at his feet."),
("AM-008","Desiderio da Settignano","1475","The Virgin Adoring the Child","Virgin Mary affectionately adoring the infant Jesus"),
("AM-009","Dupré, Guillaume","1613","Nicolas Brulart de Sillery, Keeper of the Seals (1604) Chancellor of France (1607)","Medallion of the chancellor of France"),
("AM-010","Jean-Michel Othoniel","2019","The Rose of the Louvre","Belongs to a series composed of six unpublished paintings (RFML.HL.2020.10.1 to 6) presented in the Cour Puget among garden statuary from the 17th and 18th centuries."),
("AM-011","Hector Martin Lefuel","1870","foot of mud","Foot of vase with intricate details engraved within"),
("AM-012","Hector Martin Lefuel","1876","baguette ; mold with good hollow parts; hollow imprint", "Intricate hollow design for creating perfect imprints in dough" );



DROP TABLE IF EXISTS PAINTING;
CREATE TABLE PAINTING (
    ID_no         varchar(6) not null,
    Paint_type    varchar(30) default null,
    Drawn_on      varchar(30) default null,
    Style         varchar(30) default null,
    foreign key(ID_no) references ART_OBJECT(ID_no) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT into PAINTING (ID_no, Paint_type, Drawn_on, Style)
VALUES
("AM-002","Oil","Canvas","Realism"),
("AM-005","Oil","Canvas","Abstract"),
("AM-008","Oil","Polychrone Stucco","Realism"),
("AM-010","Mixed Media" ,"Canvas" ,"Abstract" );



DROP TABLE IF EXISTS SCULPTURE_STATUE;
CREATE TABLE SCULPTURE_STATUE (
    ID_no         varchar(6) not null,
    Material    varchar(30) default null,
    Height      varchar(30) default null,
    S_Weight      varchar(30) default null,
    Style         varchar(30) default null,
    foreign key(ID_no) references ART_OBJECT(ID_no) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT into SCULPTURE_STATUE (ID_no, Material, Height, S_Weight, Style)
VALUES
("AM-003","Polychrome terracotta","65.7cm","28.1kg","Realism"),
("AM-004","Steel,Gold,Leather,Textile","176.5 cm","27.2kg","Armour"),
("AM-006","Bronze,Tin","16.4cm","0.43kg","Abstract"),
("AM-007","Glazed teracotta","1.63m","52.3kg","Realism" );



DROP TABLE IF EXISTS OTHER;
CREATE TABLE OTHER (
    ID_no         varchar(6) not null,
    A_Type         varchar(30) not null,
    Style         varchar(30) default null,
    foreign key(ID_no) references ART_OBJECT(ID_no) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT into OTHER (ID_no, A_Type, Style)
VALUES
("AM-001","Stained Glass" ,"Realism"),
("AM-009","Medallion","Realism"),
("AM-011","Plaster" ,"Gothic"),
("AM-012","Plaster" ,"Functional" );



DROP TABLE IF EXISTS PERMANENTCOLLECTION;
CREATE TABLE PERMANENTCOLLECTION (
    ID_no           varchar(6) not null,
    Date_Acquired   varchar(10) not null,
    A_Status          varchar(45) not null,
    Cost            varchar(15)         not null,
    foreign key(ID_no) references ART_OBJECT(ID_no) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT into PERMANENTCOLLECTION (ID_no, Date_Acquired, A_Status, Cost)
VALUES
("AM-001","03/25/1979" ,"Display" ,"$40000"),
("AM-002","07/04/2003" ,"Display" , "$2560"),
("AM-003","05/28/1965" ,"Loan" ,"$1500"),
("AM-004","02/14/1986" ,"Loan" ,"$56000" ),
("AM-005","04/04/2004" ,"Loan" , "$0"),
("AM-006","08/25/2011" ,"Loan" ,"$15000" );



DROP TABLE IF EXISTS COLLECTIONS;
CREATE TABLE COLLECTIONS (
    C_Name    varchar(100) not null,
    C_Type    varchar(30) not null,
    C_Description varchar(250) not null,
    C_Address varchar(30) not null,
    Phone_num varchar(30) not null,
    Contact_person varchar(30) not null,
    primary key(C_Name)
);

INSERT into COLLECTIONS (C_Name, C_Type, C_Description, C_Address, Phone_num, Contact_person)
VALUES
("Department of Sculptures of the Middle Ages, Renaissance and Modern Times","Museum","Collection spanning Middle Ages to Modern Times, showcasing diverse sculptural masterpieces.","75001 Paris, France","111-111-111","Adeeb Hossain"),
("Louvre History Department","Museum","Collection featuring pieces from a variety of mediums ranging in year of creation","75001 Paris, France","222-222-222","Shalin Wikremeratna");



DROP TABLE IF EXISTS BORROWED;
CREATE TABLE BORROWED (
    ID_no           varchar(6) not null,
    Collection_from varchar(100) not null,
    Date_Borrowed   varchar(10) not null,
    Date_Returned   varchar(10) not null,
    foreign key(Collection_from) references COLLECTIONS(C_Name) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT into BORROWED (ID_no, Collection_from, Date_Borrowed, Date_Returned)
VALUES
("AM-007","Department of Sculptures of the Middle Ages, Renaissance and Modern Times","04/27/2010","04/27/2011"),
("AM-008","Department of Sculptures of the Middle Ages, Renaissance and Modern Times","06/30/1979" ,"07/15/1980"),
("AM-009","Department of Sculptures of the Middle Ages, Renaissance and Modern Times","05/31/2012","07/23/2015"),
("AM-010","Louvre History Department" ,"07/21/2020" ,"05/16/2021"),
("AM-011","Louvre History Department" ,"05/18/2002" ,"08/12/2002"),
("AM-012","Louvre History Department" ,"08/25/2022" ,"07/28/2023" );



DROP TABLE IF EXISTS EXHIBITIONS;
CREATE TABLE EXHIBITIONS (
    E_Name   varchar(200) not null,
    Start_Date varchar(30),
    End_Date varchar(30),
    primary key(E_Name)
);

INSERT into EXHIBITIONS (E_Name, Start_Date,End_Date)
VALUES
("Legion of Honor, Fine Arts Museums of San Francisco","06/24/2023","09/24/2023"),
("New York. The Metropolitan Museum of Art","10/17/2022","01/22/2023"),
("Palais de lIndustrie","05/01/1862","10/06/1862"),
("Reconciliations. Rome, Henry IV and France, National Museum of the Château de Pau","07/17/2020","10/18/2020"),
("JEAN-MICHEL OTHONIEL: THE RECONCILIATION OF OPPOSITES","10/27/2023","12/22/2023");



DROP TABLE IF EXISTS EXHIBITPIECES;
CREATE TABLE EXHIBITPIECES (
    ID_no   varchar(6),
    E_Name  varchar(200),
    foreign key(ID_no) references ART_OBJECT(ID_no) on DELETE CASCADE ON UPDATE CASCADE,
    foreign key(E_name) references EXHIBITIONS(E_name) on DELETE CASCADE ON UPDATE CASCADE
);

INSERT into EXHIBITPIECES (ID_no, E_Name)
VALUES
("AM-001","Legion of Honor, Fine Arts Museums of San Francisco"),
("AM-002","Legion of Honor, Fine Arts Museums of San Francisco"),
("AM-003","Legion of Honor, Fine Arts Museums of San Francisco"),
("AM-004","Legion of Honor, Fine Arts Museums of San Francisco"),
("AM-005","New York. The Metropolitan Museum of Art"),
("AM-006","New York. The Metropolitan Museum of Art"),
("AM-007","Palais de lIndustrie"),
("AM-008","Palais de lIndustrie"),
("AM-009","Reconciliations. Rome, Henry IV and France, National Museum of the Château de Pau"),
("AM-010","JEAN-MICHEL OTHONIEL: THE RECONCILIATION OF OPPOSITES");


DROP ROLE IF EXISTS 'db_admin'@'localhost', 'write_access'@'localhost', 'read_access'@'localhost';
CREATE ROLE 'db_admin'@'localhost', 'write_access'@'localhost', 'read_access'@'localhost';

GRANT ALL PRIVILEGES ON ARTMUSEUM.* TO 'db_admin'@'localhost' WITH GRANT OPTION;
GRANT Select ON ARTMUSEUM.* TO 'read_access'@'localhost';
GRANT INSERT ON ARTMUSEUM.* TO 'write_access'@'localhost';
GRANT UPDATE ON ARTMUSEUM.* TO 'write_access'@'localhost';

DROP USER IF EXISTS 'admin'@'localhost';
DROP USER IF EXISTS 'data_entry'@'localhost';
DROP USER IF EXISTS 'guest'@'localhost';

CREATE USER 'admin'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
CREATE USER 'data_entry'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
CREATE USER 'guest'@'localhost';

GRANT 'db_admin'@'localhost' to 'admin'@'localhost';
GRANT 'write_access'@'localhost' to 'data_entry'@'localhost';
GRANT 'read_access'@'localhost' to 'guest'@'localhost';

SET DEFAULT ROLE ALL TO 'admin'@'localhost';
SET DEFAULT ROLE ALL TO 'data_entry'@'localhost';
SET DEFAULT ROLE ALL TO 'guest'@'localhost';

FLUSH PRIVILEGES;
<<<<<<< Updated upstream:sql_scripts/artmuseum.sql
=======







>>>>>>> Stashed changes:artmuseum.sql
