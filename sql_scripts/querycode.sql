-- Query 1: Display information about columns in the ARTMUSEUM database.
SELECT * 
FROM information_schema.columns 
WHERE table_schema = 'ARTMUSEUM' 
ORDER BY table_name, ordinal_position;

-- Query 2: Retrieve artists born between 1400 and 1800.
SELECT * 
FROM ARTMUSEUM.ARTIST 
WHERE Date_Born BETWEEN '1400' AND '1800';

-- Query 3: Retrieve artists born between 1400 and 1800, ordered by birth date.
SELECT * 
FROM ARTMUSEUM.ARTIST 
WHERE Date_Born BETWEEN '1400' AND '1800' 
ORDER BY Date_Born;

-- Query 4: Retrieve art objects with a cost greater than 3000 from the permanent collection.
SELECT *
FROM ARTMUSEUM.ART_OBJECT
WHERE ID_no IN
  (SELECT ID_no
  FROM ARTMUSEUM.PERMANENTCOLLECTION
  WHERE Cost > 3000);

-- Query 5: Retrieve information about paintings and their corresponding art objects.
SELECT P.Title, P.Origin, A.Epoch, A.Drawn_on, A.MEDIUM, A.Artist
FROM ARTMUSEUM.PAINTING P
INNER JOIN ARTMUSEUM.ART_OBJECT A ON P.ID_no = A.ID_no;

-- Query 6: Create a trigger to convert the 'Country_of_Origin' to uppercase before updating an artist record.
DROP TRIGGER IF EXISTS ARTMUSEUM.ARTIST_BEFORE_UPDATE;

DELIMITER $$
USE ARTMUSEUM$$
CREATE DEFINER = CURRENT_USER TRIGGER ARTMUSEUM.ARTIST_BEFORE_UPDATE BEFORE UPDATE ON ARTMUSEUM.ARTIST FOR EACH ROW
BEGIN
    SET NEW.Country_of_Origin = UPPER(NEW.Country_of_Origin);
END$$
DELIMITER ;

-- Query 7: Create a trigger to log information after deleting a record from the artist table.
DROP TRIGGER IF EXISTS ARTMUSEUM.ARTIST_AFTER_DELETE;

DELIMITER $$
USE ARTMUSEUM$$
CREATE DEFINER = CURRENT_USER TRIGGER ARTMUSEUM.ARTIST_AFTER_DELETE AFTER DELETE ON ARTMUSEUM.ARTIST FOR EACH ROW
BEGIN
    DECLARE vUser varchar(50);

    -- Find username of person performing the DELETE into the table
    SELECT USER() INTO vUser;

    -- Insert record into AUDIT table
    INSERT INTO ARTMUSEUM.AUDIT 
    (DeletedDate, DeletedBy)
    VALUES
    (SYSDATE(), vUser);
END$$
DELIMITER ;

