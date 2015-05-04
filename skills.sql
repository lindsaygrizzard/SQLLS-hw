-- 1. Select all columns for all brands in the Brands table

    SELECT name FROM Brands;

-- 2. Select all columns for all car models made by Pontiac in the Models table.

    SELECT name FROM Models WHERE brand_name = 'Pontiac';

-- 3. Select the brand name and model 
--    name for all models made in 1964 from the Models table.
    SELECT brand_name, name FROM Models WHERE year=1964;

-- 4. Select the model name, brand name, and headquarters for the Ford Mustang 
--    from the Models and Brands tables.
    
    SELECT Models.name, Models.brand_name, Brands.headquarters
        FROM Models
        JOIN Brands
        ON Models.brand_name = Brands.name
        WHERE Brands.name = 'Ford'
        AND Models.name = 'Mustang';

-- 5. Select all rows for the three oldest brands 
--    from the Brands table (Hint: you can use LIMIT and ORDER BY).
    SELECT name, founded FROM BRANDS ORDER BY founded LIMIT 3; 

-- 6. Count the Ford models in the database (output should be a **number**).
    SSELECT COUNT(*) FROM Models WHERE brand_name = 'Ford';
-- 7. Select the **name** of any and all car brands that are not discontinued.
     SELECT name FROM Brands WHERE discontinued is Null;

-- 8. Select rows 15-25 of the DB in alphabetical order by model name.
    SELECT * FROM Models ORDER BY name LIMIT 10 OFFSET 15;


-- 9. Select the **brand, name, and year the model's brand was 
--    founded** for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the Brands table.
--    (The year the brand was founded should be ``null`` if 
--    the brand is not in the Brands table.)

    SELECT Brands.name, Models.name, Brands.founded 
   ...> FROM Models LEFT JOIN Brands ON Brands.name = Models.brand_name
   ...> WHERE year = 1960;





CREATE TABLE Brands (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50) NOT NULL,  -- Ford | same as Models brand_name (makeSELECT)
    founded INT(4),
    headquarters VARCHAR(50),
    discontinued INT(4)

CREATE TABLE Models (
    id INTEGER PRIMARY KEY,
    year INT(4) NOT NULL,
    brand_name VARCHAR(50) NULL, --Ford | same as Brand Table name (make)
    name VARCHAR(50) NOT NULL -- Ranger, type of brand (model)



-- Part 2: Change the following queries according to the specifications. 
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all **brands** that are not discontinued
-- regardless of whether they have any cars in the cars table.
-- before:

    SELECT Models.name, Brands.discontinued 
        FROM Models LEFT JOIN Brands 
            ON Models.brand_name = Brands.name 
            WHERE Brands.discontinued IS NULL; 

        -- Just needed to switch the left join to show the empty columns

-- 2. Modify this left join so it only selects models that have brands in the Brands table.
-- before: 
    SELECT m.name,
           m.brand_name,
           b.founded
    FROM Models AS m
      JOIN Brands AS b
        ON m.brand_name =b.name;

        -- Changed to join so as to not get non cross over columns

-- followup question: In your own words, describe the difference between 
-- left joins and inner joins.

-- 3. Modify the query so that it only selects brands that don't have any car 
-- models in the cars table. 
-- (Hint: it should only show Tesla's row.)
-- before: 
                        
    SELECT Brands.name, Models.brand_name ,Brands.headquarters, Brands.founded 
                      -- ^^ why no show??
        FROM Brands LEFT JOIN Models
            ON Models.brand_name = Brands.name 
                WHERE Models.brand_name IS NULL;

            -- Wherever brand_name is NULL join with 
            -- Brands.name to get Null 
            -- Must Select from Brands.name and not Model.brand_name and
            -- not Models.brand_name. Not sure why


-- 4. Modify the query to add another column to the results to show 
-- the number of years from the year of the model *until* the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before: 
  

 SELECT b.name, m.name, m.year, b.discontinued, (b.discontinued - m.year) 
    AS years_until_brand_discontinued;
        FROM Models AS m
            LEFT JOIN Brands AS b
                ON m.brand_name = b.name
                    WHERE b.discontinued NOT NULL;

    -- add new column which is just the math of discontinued - year 




-- Part 3: Futher Study

-- 1. Select the **name** of any brand with more than 5 models in the database.

    SELECT name FROM Models GROUP BY name HAVING count(name) > 5;

-- 2. Add the following rows to the Models table.

INSERT INTO Models (year, name, brand_name)
    VALUES
        (2015, 'Chevrolet', 'Malibu'),
        (2015, 'Subaru', 'Outback');

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback

-- 3. Write a SQL statement to crate a table called ``Awards`` 
--    with columns ``name``, ``year``, and ``winner``. Choose 
--    an appropriate datatype and nullability for each column.

CREATE TABLE Awards(
    name VARCHAR(30) NOT NULL,
    year INT(4),
    winner_model_id INT(20) NOT NULL
);

-- 4. Write a SQL statement that adds the following rows to the Awards table:

INSERT INTO Awards (name, year, winner_model_id)
    VALUES 
        ('IIHS Safety Award', 2015, 49),
        ('IIHS Safety Award', 2015, 50);



--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      # get the ``id`` of the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      # get the ``id`` of the 2015 Subaru Outback

-- 5. Using a subquery, select only the *name* of any model whose 
-- year is the same year that *any* brand was founded.

SELECT name, year FROM Models 
    WHERE year IN 
        (SELECT founded
            FROM Brands);

-- get the Models table name and year WHERE it is IN the list of yr founded in the Brands table



