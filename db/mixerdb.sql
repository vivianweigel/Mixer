SET NAMES utf8mb4;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS mixerdb;
CREATE SCHEMA mixerdb;
USE mixerdb;

CREATE TABLE Territory (
    territory VARCHAR(50) PRIMARY KEY,
    base_city VARCHAR(50),
    manager_id INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Employee (
    employee_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    ssn CHAR(11) UNIQUE,
    email VARCHAR(50) UNIQUE,
    territory VARCHAR(50),
    FOREIGN KEY (territory) REFERENCES Territory(territory)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Users (
    user_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    username VARCHAR(50) UNIQUE,
    email VARCHAR(50) UNIQUE,
    territory VARCHAR(50),
    FOREIGN KEY (territory) REFERENCES Territory(territory)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE User_stats (
    user_id INTEGER PRIMARY KEY,
    date_created DATETIME DEFAULT CURRENT_TIMESTAMP,
    time_on_app FLOAT,
    avg_rating FLOAT,
    num_recipes INTEGER,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
            ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Recipes (
    recipe_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    recipe_name VARCHAR(100),
    skill_level VARCHAR(100),
        CONSTRAINT chk_skill CHECK (skill_level IN ('Beginner', 'Intermediate', 'Advanced', 'Pro')),
    steps MEDIUMTEXT,
    avg_rating FLOAT,
    category VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Personal_recipes (
    recipe_id INTEGER,
    recipe_name VARCHAR(100),
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER,
    verified ENUM('yes', 'no'),
    PRIMARY KEY (recipe_id, user_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
            ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
            ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Recipe_review (
    recipe_id INTEGER,
    user_id INTEGER,
    rating INTEGER,
        CONSTRAINT chk_rating CHECK (rating IN (0, 1, 2, 3, 4, 5)),
    r_comment MEDIUMTEXT,
    PRIMARY KEY (recipe_id, user_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
            ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
            ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Nutritional_info (
    ingredient_name VARCHAR(200) PRIMARY KEY,
    vegetarian ENUM('yes', 'no'),
    vegan ENUM('yes', 'no'),
    gluten_free ENUM('yes', 'no'),
    calories INTEGER,
    sugar FLOAT,
    sodium FLOAT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Ingredients (
    recipe_id INTEGER,
    ingredient_name VARCHAR(200),
    amount TEXT(1000),
    PRIMARY KEY (recipe_id, ingredient_name),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
            ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ingredient_name) REFERENCES Nutritional_info(ingredient_name)
            ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Favorite_recipes (
    recipe_id INTEGER PRIMARY KEY,
    recipe_name VARCHAR(200),
    recipe_author VARCHAR(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Users_fav_rec (
    recipe_id INTEGER,
    user_id INTEGER,
    PRIMARY KEY (recipe_id, user_id),
    FOREIGN KEY (recipe_id) REFERENCES Favorite_recipes(recipe_id)
            ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
            ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Cuisines (
    cuisine_id INTEGER AUTO_INCREMENT PRIMARY KEY,
    cuisine_name VARCHAR(100),
    cuisine_description MEDIUMTEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Cuis_rec (
    recipe_id INTEGER,
    cuisine_id INTEGER,
    PRIMARY KEY (recipe_id, cuisine_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
            ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cuisine_id) REFERENCES Cuisines(cuisine_id)
            ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Tags (
    tag_name VARCHAR(100) PRIMARY KEY,
    tag_description MEDIUMTEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Tag_rec (
    recipe_id INTEGER,
    tag_name VARCHAR(100),
    PRIMARY KEY (recipe_id, tag_name),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
            ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (tag_name) REFERENCES Tags(tag_name)
            ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# Inserting into territory
INSERT INTO Territory (territory, base_city, manager_id)
VALUES ('United States', 'Denver', 53);
INSERT INTO Territory (territory, base_city, manager_id)
VALUES ('Canada', 'Vancouver', 22);
INSERT INTO Territory (territory, base_city, manager_id)
VALUES ('Mexico', 'Mexico City', 97);

# inserting into employee
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (1,'Marne','Trask','705-10-6208','mtrask0@blogs.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (2,'Arlyne','Wrixon','337-54-7070','awrixon1@nydailynews.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (3,'Sal','Danforth','653-43-4498','sdanforth2@sohu.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (4,'Byrom','Tchaikovsky','312-78-8727','btchaikovsky3@time.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (5,'Marie','Aubri','175-42-6767','maubri4@unesco.org','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (6,'Patrice','Cockin','195-55-1227','pcockin5@weather.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (7,'Boniface','Verrick','132-62-4886','bverrick6@mac.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (8,'Baryram','Jimson','361-50-5079','bjimson7@hugedomains.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (9,'Adriane','Ripley','486-41-7413','aripley8@jimdo.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (10,'Daren','Holyland','728-67-4881','dholyland9@telegraph.co.uk','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (11,'Wat','Cheak','579-94-7169','wcheaka@e-recht24.de','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (12,'Edithe','Sirmon','625-41-7713','esirmonb@cam.ac.uk','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (13,'Farah','Oger','358-81-8180','fogerc@g.co','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (14,'Fey','Matchett','846-84-9024','fmatchettd@deviantart.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (15,'Gris','Alvarez','803-54-6389','galvareze@posterous.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (16,'Elaina','Skelington','713-48-4701','eskelingtonf@phoca.cz','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (17,'Joella','Nezey','662-74-8680','jnezeyg@ifeng.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (18,'Cletis','Plum','356-72-0846','cplumh@wunderground.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (19,'Jack','Lockie','526-53-8427','jlockiei@eventbrite.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (20,'Danie','Croutear','617-17-4270','dcroutearj@icio.us','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (21,'Norine','Tozer','494-26-5573','ntozerk@blogs.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (22,'Donelle','Cornil','361-83-4339','dcornill@mediafire.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (23,'Emery','Boyes','845-17-1462','eboyesm@dailymail.co.uk','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (24,'Englebert','Stickland','474-62-2972','esticklandn@state.tx.us','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (25,'Juditha','Pallis','794-19-6557','jpalliso@yellowpages.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (26,'Moshe','Legion','419-91-1632','mlegionp@google.ru','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (27,'Benedicta','Ellard','317-52-0485','bellardq@ycombinator.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (28,'Angus','Sent','687-32-4505','asentr@woothemes.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (29,'Bambi','Clemmey','716-39-0351','bclemmeys@bloomberg.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (30,'Cyndie','Beadman','284-18-1922','cbeadmant@1688.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (31,'Alley','Tollit','406-31-4349','atollitu@dell.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (32,'Kipper','Stibbs','872-09-1564','kstibbsv@buzzfeed.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (33,'Adriana','Lintott','703-74-9001','alintottw@is.gd','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (34,'Osbourn','MacMeeking','225-93-0756','omacmeekingx@rediff.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (35,'Dewie','Siddon','284-49-5306','dsiddony@theglobeandmail.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (36,'Theadora','Croll','898-12-5824','tcrollz@deliciousdays.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (37,'Julie','Bloom','330-77-2082','jbloom10@theglobeandmail.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (38,'Sabine','Clearley','655-79-9546','sclearley11@amazonaws.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (39,'Estella','Haggus','243-06-0451','ehaggus12@hexun.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (40,'Baily','Strand','202-98-4068','bstrand13@newyorker.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (41,'Elisabetta','Sherred','834-37-9012','esherred14@columbia.edu','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (42,'Leanor','Wife','270-85-7272','lwife15@tuttocitta.it','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (43,'Andeee','Nicolson','449-47-1836','anicolson16@taobao.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (44,'Theresina','Firebrace','388-91-5268','tfirebrace17@cafepress.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (45,'Drusilla','Scown','878-55-1468','dscown18@bbb.org','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (46,'Anabel','Laroux','703-09-3204','alaroux19@cafepress.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (47,'Grayce','Gipp','488-92-5101','ggipp1a@twitpic.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (48,'Christiana','Legg','685-94-1262','clegg1b@freewebs.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (49,'Vaclav','Andryushin','628-10-3539','vandryushin1c@google.ru','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (50,'Diane','Hynam','226-72-7681','dhynam1d@dot.gov','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (51,'Gena','Ince','586-08-6669','gince1e@vistaprint.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (52,'Ryann','Bedbury','688-55-7383','rbedbury1f@netlog.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (53,'Basia','Carrigan','126-37-8874','bcarrigan1g@flickr.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (54,'Pace','Gauntlett','175-97-5513','pgauntlett1h@sciencedaily.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (55,'Arty','Gheorghie','288-40-0689','agheorghie1i@tiny.cc','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (56,'Bale','Kleinzweig','170-04-7189','bkleinzweig1j@wiley.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (57,'Natasha','Kerwood','269-74-8303','nkerwood1k@behance.net','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (58,'Cloe','Ronisch','895-78-8486','cronisch1l@businesswire.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (59,'Martguerita','Licence','778-12-6786','mlicence1m@wunderground.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (60,'Grace','Toal','567-76-7801','gtoal1n@cisco.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (61,'Massimiliano','Loadman','250-25-8090','mloadman1o@hud.gov','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (62,'Lisa','Tritton','426-31-9208','ltritton1p@unesco.org','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (63,'Kellsie','Itter','594-59-5790','kitter1q@stumbleupon.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (64,'Bari','Giocannoni','314-24-5141','bgiocannoni1r@google.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (65,'Debee','Tookill','697-85-0914','dtookill1s@nsw.gov.au','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (66,'Roxie','Phlippsen','163-97-3454','rphlippsen1t@ask.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (67,'Gregory','Lambal','114-56-1570','glambal1u@toplist.cz','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (68,'Gaby','Massie','828-19-3073','gmassie1v@vistaprint.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (69,'Frederich','Scotchmer','354-41-9400','fscotchmer1w@nih.gov','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (70,'Perice','Rushbrook','257-81-7507','prushbrook1x@bloglovin.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (71,'Janella','Ramsted','279-96-4048','jramsted1y@engadget.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (72,'Linea','Dibling','305-06-8591','ldibling1z@tripod.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (73,'Haskell','Tether','436-83-3614','htether20@newsvine.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (74,'Keir','Dalgliesh','318-90-3354','kdalgliesh21@hao123.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (75,'Elvyn','Shewery','835-76-5185','eshewery22@about.me','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (76,'Kira','Sacks','774-47-9580','ksacks23@admin.ch','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (77,'Tanny','Cissen','522-04-8452','tcissen24@cpanel.net','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (78,'Zedekiah','Radclyffe','131-21-8063','zradclyffe25@examiner.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (79,'Jarrod','Greaves','899-93-9156','jgreaves26@xrea.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (80,'Dani','Chantillon','887-18-4131','dchantillon27@imgur.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (81,'Paco','Servante','451-34-4905','pservante28@thetimes.co.uk','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (82,'Marris','Chiswell','882-53-8060','mchiswell29@amazon.co.jp','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (83,'Noah','Dinneen','176-55-2832','ndinneen2a@ucoz.ru','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (84,'Frants','Hallor','810-89-1293','fhallor2b@wordpress.org','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (85,'Sayers','Swyer-Sexey','701-70-2351','sswyersexey2c@symantec.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (86,'Mendie','Polo','866-40-9560','mpolo2d@blog.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (87,'Mildrid','Romain','353-71-9031','mromain2e@kickstarter.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (88,'Waylan','Maass','249-49-1484','wmaass2f@cam.ac.uk','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (89,'Lissy','Stucksbury','362-53-3632','lstucksbury2g@drupal.org','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (90,'Roxanne','Bowness','372-09-1051','rbowness2h@plala.or.jp','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (91,'Tannie','Burgne','847-79-8524','tburgne2i@nyu.edu','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (92,'Myriam','Aiton','809-27-6487','maiton2j@nationalgeographic.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (93,'Frankie','Pethick','306-93-1497','fpethick2k@who.int','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (94,'Rhona','Tibbetts','173-30-1187','rtibbetts2l@pcworld.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (95,'Rosy','Offiler','264-53-3973','roffiler2m@youku.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (96,'Everard','Sprigging','472-43-7540','esprigging2n@xrea.com','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (97,'Traver','Dalgety','282-29-3082','tdalgety2o@mediafire.com','Mexico');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (98,'Gwyn','Wurz','706-33-4138','gwurz2p@xinhuanet.com','Canada');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (99,'Maynord','Tretter','252-20-7764','mtretter2q@i2i.jp','United States');
INSERT INTO Employee(employee_id,first_name,last_name,ssn,email,territory) VALUES (100,'Reinwald','Tolumello','288-87-8803','rtolumello2r@mozilla.org','Canada');

# Inserting into users
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (1,'Skipton','Izard','sizard0','sizard0@devhub.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (2,'Kenna','Champain','kchampain1','kchampain1@oaic.gov.au','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (3,'Hollyanne','Biggin','hbiggin2','hbiggin2@hud.gov','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (4,'Laughton','Dartnall','ldartnall3','ldartnall3@samsung.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (5,'Tedd','Whitington','twhitington4','twhitington4@fema.gov','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (6,'Chancey','Ciani','cciani5','cciani5@cam.ac.uk','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (7,'Ailina','Sesser','asesser6','asesser6@vk.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (8,'Therine','Fawckner','tfawckner7','tfawckner7@mail.ru','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (9,'Clemmy','Pick','cpick8','cpick8@elegantthemes.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (10,'Heloise','Purse','hpurse9','hpurse9@howstuffworks.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (11,'Caron','Laybourn','claybourna','claybourna@bloglines.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (12,'Rafferty','Sabati','rsabatib','rsabatib@ezinearticles.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (13,'Dicky','Ponnsett','dponnsettc','dponnsettc@ifeng.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (14,'Rhody','Broadhurst','rbroadhurstd','rbroadhurstd@spiegel.de','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (15,'Yettie','Frigot','yfrigote','yfrigote@marriott.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (16,'Nicolai','Stapleton','nstapletonf','nstapletonf@ezinearticles.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (17,'Art','Rickwood','arickwoodg','arickwoodg@odnoklassniki.ru','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (18,'Mycah','Overal','moveralh','moveralh@ezinearticles.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (19,'Arin','Abbitt','aabbitti','aabbitti@nba.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (20,'Rozina','Abbado','rabbadoj','rabbadoj@cdbaby.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (21,'Merwin','Massy','mmassyk','mmassyk@google.ca','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (22,'Myrwyn','Caress','mcaressl','mcaressl@nasa.gov','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (23,'Napoleon','Garretson','ngarretsonm','ngarretsonm@skyrock.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (24,'Margareta','Vasyanin','mvasyaninn','mvasyaninn@nps.gov','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (25,'Benjamin','Aldcorne','baldcorneo','baldcorneo@comsenz.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (26,'Anny','Rolley','arolleyp','arolleyp@issuu.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (27,'Roseline','Wassung','rwassungq','rwassungq@list-manage.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (28,'Meryl','Reef','mreefr','mreefr@slashdot.org','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (29,'Allene','Shallow','ashallows','ashallows@so-net.ne.jp','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (30,'Sayers','Pyser','spysert','spysert@biglobe.ne.jp','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (31,'Delly','Cruttenden','dcruttendenu','dcruttendenu@addthis.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (32,'Gunar','MacCaffery','gmaccafferyv','gmaccafferyv@hugedomains.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (33,'Sim','Warnock','swarnockw','swarnockw@pbs.org','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (34,'Marguerite','Plose','mplosex','mplosex@wordpress.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (35,'Garald','Erett','geretty','geretty@spiegel.de','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (36,'Rollin','Gulberg','rgulbergz','rgulbergz@livejournal.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (37,'Cristi','Fishbourne','cfishbourne10','cfishbourne10@hugedomains.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (38,'Shurlocke','Keightley','skeightley11','skeightley11@bigcartel.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (39,'Olga','Summerside','osummerside12','osummerside12@ucoz.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (40,'Hope','Bendel','hbendel13','hbendel13@earthlink.net','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (41,'Livvy','Belcham','lbelcham14','lbelcham14@walmart.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (42,'Corabel','Puncher','cpuncher15','cpuncher15@discovery.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (43,'Raye','Aiston','raiston16','raiston16@webs.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (44,'Morie','Ranger','mranger17','mranger17@newsvine.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (45,'Lauree','Jeffers','ljeffers18','ljeffers18@wordpress.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (46,'Peyton','Kimmel','pkimmel19','pkimmel19@friendfeed.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (47,'Glynn','McKeand','gmckeand1a','gmckeand1a@mayoclinic.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (48,'Moina','Ravenshear','mravenshear1b','mravenshear1b@joomla.org','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (49,'Fleurette','Attow','fattow1c','fattow1c@jiathis.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (50,'Josselyn','Ganter','jganter1d','jganter1d@tripod.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (51,'Jorry','Hadlee','jhadlee1e','jhadlee1e@devhub.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (52,'Isabella','Mitchley','imitchley1f','imitchley1f@pinterest.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (53,'Vladimir','Woollaston','vwoollaston1g','vwoollaston1g@soundcloud.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (54,'Jewell','Bernardo','jbernardo1h','jbernardo1h@freewebs.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (55,'Nolie','Mattingson','nmattingson1i','nmattingson1i@ted.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (56,'Kele','Ickovits','kickovits1j','kickovits1j@shutterfly.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (57,'Shara','Atwel','satwel1k','satwel1k@slashdot.org','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (58,'Pate','Cleife','pcleife1l','pcleife1l@bloglines.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (59,'Elfie','Porkiss','eporkiss1m','eporkiss1m@quantcast.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (60,'Lowrance','MacCafferky','lmaccafferky1n','lmaccafferky1n@biglobe.ne.jp','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (61,'Agnes','Pallasch','apallasch1o','apallasch1o@digg.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (62,'Dorita','Venturoli','dventuroli1p','dventuroli1p@dell.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (63,'Eadith','Doe','edoe1q','edoe1q@harvard.edu','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (64,'Lydie','Barlas','lbarlas1r','lbarlas1r@home.pl','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (65,'Yard','Beckingham','ybeckingham1s','ybeckingham1s@list-manage.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (66,'Carita','Eggers','ceggers1t','ceggers1t@springer.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (67,'Selene','Goodredge','sgoodredge1u','sgoodredge1u@squidoo.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (68,'Saul','Stedell','sstedell1v','sstedell1v@dell.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (69,'Morgen','Peatt','mpeatt1w','mpeatt1w@networksolutions.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (70,'Ravid','Twiname','rtwiname1x','rtwiname1x@nsw.gov.au','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (71,'Dominica','Bracchi','dbracchi1y','dbracchi1y@sohu.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (72,'Bartlet','Phillipson','bphillipson1z','bphillipson1z@engadget.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (73,'Tabby','Falconar','tfalconar20','tfalconar20@loc.gov','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (74,'Emalia','Bodocs','ebodocs21','ebodocs21@mapquest.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (75,'Ode','Simner','osimner22','osimner22@ucoz.ru','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (76,'Myrle','Kitto','mkitto23','mkitto23@hubpages.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (77,'Pavlov','Soloway','psoloway24','psoloway24@histats.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (78,'Inesita','Calcutt','icalcutt25','icalcutt25@upenn.edu','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (79,'Annecorinne','Malitrott','amalitrott26','amalitrott26@ezinearticles.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (80,'Gisella','Tomaszewski','gtomaszewski27','gtomaszewski27@scientificamerican.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (81,'Lodovico','Castanares','lcastanares28','lcastanares28@theglobeandmail.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (82,'Kathy','Killner','kkillner29','kkillner29@opensource.org','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (83,'Shalom','Kemmis','skemmis2a','skemmis2a@shinystat.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (84,'Justina','Ticic','jticic2b','jticic2b@icio.us','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (85,'Jermain','Binnes','jbinnes2c','jbinnes2c@wufoo.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (86,'Anette','Jouaneton','ajouaneton2d','ajouaneton2d@privacy.gov.au','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (87,'Grange','Vanyukhin','gvanyukhin2e','gvanyukhin2e@cmu.edu','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (88,'Blondie','Arnoult','barnoult2f','barnoult2f@yandex.ru','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (89,'Ariela','Heisman','aheisman2g','aheisman2g@npr.org','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (90,'Madeleine','Cretney','mcretney2h','mcretney2h@amazon.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (91,'Elmira','Lymer','elymer2i','elymer2i@cyberchimps.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (92,'Carlie','Stopforth','cstopforth2j','cstopforth2j@printfriendly.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (93,'Rycca','Abthorpe','rabthorpe2k','rabthorpe2k@dmoz.org','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (94,'Dale','Rapley','drapley2l','drapley2l@ocn.ne.jp','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (95,'Bar','Gatfield','bgatfield2m','bgatfield2m@phoca.cz','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (96,'Christoph','Brehat','cbrehat2n','cbrehat2n@spiegel.de','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (97,'Rosie','Jesson','rjesson2o','rjesson2o@163.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (98,'Jaymee','Dessaur','jdessaur2p','jdessaur2p@aboutads.info','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (99,'Lennard','Barcroft','lbarcroft2q','lbarcroft2q@fastcompany.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (100,'Lynea','Downer','ldowner2r','ldowner2r@japanpost.jp','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (101,'Timothee','Hanford','thanford2s','thanford2s@vk.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (102,'Melisande','Derrington','mderrington2t','mderrington2t@nytimes.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (103,'Coriss','Garstang','cgarstang2u','cgarstang2u@slideshare.net','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (104,'Colet','Mordie','cmordie2v','cmordie2v@godaddy.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (105,'Ezekiel','Elphick','eelphick2w','eelphick2w@apple.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (106,'Schuyler','O''Fogerty','sofogerty2x','sofogerty2x@amazon.co.jp','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (107,'Goran','Ostler','gostler2y','gostler2y@sciencedirect.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (108,'Jeffie','Yeowell','jyeowell2z','jyeowell2z@multiply.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (109,'Brittni','Gyorgy','bgyorgy30','bgyorgy30@alibaba.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (110,'Alyss','Vincent','avincent31','avincent31@unblog.fr','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (111,'Boycie','Robinett','brobinett32','brobinett32@sun.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (112,'Gui','Wasteney','gwasteney33','gwasteney33@mayoclinic.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (113,'Hussein','Barrowcliff','hbarrowcliff34','hbarrowcliff34@skype.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (114,'Kliment','Esselen','kesselen35','kesselen35@rambler.ru','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (115,'Casar','Skoate','cskoate36','cskoate36@chron.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (116,'Catlin','Merkle','cmerkle37','cmerkle37@netlog.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (117,'Peria','Shiliton','pshiliton38','pshiliton38@blog.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (118,'Lewes','Dodsley','ldodsley39','ldodsley39@sbwire.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (119,'Genevra','Tulloch','gtulloch3a','gtulloch3a@businessinsider.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (120,'Estrellita','Witson','ewitson3b','ewitson3b@telegraph.co.uk','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (121,'Candis','Dinse','cdinse3c','cdinse3c@myspace.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (122,'Bale','Jones','bjones3d','bjones3d@mysql.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (123,'Cecile','Baszkiewicz','cbaszkiewicz3e','cbaszkiewicz3e@miitbeian.gov.cn','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (124,'Faina','Brownett','fbrownett3f','fbrownett3f@berkeley.edu','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (125,'Noelyn','Berka','nberka3g','nberka3g@simplemachines.org','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (126,'Geoff','Warbey','gwarbey3h','gwarbey3h@clickbank.net','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (127,'Koral','Russen','krussen3i','krussen3i@a8.net','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (128,'Rosmunda','Redborn','rredborn3j','rredborn3j@tripadvisor.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (129,'Heidie','Todd','htodd3k','htodd3k@slashdot.org','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (130,'Atlanta','Augur','aaugur3l','aaugur3l@feedburner.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (131,'Abba','Garth','agarth3m','agarth3m@bloomberg.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (132,'Maighdiln','Grunder','mgrunder3n','mgrunder3n@bravesites.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (133,'Marjie','Vannoni','mvannoni3o','mvannoni3o@mtv.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (134,'Rivi','Boyde','rboyde3p','rboyde3p@google.it','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (135,'Tine','Shuttle','tshuttle3q','tshuttle3q@prlog.org','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (136,'Jemimah','Le Floch','jlefloch3r','jlefloch3r@livejournal.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (137,'Carlos','Averill','caverill3s','caverill3s@wsj.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (138,'Jesselyn','Foran','jforan3t','jforan3t@epa.gov','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (139,'Patsy','Gerckens','pgerckens3u','pgerckens3u@mit.edu','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (140,'Alphard','Engelmann','aengelmann3v','aengelmann3v@accuweather.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (141,'Karel','Behnecke','kbehnecke3w','kbehnecke3w@smh.com.au','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (142,'Bernardine','Dudlestone','bdudlestone3x','bdudlestone3x@canalblog.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (143,'Camila','Hiorn','chiorn3y','chiorn3y@wix.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (144,'Damian','Ivanyushin','divanyushin3z','divanyushin3z@meetup.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (145,'Alick','Handke','ahandke40','ahandke40@360.cn','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (146,'Vale','Roels','vroels41','vroels41@hao123.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (147,'Demott','Craigie','dcraigie42','dcraigie42@wordpress.org','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (148,'Theo','Mussettini','tmussettini43','tmussettini43@nationalgeographic.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (149,'Jannel','Boecke','jboecke44','jboecke44@instagram.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (150,'Vikki','Henner','vhenner45','vhenner45@tripod.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (151,'Jarrad','Tallquist','jtallquist46','jtallquist46@weebly.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (152,'Sayers','Brixey','sbrixey47','sbrixey47@nbcnews.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (153,'Ilene','Lynds','ilynds48','ilynds48@spiegel.de','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (154,'Lucine','Emmison','lemmison49','lemmison49@stanford.edu','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (155,'Dewain','Merrill','dmerrill4a','dmerrill4a@etsy.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (156,'Billie','Aubert','baubert4b','baubert4b@vimeo.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (157,'Jacqui','Bowdidge','jbowdidge4c','jbowdidge4c@constantcontact.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (158,'Cecilla','Fermin','cfermin4d','cfermin4d@spiegel.de','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (159,'Mitchel','Beadles','mbeadles4e','mbeadles4e@plala.or.jp','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (160,'Brita','Odeson','bodeson4f','bodeson4f@washingtonpost.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (161,'Inglis','Hutchinges','ihutchinges4g','ihutchinges4g@livejournal.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (162,'Oralla','Gooday','ogooday4h','ogooday4h@macromedia.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (163,'Cullan','Iacabucci','ciacabucci4i','ciacabucci4i@dell.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (164,'Jesse','Naper','jnaper4j','jnaper4j@smugmug.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (165,'Xavier','Cardno','xcardno4k','xcardno4k@ed.gov','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (166,'Emmit','Markushkin','emarkushkin4l','emarkushkin4l@phpbb.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (167,'Aguste','Mixon','amixon4m','amixon4m@cnn.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (168,'Eadie','Barnby','ebarnby4n','ebarnby4n@wikipedia.org','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (169,'Webb','Battle','wbattle4o','wbattle4o@weather.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (170,'Rochette','Jirus','rjirus4p','rjirus4p@cornell.edu','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (171,'Dreddy','Dicey','ddicey4q','ddicey4q@sphinn.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (172,'Lambert','Foot','lfoot4r','lfoot4r@cdbaby.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (173,'Lanni','Kelk','lkelk4s','lkelk4s@chron.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (174,'Ardine','Ubanks','aubanks4t','aubanks4t@forbes.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (175,'Kelsy','Dearnaley','kdearnaley4u','kdearnaley4u@usatoday.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (176,'Cobbie','Belch','cbelch4v','cbelch4v@china.com.cn','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (177,'Etta','Hebron','ehebron4w','ehebron4w@mysql.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (178,'Nat','Valente','nvalente4x','nvalente4x@usatoday.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (179,'Breena','Guard','bguard4y','bguard4y@chronoengine.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (180,'Stephine','Danforth','sdanforth4z','sdanforth4z@multiply.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (181,'Keene','McMearty','kmcmearty50','kmcmearty50@upenn.edu','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (182,'Mariette','Sweet','msweet51','msweet51@squarespace.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (183,'Holmes','Slopier','hslopier52','hslopier52@pcworld.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (184,'Madelina','Gun','mgun53','mgun53@so-net.ne.jp','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (185,'Sybilla','Kingswoode','skingswoode54','skingswoode54@dedecms.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (186,'Filia','De Ferrari','fdeferrari55','fdeferrari55@cdc.gov','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (187,'Nealon','Sparrowe','nsparrowe56','nsparrowe56@printfriendly.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (188,'Jerry','Simione','jsimione57','jsimione57@lulu.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (189,'Cordy','Pietzker','cpietzker58','cpietzker58@intel.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (190,'Thea','Birkinshaw','tbirkinshaw59','tbirkinshaw59@irs.gov','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (191,'Eugenie','Hanse','ehanse5a','ehanse5a@home.pl','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (192,'Pat','Arrandale','parrandale5b','parrandale5b@tinyurl.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (193,'Jerrylee','Coltart','jcoltart5c','jcoltart5c@stumbleupon.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (194,'Cordey','Tardiff','ctardiff5d','ctardiff5d@tinyurl.com','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (195,'Desmond','Viegas','dviegas5e','dviegas5e@ucla.edu','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (196,'Franchot','Skull','fskull5f','fskull5f@rediff.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (197,'Olenka','Huntingdon','ohuntingdon5g','ohuntingdon5g@ibm.com','United States');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (198,'Loreen','Karpf','lkarpf5h','lkarpf5h@fc2.com','Canada');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (199,'Willis','Records','wrecords5i','wrecords5i@cornell.edu','Mexico');
INSERT INTO Users(user_id,first_name,last_name,username,email,territory) VALUES (200,'Roderigo','Haistwell','rhaistwell5j','rhaistwell5j@domainmarket.com','United States');

# inserting into user stats
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (1,787,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (2,807,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (3,758,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (4,246,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (5,97,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (6,965,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (7,989,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (8,252,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (9,932,1,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (10,291,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (11,560,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (12,602,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (13,546,5,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (14,322,4,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (15,41,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (16,513,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (17,846,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (18,3,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (19,359,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (20,84,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (21,743,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (22,63,4,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (23,171,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (24,76,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (25,18,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (26,253,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (27,28,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (28,762,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (29,820,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (30,737,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (31,276,2,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (32,534,3,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (33,185,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (34,724,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (35,454,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (36,962,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (37,545,4,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (38,899,4,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (39,48,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (40,913,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (41,900,3,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (42,23,1,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (43,24,5,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (44,292,3,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (45,769,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (46,135,1,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (47,602,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (48,912,2,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (49,59,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (50,322,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (51,166,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (52,537,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (53,98,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (54,572,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (55,861,3,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (56,264,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (57,571,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (58,666,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (59,235,3,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (60,635,4,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (61,504,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (62,462,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (63,668,2,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (64,667,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (65,408,1,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (66,920,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (67,446,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (68,674,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (69,437,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (70,4,5,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (71,246,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (72,268,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (73,302,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (74,892,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (75,583,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (76,308,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (77,400,3,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (78,624,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (79,252,2,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (80,382,2,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (81,174,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (82,264,1,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (83,508,3,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (84,912,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (85,971,3,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (86,477,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (87,859,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (88,637,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (89,847,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (90,863,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (91,456,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (92,522,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (93,26,1,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (94,877,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (95,778,3,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (96,404,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (97,109,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (98,162,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (99,780,1,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (100,331,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (101,672,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (102,408,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (103,173,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (104,326,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (105,104,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (106,918,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (107,359,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (108,339,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (109,961,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (110,880,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (111,881,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (112,90,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (113,754,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (114,762,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (115,909,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (116,595,1,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (117,761,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (118,759,1,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (119,651,3,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (120,533,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (121,871,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (122,678,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (123,403,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (124,974,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (125,927,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (126,232,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (127,558,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (128,331,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (129,951,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (130,420,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (131,372,2,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (132,925,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (133,229,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (134,762,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (135,673,4,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (136,11,4,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (137,646,4,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (138,721,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (139,216,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (140,961,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (141,589,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (142,782,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (143,81,4,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (144,828,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (145,260,1,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (146,597,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (147,568,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (148,345,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (149,363,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (150,962,4,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (151,529,4,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (152,512,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (153,73,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (154,910,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (155,317,4,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (156,862,3,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (157,501,3,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (158,58,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (159,167,2,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (160,405,4,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (161,251,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (162,757,3,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (163,75,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (164,385,1,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (165,832,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (166,182,4,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (167,520,1,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (168,835,5,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (169,316,1,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (170,576,2,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (171,172,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (172,670,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (173,174,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (174,890,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (175,835,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (176,698,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (177,279,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (178,820,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (179,432,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (180,202,4,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (181,959,3,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (182,872,2,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (183,893,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (184,243,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (185,753,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (186,217,2,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (187,882,3,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (188,48,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (189,199,1,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (190,649,2,1);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (191,613,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (192,672,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (193,624,5,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (194,519,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (195,426,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (196,184,4,2);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (197,867,5,4);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (198,692,1,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (199,857,2,3);
INSERT INTO User_stats(user_id,time_on_app,avg_rating,num_recipes) VALUES (200,127,2,1);

# inserting into recipes
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (1,'est risus auctor sed tristique','Advanced','Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.',2,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (2,'ut suscipit a feugiat','Advanced','Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.',2,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (3,'mus etiam vel augue','Pro','Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.',4,'french');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (4,'ornare','Pro','Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.',5,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (5,'platea','Advanced','Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.',1,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (6,'porttitor','Pro','Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',1,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (7,'ut tellus nulla ut','Beginner','In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.',3,'chinese');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (8,'quam sapien','Advanced','Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.',4,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (9,'curabitur gravida','Advanced','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',2,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (10,'curabitur','Advanced','Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.',5,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (11,'amet sapien dignissim vestibulum vestibulum','Advanced','Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',4,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (12,'diam cras','Beginner','Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.',2,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (13,'curae donec pharetra magna','Pro','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.',3,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (14,'luctus tincidunt nulla','Pro','Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.',2,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (15,'justo','Intermediate','Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',3,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (16,'elit ac','Beginner','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',5,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (17,'sapien','Beginner','Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.',2,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (18,'pede justo eu','Pro','Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.',5,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (19,'in quam fringilla rhoncus mauris','Intermediate','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.',5,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (20,'ultrices vel augue','Beginner','Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.',5,'chinese');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (21,'id justo sit amet','Advanced','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.',4,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (22,'venenatis non sodales sed','Intermediate','Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.',5,'chinese');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (23,'quis augue luctus tincidunt','Intermediate','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',4,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (24,'sollicitudin mi sit amet lobortis','Pro','Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.',3,'french');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (25,'vestibulum ac est','Advanced','Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.',2,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (26,'convallis nulla neque libero','Beginner','Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.',2,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (27,'molestie lorem','Pro','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',4,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (28,'justo morbi ut odio','Advanced','Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.',2,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (29,'eros viverra eget','Beginner','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',3,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (30,'nulla eget','Intermediate','Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.',4,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (31,'accumsan','Pro','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.',5,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (32,'aenean auctor gravida sem','Pro','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',1,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (33,'phasellus in','Advanced','In congue. Etiam justo. Etiam pretium iaculis justo.',4,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (34,'consequat varius','Beginner','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.',4,'chinese');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (35,'ultrices posuere cubilia curae nulla','Advanced','Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.',2,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (36,'in libero ut massa volutpat','Beginner','In congue. Etiam justo. Etiam pretium iaculis justo.',1,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (37,'suspendisse potenti in eleifend','Advanced','Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.',3,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (38,'eget orci vehicula condimentum curabitur','Advanced','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.',1,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (39,'nibh in hac habitasse platea','Intermediate','Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.',1,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (40,'vel dapibus','Intermediate','Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.',3,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (41,'sapien ut nunc vestibulum','Advanced','In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.',5,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (42,'est donec odio justo sollicitudin','Beginner','Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.',4,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (43,'leo pellentesque ultrices mattis','Beginner','Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.',3,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (44,'egestas','Pro','Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',5,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (45,'luctus rutrum nulla tellus in','Pro','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.',2,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (46,'tellus semper interdum mauris ullamcorper','Intermediate','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',2,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (47,'quis','Intermediate','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',1,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (48,'in lectus','Advanced','In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.',4,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (49,'eget tempus','Beginner','Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.',5,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (50,'faucibus orci luctus et','Pro','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.',2,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (51,'risus auctor','Beginner','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',5,'chinese');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (52,'a suscipit nulla elit ac','Intermediate','In congue. Etiam justo. Etiam pretium iaculis justo.',3,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (53,'platea dictumst etiam faucibus cursus','Pro','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.',1,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (54,'condimentum curabitur in libero','Intermediate','Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.',2,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (55,'ac enim in','Intermediate','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',4,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (56,'praesent blandit','Advanced','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.',3,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (57,'massa volutpat','Beginner','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.',4,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (58,'aenean auctor gravida','Advanced','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.',3,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (59,'velit id pretium iaculis diam','Pro','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.',5,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (60,'sit','Beginner','In congue. Etiam justo. Etiam pretium iaculis justo.',5,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (61,'odio curabitur convallis duis','Pro','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.',5,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (62,'vitae','Pro','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.',4,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (63,'pellentesque','Beginner','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.',3,'chinese');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (64,'eget massa tempor convallis','Advanced','Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.',2,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (65,'semper sapien a libero nam','Intermediate','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.',3,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (66,'posuere nonummy integer non','Beginner','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.',4,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (67,'molestie nibh in lectus pellentesque','Intermediate','Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.',2,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (68,'sodales','Intermediate','Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.',2,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (69,'consequat in consequat ut','Beginner','Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.',4,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (70,'luctus rutrum nulla','Pro','Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.',5,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (71,'ligula','Pro','Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.',3,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (72,'eget massa tempor convallis','Pro','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.',5,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (73,'elit sodales','Beginner','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.',1,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (74,'venenatis non sodales','Beginner','Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.',1,'chinese');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (75,'rhoncus sed vestibulum','Advanced','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',3,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (76,'varius nulla facilisi cras non','Beginner','Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.',3,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (77,'dictumst etiam','Intermediate','Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.',3,'chinese');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (78,'non mi integer ac neque','Advanced','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',1,'american');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (79,'tempus vivamus in','Pro','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.',1,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (80,'eget eleifend','Pro','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',4,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (81,'vivamus vel','Beginner','Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.',1,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (82,'sapien placerat','Intermediate','Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.',1,'french');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (83,'id luctus nec molestie','Intermediate','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',4,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (84,'est phasellus sit amet erat','Advanced','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.

Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.',3,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (85,'augue','Advanced','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.

Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.',5,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (86,'vestibulum rutrum rutrum neque','Intermediate','Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.

In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.',2,'chinese');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (87,'cubilia curae mauris viverra diam','Beginner','Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.',5,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (88,'justo morbi','Intermediate','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.',5,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (89,'morbi vel lectus','Beginner','Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.',5,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (90,'sollicitudin','Advanced','Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',1,'german');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (91,'porta volutpat quam','Pro','Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.',5,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (92,'lacinia','Beginner','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',2,'french');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (93,'nullam','Beginner','Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.',1,'southern');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (94,'purus sit amet nulla quisque','Pro','In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',2,'french');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (95,'id turpis integer aliquet','Beginner','Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.

Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.',5,'mediterranean');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (96,'ut dolor morbi','Advanced','Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.',3,'french');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (97,'enim in tempor turpis nec','Advanced','In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',4,'spanish');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (98,'ut ultrices vel augue vestibulum','Intermediate','Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.',1,'italian');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (99,'quam','Beginner','Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.',1,'cajun');
INSERT INTO Recipes(recipe_id,recipe_name,skill_level,steps,avg_rating,category) VALUES (100,'lorem quisque ut erat','Pro','Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.',5,'cajun');

# inserting into personal recipes
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (1,'est risus auctor sed tristique',152,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (2,'ut suscipit a feugiat',167,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (3,'mus etiam vel augue',74,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (4,'ornare',114,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (5,'platea',73,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (6,'porttitor',64,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (7,'ut tellus nulla ut',76,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (8,'quam sapien',102,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (9,'curabitur gravida',117,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (10,'curabitur',17,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (11,'amet sapien dignissim vestibulum vestibulum',20,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (12,'diam cras',127,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (13,'curae donec pharetra magna',171,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (14,'luctus tincidunt nulla',69,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (15,'justo',74,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (16,'elit ac',42,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (17,'sapien',22,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (18,'pede justo eu',30,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (19,'in quam fringilla rhoncus mauris',192,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (20,'ultrices vel augue',109,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (21,'id justo sit amet',55,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (22,'venenatis non sodales sed',194,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (23,'quis augue luctus tincidunt',30,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (24,'sollicitudin mi sit amet lobortis',88,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (25,'vestibulum ac est',34,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (26,'convallis nulla neque libero',125,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (27,'molestie lorem',197,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (28,'justo morbi ut odio',4,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (29,'eros viverra eget',16,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (30,'nulla eget',27,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (31,'accumsan',57,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (32,'aenean auctor gravida sem',34,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (33,'phasellus in',130,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (34,'consequat varius',139,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (35,'ultrices posuere cubilia curae nulla',126,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (36,'in libero ut massa volutpat',161,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (37,'suspendisse potenti in eleifend',156,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (38,'eget orci vehicula condimentum curabitur',112,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (39,'nibh in hac habitasse platea',187,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (40,'vel dapibus',198,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (41,'sapien ut nunc vestibulum',77,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (42,'est donec odio justo sollicitudin',95,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (43,'leo pellentesque ultrices mattis',198,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (44,'egestas',60,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (45,'luctus rutrum nulla tellus in',129,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (46,'tellus semper interdum mauris ullamcorper',151,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (47,'quis',112,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (48,'in lectus',125,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (49,'eget tempus',129,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (50,'faucibus orci luctus et',7,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (51,'risus auctor',9,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (52,'a suscipit nulla elit ac',64,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (53,'platea dictumst etiam faucibus cursus',35,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (54,'condimentum curabitur in libero',7,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (55,'ac enim in',43,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (56,'praesent blandit',155,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (57,'massa volutpat',93,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (58,'aenean auctor gravida',95,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (59,'velit id pretium iaculis diam',88,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (60,'sit',61,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (61,'odio curabitur convallis duis',11,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (62,'vitae',66,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (63,'pellentesque',141,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (64,'eget massa tempor convallis',48,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (65,'semper sapien a libero nam',145,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (66,'posuere nonummy integer non',169,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (67,'molestie nibh in lectus pellentesque',107,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (68,'sodales',7,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (69,'consequat in consequat ut',17,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (70,'luctus rutrum nulla',22,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (71,'ligula',52,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (72,'eget massa tempor convallis',187,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (73,'elit sodales',65,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (74,'venenatis non sodales',152,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (75,'rhoncus sed vestibulum',150,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (76,'varius nulla facilisi cras non',187,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (77,'dictumst etiam',121,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (78,'non mi integer ac neque',115,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (79,'tempus vivamus in',171,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (80,'eget eleifend',10,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (81,'vivamus vel',109,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (82,'sapien placerat',63,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (83,'id luctus nec molestie',131,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (84,'est phasellus sit amet erat',64,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (85,'augue',155,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (86,'vestibulum rutrum rutrum neque',145,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (87,'cubilia curae mauris viverra diam',6,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (88,'justo morbi',57,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (89,'morbi vel lectus',58,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (90,'sollicitudin',141,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (91,'porta volutpat quam',95,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (92,'lacinia',115,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (93,'nullam',44,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (94,'purus sit amet nulla quisque',55,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (95,'id turpis integer aliquet',83,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (96,'ut dolor morbi',193,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (97,'enim in tempor turpis nec',39,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (98,'ut ultrices vel augue vestibulum',172,'yes');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (99,'quam',182,'no');
INSERT INTO Personal_recipes(recipe_id,recipe_name,user_id,verified) VALUES (100,'lorem quisque ut erat',15,'yes');


# inserting into recipe reviews
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (7,168,4,'Morbi non quam nec dui luctus rutrum. Nulla tellus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (27,170,5,'Praesent blandit lacinia erat.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (53,34,1,'Vivamus tortor. Duis mattis egestas metus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (39,138,3,'In hac habitasse platea dictumst.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (45,125,1,'Morbi porttitor lorem id ligula.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (46,154,3,'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (44,76,1,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (80,184,5,'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (50,196,2,'Maecenas pulvinar lobortis est.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (19,34,4,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (73,105,1,'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (22,56,5,'Morbi a ipsum.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (68,33,1,'Integer a nibh.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (20,58,5,'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (64,30,2,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (97,128,5,'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (9,118,2,'Integer ac neque. Duis bibendum.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (91,127,5,'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (74,63,5,'Vivamus vestibulum sagittis sapien.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (99,58,2,'In hac habitasse platea dictumst.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (10,33,4,'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (36,188,3,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (31,70,2,'Sed accumsan felis. Ut at dolor quis odio consequat varius.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (6,90,3,'Quisque ut erat. Curabitur gravida nisi at nibh.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (97,108,3,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (71,51,1,'Cras non velit nec nisi vulputate nonummy.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (54,39,1,'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (3,21,5,'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (17,45,2,'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (98,187,2,'Integer ac leo.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (8,9,2,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (97,160,3,'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (65,97,2,'Vestibulum rutrum rutrum neque.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (25,125,1,'Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (14,200,3,'Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (19,98,1,'Donec dapibus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (88,84,2,'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (18,119,2,'Nam dui.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (68,185,1,'Sed vel enim sit amet nunc viverra dapibus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (85,138,4,'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (82,159,2,'Ut at dolor quis odio consequat varius.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (68,86,2,'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (57,131,3,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (24,116,1,'Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (36,192,2,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (52,151,3,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (84,183,5,'Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (74,168,4,'Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (42,199,5,'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (49,169,4,'Proin eu mi. Nulla ac enim.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (51,75,4,'Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (68,11,3,'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (10,49,2,'Etiam vel augue. Vestibulum rutrum rutrum neque.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (8,54,3,'Morbi non lectus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (83,145,4,'Duis at velit eu est congue elementum. In hac habitasse platea dictumst.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (91,169,1,'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (21,127,5,'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (94,122,5,'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (87,196,5,'Nullam sit amet turpis elementum ligula vehicula consequat.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (86,24,2,'Fusce posuere felis sed lacus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (43,53,3,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (73,69,2,'Vestibulum sed magna at nunc commodo placerat.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (56,91,2,'Phasellus sit amet erat.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (78,55,2,'Donec posuere metus vitae ipsum.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (94,27,2,'Curabitur in libero ut massa volutpat convallis.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (12,176,5,'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (91,79,3,'Donec posuere metus vitae ipsum. Aliquam non mauris.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (13,195,5,'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (100,59,4,'In hac habitasse platea dictumst. Etiam faucibus cursus urna.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (48,63,1,'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (50,198,4,'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (89,182,4,'Fusce posuere felis sed lacus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (34,95,5,'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (7,153,4,'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (78,128,2,'In quis justo.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (48,20,1,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (75,81,1,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (68,113,3,'Fusce consequat. Nulla nisl.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (92,162,2,'Duis at velit eu est congue elementum. In hac habitasse platea dictumst.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (66,196,2,'Quisque id justo sit amet sapien dignissim vestibulum.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (14,18,2,'In eleifend quam a odio. In hac habitasse platea dictumst.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (33,94,5,'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (31,113,4,'In sagittis dui vel nisl. Duis ac nibh.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (75,193,2,'Integer tincidunt ante vel ipsum.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (98,93,1,'Etiam pretium iaculis justo.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (1,161,3,'Pellentesque viverra pede ac diam.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (9,112,5,'Ut tellus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (78,132,5,'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (17,96,4,'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (89,90,5,'Suspendisse accumsan tortor quis turpis. Sed ante.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (90,69,3,'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (23,18,3,'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (40,166,1,'Vivamus tortor.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (56,72,5,'Etiam vel augue.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (41,50,2,'Suspendisse potenti.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (72,65,1,'Ut at dolor quis odio consequat varius. Integer ac leo.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (17,26,2,'In hac habitasse platea dictumst.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (86,189,1,'Morbi ut odio.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (11,123,2,'Nulla suscipit ligula in lacus.');
INSERT INTO Recipe_review(recipe_id,user_id,rating,r_comment) VALUES (25,170,5,'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');

# inserting into nutritional info
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('eggs','no','yes','no',20,58,86);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('milk','no','no','no',5,80,29);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('cheese','yes','yes','no',364,77,51);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('bread','yes','no','yes',167,51,62);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('tortillas','no','yes','yes',184,96,87);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('chicken','yes','no','yes',182,3,73);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('steak','no','no','yes',347,88,41);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('ground beef','no','yes','yes',260,10,79);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('carrots','yes','no','no',96,82,27);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('zucchini','no','no','no',353,11,47);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('tomatoes','yes','yes','yes',306,7,65);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('pasta noodles','no','no','no',399,10,1);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('avocado','no','yes','no',104,23,37);
INSERT INTO Nutritional_info(ingredient_name,vegetarian,vegan,gluten_free,calories,sugar,sodium) VALUES ('oat milk','no','yes','no',404,9,9);

# inserting into ingredients
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (58,'eggs',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (100,'pasta noodles',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (97,'milk',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (49,'pasta noodles',11);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (5,'milk',14);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (19,'chicken',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (15,'cheese',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (87,'milk',4);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (53,'milk',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (93,'bread',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (41,'bread',13);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (22,'zucchini',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (10,'avocado',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (88,'zucchini',6);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (60,'chicken',11);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (85,'pasta noodles',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (45,'milk',11);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (58,'pasta noodles',1);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (57,'cheese',10);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (54,'milk',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (21,'tortillas',2);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (77,'zucchini',8);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (64,'milk',1);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (70,'cheese',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (28,'zucchini',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (51,'pasta noodles',4);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (71,'avocado',12);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (32,'bread',12);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (44,'ground beef',14);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (89,'milk',2);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (90,'zucchini',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (15,'eggs',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (77,'milk',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (66,'chicken',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (58,'avocado',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (36,'bread',8);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (35,'milk',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (100,'bread',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (27,'avocado',13);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (96,'avocado',2);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (88,'pasta noodles',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (50,'milk',20);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (82,'milk',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (74,'milk',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (80,'eggs',13);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (70,'pasta noodles',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (20,'milk',12);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (39,'bread',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (71,'milk',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (75,'chicken',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (72,'zucchini',10);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (12,'bread',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (4,'cheese',1);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (62,'milk',15);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (21,'tomatoes',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (34,'milk',14);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (86,'zucchini',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (92,'pasta noodles',10);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (91,'bread',10);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (67,'milk',20);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (43,'milk',20);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (79,'ground beef',20);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (66,'tortillas',1);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (70,'milk',4);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (28,'pasta noodles',12);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (75,'avocado',4);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (92,'zucchini',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (6,'cheese',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (7,'tortillas',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (17,'cheese',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (64,'avocado',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (15,'bread',13);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (2,'zucchini',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (79,'avocado',14);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (25,'pasta noodles',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (49,'milk',1);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (99,'milk',10);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (99,'bread',8);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (91,'tortillas',4);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (31,'zucchini',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (12,'milk',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (42,'tomatoes',12);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (63,'ground beef',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (41,'milk',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (3,'chicken',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (51,'milk',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (96,'eggs',20);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (70,'tortillas',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (26,'avocado',6);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (19,'tomatoes',13);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (32,'chicken',13);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (5,'avocado',11);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (44,'bread',15);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (97,'pasta noodles',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (84,'ground beef',2);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (1,'bread',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (29,'zucchini',15);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (91,'cheese',6);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (96,'bread',11);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (28,'avocado',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (51,'ground beef',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (100,'avocado',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (49,'bread',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (69,'eggs',20);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (67,'tortillas',19);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (77,'pasta noodles',2);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (83,'milk',6);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (95,'milk',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (36,'chicken',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (70,'eggs',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (85,'tomatoes',12);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (72,'avocado',6);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (39,'milk',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (63,'zucchini',19);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (46,'avocado',14);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (95,'bread',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (61,'tortillas',13);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (92,'tomatoes',13);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (73,'ground beef',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (53,'chicken',15);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (88,'milk',15);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (67,'zucchini',15);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (46,'milk',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (1,'milk',11);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (48,'bread',14);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (89,'bread',19);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (6,'avocado',11);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (39,'zucchini',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (63,'bread',10);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (27,'ground beef',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (91,'pasta noodles',4);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (92,'cheese',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (69,'milk',6);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (65,'zucchini',6);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (9,'avocado',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (78,'avocado',11);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (16,'milk',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (86,'ground beef',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (68,'bread',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (67,'tomatoes',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (28,'chicken',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (86,'bread',19);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (32,'zucchini',6);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (16,'pasta noodles',2);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (73,'zucchini',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (59,'pasta noodles',11);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (48,'tortillas',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (65,'eggs',10);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (69,'bread',19);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (81,'milk',3);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (39,'pasta noodles',14);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (78,'milk',2);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (66,'pasta noodles',18);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (75,'tomatoes',8);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (27,'milk',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (53,'ground beef',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (33,'zucchini',2);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (7,'eggs',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (68,'avocado',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (23,'pasta noodles',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (80,'milk',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (1,'avocado',14);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (84,'bread',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (12,'zucchini',6);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (75,'milk',20);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (9,'milk',16);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (92,'ground beef',13);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (57,'bread',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (88,'tortillas',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (54,'zucchini',8);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (33,'milk',1);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (73,'avocado',9);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (83,'bread',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (50,'avocado',17);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (74,'chicken',5);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (85,'eggs',7);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (80,'tortillas',15);
INSERT INTO Ingredients(recipe_id,ingredient_name,amount) VALUES (23,'milk',6);

# favorite recipes
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (1,'est risus auctor sed tristique','Herta Rigard');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (2,'ut suscipit a feugiat','Doreen Tuttle');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (3,'mus etiam vel augue','Feodora Portwaine');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (4,'ornare','Natalee Scawen');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (5,'platea','Helli Brinkley');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (6,'porttitor','Annamaria Pandya');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (7,'ut tellus nulla ut','Jerry Anscombe');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (8,'quam sapien','Patton Markson');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (9,'curabitur gravida','Rica Ekkel');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (10,'curabitur','Marco Krochmann');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (11,'amet sapien dignissim vestibulum vestibulum','Branden Laver');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (12,'diam cras','Briggs Baglow');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (13,'curae donec pharetra magna','Shela Lamminam');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (14,'luctus tincidunt nulla','Gwen Dorcey');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (15,'justo','Melva Rossborough');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (16,'elit ac','Rebeca Blomfield');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (17,'sapien','Ceil O''Devey');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (18,'pede justo eu','Hamnet O''Garmen');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (19,'in quam fringilla rhoncus mauris','Barrie Angerstein');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (20,'ultrices vel augue','Tom Lehrmann');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (21,'id justo sit amet','Karla Bywater');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (22,'venenatis non sodales sed','Hoebart Warburton');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (23,'quis augue luctus tincidunt','Vyky Crowson');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (24,'sollicitudin mi sit amet lobortis','Nicoline Danielian');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (25,'vestibulum ac est','Gib Rigglesford');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (26,'convallis nulla neque libero','Meir Dashkovich');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (27,'molestie lorem','Marin Gabbitas');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (28,'justo morbi ut odio','Cele Beddow');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (29,'eros viverra eget','Morgana Hairs');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (30,'nulla eget','Bron Angell');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (31,'accumsan','Jordana Welbourn');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (32,'aenean auctor gravida sem','Shirley Halkyard');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (33,'phasellus in','Linnell Romney');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (34,'consequat varius','Ive Caroline');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (35,'ultrices posuere cubilia curae nulla','Fiona Capnerhurst');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (36,'in libero ut massa volutpat','Cayla Tilston');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (37,'suspendisse potenti in eleifend','Lizbeth Sawkin');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (38,'eget orci vehicula condimentum curabitur','Kasey Dericot');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (39,'nibh in hac habitasse platea','Sloan Hazard');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (40,'vel dapibus','Any Merryweather');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (41,'sapien ut nunc vestibulum','Malcolm Eschalotte');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (42,'est donec odio justo sollicitudin','Brendin Daspar');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (43,'leo pellentesque ultrices mattis','Theobald Hugle');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (44,'egestas','Regen Beckson');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (45,'luctus rutrum nulla tellus in','Sasha Noades');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (46,'tellus semper interdum mauris ullamcorper','Kendricks Pudan');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (47,'quis','Marena Label');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (48,'in lectus','Benita Leaf');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (49,'eget tempus','Blondelle Robbey');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (50,'faucibus orci luctus et','Jaime Rosenfield');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (51,'risus auctor','Scarface Gowthrop');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (52,'a suscipit nulla elit ac','Lucy Dawes');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (53,'platea dictumst etiam faucibus cursus','Kaja Biggen');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (54,'condimentum curabitur in libero','King Bunford');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (55,'ac enim in','Krystalle Theobalds');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (56,'praesent blandit','Nolie Jahnig');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (57,'massa volutpat','Felice Huddy');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (58,'aenean auctor gravida','Aloise Speeks');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (59,'velit id pretium iaculis diam','Sissie Skermer');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (60,'sit','Ann-marie Claire');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (61,'odio curabitur convallis duis','Kelley Ruusa');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (62,'vitae','Richmound Oldknowe');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (63,'pellentesque','Dagny Humpherson');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (64,'eget massa tempor convallis','Frank Hymor');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (65,'semper sapien a libero nam','Dexter Maseyk');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (66,'posuere nonummy integer non','Effie Eickhoff');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (67,'molestie nibh in lectus pellentesque','Wallis Kwietak');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (68,'sodales','Del Handy');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (69,'consequat in consequat ut','Hodge Squirrel');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (70,'luctus rutrum nulla','Frasco Hedworth');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (71,'ligula','Idalina Pernell');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (72,'eget massa tempor convallis','Lorianna Alvey');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (73,'elit sodales','Madelle Edwardes');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (74,'venenatis non sodales','Elbertine Kobierski');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (75,'rhoncus sed vestibulum','Cecilio Murison');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (76,'varius nulla facilisi cras non','Gloria Corris');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (77,'dictumst etiam','Martguerita Urry');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (78,'non mi integer ac neque','Genevieve Addess');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (79,'tempus vivamus in','Verne Fetherston');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (80,'eget eleifend','Adolphe Eskrigg');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (81,'vivamus vel','Sabine Costerd');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (82,'sapien placerat','Jen Mulrean');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (83,'id luctus nec molestie','Carmencita Sket');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (84,'est phasellus sit amet erat','Gwenora Chedzoy');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (85,'augue','Ruben Abell');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (86,'vestibulum rutrum rutrum neque','Pansy Guillem');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (87,'cubilia curae mauris viverra diam','Andeee Graveney');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (88,'justo morbi','Dewie Girkin');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (89,'morbi vel lectus','Jacenta Demoge');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (90,'sollicitudin','Karrah Brose');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (91,'porta volutpat quam','Bridgette Caldwell');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (92,'lacinia','Kamilah Rebeiro');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (93,'nullam','Tabbitha Benedicte');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (94,'purus sit amet nulla quisque','Wenda McGraffin');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (95,'id turpis integer aliquet','Prescott Sheen');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (96,'ut dolor morbi','Vaughn Lydon');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (97,'enim in tempor turpis nec','Clare Mc Carrick');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (98,'ut ultrices vel augue vestibulum','Amalita Pallas');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (99,'quam','Alex Poulsom');
INSERT INTO Favorite_recipes(recipe_id,recipe_name,recipe_author) VALUES (100,'lorem quisque ut erat','Madelene Randales');

# user favorite recipies bridge table insert
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (45,162);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (63,103);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (88,17);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (100,64);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (89,92);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (31,144);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (41,2);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (72,142);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (17,46);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (83,173);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (11,96);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (71,100);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (67,148);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (94,132);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (82,26);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (66,18);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (34,194);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (79,97);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (26,72);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (96,77);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (65,43);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (89,118);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (2,172);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (1,101);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (53,141);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (72,200);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (75,80);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (1,23);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (60,148);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (63,132);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (37,46);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (87,198);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (12,87);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (50,32);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (63,144);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (8,165);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (2,29);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (24,188);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (55,19);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (79,148);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (23,25);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (99,100);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (55,134);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (14,5);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (41,33);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (7,45);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (5,18);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (3,88);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (44,26);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (82,9);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (45,41);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (80,64);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (93,7);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (44,83);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (43,71);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (59,187);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (90,184);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (99,200);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (25,61);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (88,27);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (44,109);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (42,64);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (22,129);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (99,173);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (58,139);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (46,146);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (23,128);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (28,141);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (96,101);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (60,89);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (5,56);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (72,167);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (96,156);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (100,109);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (67,76);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (52,80);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (99,105);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (82,61);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (39,176);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (2,187);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (40,123);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (21,168);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (35,190);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (10,101);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (67,45);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (51,108);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (63,60);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (91,7);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (58,172);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (22,93);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (39,22);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (36,120);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (56,78);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (32,2);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (41,107);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (12,44);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (33,151);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (43,195);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (55,179);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (83,33);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (96,182);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (32,100);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (71,77);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (37,51);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (92,175);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (45,34);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (75,79);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (10,9);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (22,26);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (8,96);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (29,166);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (10,30);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (64,13);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (13,175);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (35,138);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (30,161);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (100,169);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (17,48);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (4,179);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (80,154);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (60,62);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (46,182);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (52,28);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (39,157);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (77,42);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (8,40);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (70,125);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (26,147);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (1,70);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (62,128);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (43,112);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (22,86);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (60,52);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (28,71);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (58,189);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (74,98);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (26,185);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (92,136);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (42,150);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (3,21);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (79,87);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (68,94);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (54,200);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (89,31);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (75,158);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (45,110);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (5,61);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (17,81);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (19,76);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (37,60);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (91,115);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (4,24);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (49,103);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (8,162);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (2,126);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (22,11);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (20,159);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (24,109);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (75,5);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (89,108);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (70,96);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (60,168);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (48,17);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (49,149);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (96,23);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (15,88);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (74,144);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (54,175);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (26,181);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (14,30);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (12,108);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (47,141);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (28,184);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (69,2);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (10,72);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (5,48);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (46,26);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (17,67);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (68,161);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (65,175);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (25,196);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (69,68);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (94,34);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (66,168);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (71,56);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (5,51);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (97,198);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (74,27);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (99,57);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (34,164);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (43,180);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (13,44);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (1,79);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (39,135);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (47,7);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (58,69);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (55,190);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (89,120);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (80,8);
INSERT INTO Users_fav_rec(recipe_id,user_id) VALUES (5,12);

# cuisines insert
INSERT INTO Cuisines(cuisine_id,cuisine_name,cuisine_description) VALUES (1,'italian','Nunc rhoncus dui vel sem.');
INSERT INTO Cuisines(cuisine_id,cuisine_name,cuisine_description) VALUES (2,'chinese','Nunc nisl.');
INSERT INTO Cuisines(cuisine_id,cuisine_name,cuisine_description) VALUES (3,'french','Mauris sit amet eros.');
INSERT INTO Cuisines(cuisine_id,cuisine_name,cuisine_description) VALUES (4,'american','Praesent id massa id nisl venenatis lacinia.');
INSERT INTO Cuisines(cuisine_id,cuisine_name,cuisine_description) VALUES (5,'cajun','Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO Cuisines(cuisine_id,cuisine_name,cuisine_description) VALUES (6,'southern','Maecenas pulvinar lobortis est.');
INSERT INTO Cuisines(cuisine_id,cuisine_name,cuisine_description) VALUES (7,'spanish','Aenean sit amet justo.');
INSERT INTO Cuisines(cuisine_id,cuisine_name,cuisine_description) VALUES (8,'german','In sagittis dui vel nisl.');
INSERT INTO Cuisines(cuisine_id,cuisine_name,cuisine_description) VALUES (9,'mediterranean','Nunc nisl.');

# cuisine_rec bridge table inserts
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (25,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (28,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (99,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (93,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (18,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (1,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (44,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (72,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (35,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (4,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (96,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (68,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (30,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (17,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (4,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (5,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (59,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (80,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (55,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (51,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (47,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (18,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (26,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (51,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (90,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (14,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (92,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (97,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (73,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (12,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (88,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (80,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (40,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (8,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (68,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (95,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (1,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (6,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (42,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (98,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (89,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (3,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (19,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (5,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (20,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (77,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (15,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (17,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (12,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (62,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (29,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (15,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (46,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (52,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (89,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (1,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (7,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (28,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (36,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (26,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (35,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (57,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (88,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (17,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (8,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (34,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (38,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (30,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (3,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (68,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (98,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (33,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (3,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (75,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (28,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (20,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (27,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (29,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (89,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (76,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (22,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (70,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (74,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (72,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (90,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (23,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (82,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (96,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (37,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (98,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (25,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (97,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (12,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (64,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (11,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (100,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (45,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (78,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (75,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (79,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (38,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (74,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (32,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (50,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (63,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (37,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (45,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (34,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (14,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (13,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (96,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (38,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (11,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (31,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (76,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (60,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (92,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (81,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (5,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (43,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (61,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (79,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (21,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (17,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (53,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (94,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (70,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (90,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (5,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (22,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (76,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (60,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (90,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (29,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (34,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (7,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (91,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (67,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (60,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (55,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (87,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (75,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (8,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (70,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (47,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (37,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (42,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (76,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (83,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (52,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (30,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (61,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (65,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (97,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (72,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (22,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (33,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (56,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (37,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (69,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (50,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (14,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (53,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (11,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (7,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (18,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (22,6);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (14,9);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (77,1);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (75,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (66,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (25,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (69,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (23,4);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (55,7);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (6,2);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (64,5);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (59,3);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (80,8);
INSERT INTO Cuis_rec(recipe_id,cuisine_id) VALUES (7,4);

# inserting into tags
INSERT INTO Tags(tag_name,tag_description) VALUES ('spicy','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('fun','Nam nulla.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('easy','Pellentesque ultrices mattis odio.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('date night','Integer non velit.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('girls night','Phasellus in felis.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('challenging','Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('cool','Quisque porta volutpat erat.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('adventurous','Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('delicious','In hac habitasse platea dictumst.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('movie night','Nullam varius.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('sweet treat','Donec dapibus.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('salt lover','Nulla ac enim.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('veggies','Pellentesque viverra pede ac diam.');
INSERT INTO Tags(tag_name,tag_description) VALUES ('meat luvr','Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl.');

# inserting into Tag_rec bridge table
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (25,'cool');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (48,'date night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (95,'salt lover');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (61,'challenging');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (37,'girls night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (41,'sweet treat');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (62,'fun');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (5,'delicious');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (4,'easy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (79,'meat luvr');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (38,'adventurous');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (55,'spicy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (39,'movie night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (76,'veggies');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (19,'adventurous');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (36,'date night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (90,'movie night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (100,'meat luvr');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (21,'cool');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (62,'girls night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (15,'fun');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (99,'salt lover');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (23,'challenging');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (72,'adventurous');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (63,'veggies');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (84,'sweet treat');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (91,'delicious');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (68,'easy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (79,'girls night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (81,'cool');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (49,'spicy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (8,'veggies');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (33,'fun');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (63,'salt lover');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (93,'movie night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (98,'girls night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (45,'delicious');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (32,'challenging');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (56,'adventurous');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (15,'sweet treat');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (31,'date night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (60,'meat luvr');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (51,'date night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (31,'delicious');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (44,'girls night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (5,'sweet treat');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (40,'spicy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (22,'date night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (46,'fun');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (53,'easy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (42,'challenging');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (84,'movie night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (45,'meat luvr');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (65,'salt lover');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (94,'adventurous');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (51,'spicy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (19,'meat luvr');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (52,'easy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (88,'date night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (62,'delicious');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (6,'challenging');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (36,'spicy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (47,'sweet treat');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (61,'salt lover');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (98,'fun');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (2,'girls night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (96,'adventurous');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (71,'movie night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (58,'cool');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (15,'easy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (58,'fun');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (10,'date night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (51,'challenging');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (24,'movie night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (7,'spicy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (20,'delicious');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (54,'adventurous');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (46,'sweet treat');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (8,'cool');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (96,'easy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (92,'veggies');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (42,'salt lover');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (23,'girls night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (18,'meat luvr');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (64,'easy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (87,'movie night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (6,'girls night');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (37,'adventurous');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (57,'spicy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (88,'veggies');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (11,'easy');
INSERT INTO Tag_rec(recipe_id,tag_name) VALUES (59,'fun');