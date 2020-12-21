-- Updated
-- Name 1: Laila Mashel
-- G# 1: 01127216
-- Name 2: Cristina Sorrels
-- G# 2: 01064521

--Deleting the tables
drop table Member cascade constraint;
drop table Profile cascade constraint;
drop table Watch cascade constraint;
drop table Movie cascade constraint;
drop table Genre cascade constraint;
drop table Likes_Genre cascade constraint;
drop table Movie_Genre cascade constraint;
drop table Actor cascade constraint;
drop table Starred_By cascade constraint;


CREATE TABLE Member(
	member_ID VARCHAR2(10),
	first_name VARCHAR2(50),
	last_name VARCHAR2(50),
	card_number VARCHAR2(16),
	exp_date date,
	PRIMARY KEY(member_ID));

INSERT INTO Member VALUES('dsmith', 'David', 'Smith', '1234567811223344', '04-Aug-2022');
INSERT INTO Member VALUES('ktran', 'Kevin', 'Tran', '4470921345677708', '10-Feb-2024');
INSERT INTO Member VALUES('awayne', 'Alex', 'Wayne', '8134674509905567', '15-Feb-2023');
INSERT INTO Member VALUES('jlynn', 'Joanne', 'Lynn', '7678344332238998', '25-Nov-2021');
INSERT INTO Member VALUES('cwang','Christine', 'Wang', '6564488993821221', '05-Dec-2021');
INSERT INTO Member VALUES('bnelson','Bob', 'Nelson', '3305147803980045', '22-Jan-2023');

CREATE TABLE Profile(
	member_ID VARCHAR2(10),
	profile_name VARCHAR2(10),
	PRIMARY KEY(member_ID, profile_name),
	FOREIGN KEY(member_ID) REFERENCES Member(member_ID)
		ON DELETE CASCADE);

INSERT INTO Profile VALUES('dsmith', 'David');
INSERT INTO Profile VALUES('dsmith', 'Sarah');
INSERT INTO Profile VALUES('dsmith', 'Jenny');
INSERT INTO Profile VALUES('ktran', 'Kevin');
INSERT INTO Profile VALUES('ktran', 'Jack');
INSERT INTO Profile VALUES('awayne', 'Alex');
INSERT INTO Profile VALUES('awayne', 'Lauren');
INSERT INTO Profile VALUES('awayne', 'Jack');
INSERT INTO Profile VALUES('jlynn', 'Joanne');
INSERT INTO Profile VALUES('jlynn', 'Kelly');
INSERT INTO Profile VALUES('cwang', 'Christine');
INSERT INTO Profile VALUES('cwang', 'Thomas');
INSERT INTO Profile VALUES('bnelson', 'Bob');
INSERT INTO Profile VALUES('bnelson', 'James');
INSERT INTO Profile VALUES('bnelson', 'Lilly');
INSERT INTO Profile VALUES('bnelson', 'Olivia');
INSERT INTO Profile VALUES ('bnelson', 'Khan');
INSERT INTO Profile VALUES ('bnelson', 'lmashel');

CREATE TABLE Movie(
	movie_ID VARCHAR2(10),
	title VARCHAR2(50),
	producer VARCHAR2(50),
	avg_rating DECIMAL(2,1),
	movie_year VARCHAR2(5),
	PRIMARY KEY(movie_id));

ALTER TABLE Movie
ADD CONSTRAINT check_avgrating CHECK(avg_rating>=1 AND avg_rating<=5);

INSERT INTO Movie VALUES ('tsnd', 'The Spy Next Door', 'Robert Simonds', 4.8, '2010');
INSERT INTO Movie VALUES ('zper', 'Zookeeper', 'Todd Garner', 4.1, '2011');
INSERT INTO Movie VALUES ('aqpl', 'A Quiet Place', 'Michael Bay', 3.1, '2018');
INSERT INTO Movie VALUES ('tnun', 'The Nun', 'Peter Safran', 3.5, 2018);
INSERT INTO Movie VALUES ('jwttj', 'Jumanji: Welcome To The Jungle', 'Matt Tolmach', 4.5, '2017');
INSERT INTO Movie VALUES ('asib', 'A Star Is Born', 'Bill Gerber', 3.9, '2018');
INSERT INTO Movie VALUES ('cran', 'Crazy Rich Aians', 'Nina Jacobson', 4.1, '2018');
INSERT INTO Movie VALUES ('jker', 'Joker', 'Todd Phillips', 4.8, '2019');
INSERT INTO Movie VALUES ('lucy14', 'Lucy', 'Virginie Besson Silla', 4.0, '2014');
INSERT INTO Movie VALUES ('clie', 'Central Intelligence', 'Scott Stuber', 3.9, '2016');
INSERT INTO Movie VALUES ('smisv', 'Spider-Man Into The Spider-Verse', 'Avi Arad', 4.6, '2018');
INSERT INTO Movie VALUES ('tsmd', 'The Social Media Dilemma', 'Larissa Rhodes', 4.6, '2020');

CREATE TABLE Genre(
	m_genre VARCHAR2(25),
	PRIMARY KEY(m_genre));

INSERT INTO Genre VALUES ('Comedy');
INSERT INTO Genre VALUES ('Action');
INSERT INTO Genre VALUES ('Romance');
INSERT INTO Genre VALUES ('Horror');
INSERT INTO Genre VALUES ('Thriller');
INSERT INTO Genre VALUES ('Musical');
INSERT INTO Genre VALUES ('Documentary');
INSERT INTO Genre VALUES ('Drama');
INSERT INTO Genre VALUES ('Fantasy');
INSERT INTO Genre VALUES ('Crime');
INSERT INTO Genre VALUES ('Children and Family');

CREATE TABLE Watch(
	member_ID VARCHAR2(10),
	profile_name VARCHAR2(10),
	movie_ID VARCHAR2(10),
	rating INTEGER,
	Primary KEY(member_ID, profile_name, movie_ID),
	FOREIGN KEY(member_ID, profile_name) REFERENCES Profile(member_ID, profile_name),
	FOREIGN KEY(movie_ID) REFERENCES Movie(movie_ID));

ALTER TABLE Watch
ADD CONSTRAINT check_rating CHECK(rating>=1 AND rating<=5);
    
INSERT INTO Watch VALUES ('dsmith', 'Sarah', 'tsnd', 4);
INSERT INTO Watch VALUES ('dsmith', 'Sarah', 'zper', 3);
INSERT INTO Watch VALUES ('dsmith', 'Sarah', 'aqpl', 2);
INSERT INTO Watch VALUES ('dsmith', 'Sarah', 'tnun', 3);
INSERT INTO Watch VALUES ('dsmith', 'Sarah', 'asib', 4);
INSERT INTO Watch VALUES ('dsmith', 'Jenny', 'tsnd', 3);
INSERT INTO Watch VALUES ('dsmith', 'Jenny', 'smisv', 4);
INSERT INTO Watch VALUES ('dsmith', 'Jenny', 'zper', 3);
INSERT INTO Watch VALUES ('dsmith', 'David', 'cran', 4);
INSERT INTO Watch VALUES ('ktran', 'Kevin', 'tsnd', 3);
INSERT INTO Watch VALUES ('ktran', 'Kevin', 'clie', 4);
INSERT INTO Watch VALUES ('ktran', 'Kevin', 'zper', 3);
INSERT INTO Watch VALUES ('ktran', 'Kevin', 'jwttj', 4);
INSERT INTO Watch VALUES ('ktran', 'Kevin', 'jker', 5);
INSERT INTO Watch VALUES ('ktran', 'Jack', 'zper', 4);
INSERT INTO Watch VALUES ('ktran', 'Jack', 'aqpl', 3);
INSERT INTO Watch VALUES ('ktran', 'Jack', 'tnun', 3);
INSERT INTO Watch VALUES ('awayne', 'Alex','tsnd', 3);
INSERT INTO Watch VALUES ('awayne', 'Alex','aqpl', 2);
INSERT INTO Watch VALUES ('awayne', 'Alex','tnun', 3);
INSERT INTO Watch VALUES ('awayne', 'Alex','zper', 4);
INSERT INTO Watch VALUES ('awayne', 'Alex','jker', 4);
INSERT INTO Watch VALUES ('awayne', 'Lauren', 'zper', 2);
INSERT INTO Watch VALUES ('awayne', 'Lauren', 'cran', 4);
INSERT INTO Watch VALUES ('awayne', 'Jack', 'clie', 4);
INSERT INTO Watch VALUES ('jlynn', 'Joanne', 'zper', 3);
INSERT INTO Watch VALUES ('jlynn', 'Joanne', 'jwttj', 4);
INSERT INTO Watch VALUES ('jlynn', 'Joanne', 'asib', 4);
INSERT INTO Watch VALUES ('jlynn', 'Joanne', 'cran', 5);
INSERT INTO Watch VALUES ('jlynn', 'Joanne', 'jker', 4);
INSERT INTO Watch VALUES ('jlynn', 'Joanne', 'lucy14', 5);
INSERT INTO Watch VALUES ('jlynn', 'Kelly', 'jker', 5);
INSERT INTO Watch VALUES ('jlynn', 'Kelly', 'tnun', 4);
INSERT INTO Watch VALUES ('cwang', 'Christine', 'tsnd', 3);
INSERT INTO Watch VALUES ('cwang', 'Christine', 'zper', 4);
INSERT INTO Watch VALUES ('cwang', 'Christine', 'aqpl', 3);
INSERT INTO Watch VALUES ('cwang', 'Christine', 'tnun', 3);
INSERT INTO Watch VALUES ('cwang', 'Christine', 'lucy14', 3);
INSERT INTO Watch VALUES ('cwang', 'Thomas', 'cran', 2);
INSERT INTO Watch VALUES ('bnelson', 'Bob', 'zper', 4);
INSERT INTO Watch VALUES ('bnelson', 'Bob', 'jwttj', 5);
INSERT INTO Watch VALUES ('bnelson', 'Bob', 'cran', 3);
INSERT INTO Watch VALUES ('bnelson', 'James', 'tnun', 4);
INSERT INTO Watch VALUES ('bnelson', 'James', 'smisv', 4);
INSERT INTO Watch VALUES ('bnelson', 'James', 'tsmd', 3);
INSERT INTO Watch VALUES ('bnelson', 'Lilly', 'zper', 3);
INSERT INTO Watch VALUES ('bnelson', 'Olivia', 'aqpl', 5);


CREATE TABLE Movie_Genre(
	movie_ID VARCHAR2(10),
	m_genre VARCHAR2(25),
	PRIMARY KEY(movie_ID, m_genre),
	FOREIGN KEY(m_genre) REFERENCES Genre(m_genre),
	FOREIGN KEY(movie_ID) REFERENCES Movie(movie_ID));

INSERT INTO Movie_Genre VALUES ('tsnd', 'Comedy');
INSERT INTO Movie_Genre VALUES ('tsnd', 'Action');
INSERT INTO Movie_Genre VALUES ('zper', 'Comedy');
INSERT INTO Movie_Genre VALUES ('zper', 'Romance');
INSERT INTO Movie_Genre VALUES ('aqpl', 'Horror');
INSERT INTO Movie_Genre VALUES ('tnun', 'Horror');
INSERT INTO Movie_Genre VALUES ('tnun', 'Thriller');
INSERT INTO Movie_Genre VALUES ('jwttj', 'Comedy');
INSERT INTO Movie_Genre VALUES ('jwttj', 'Action');
INSERT INTO Movie_Genre VALUES ('asib', 'Romance');
INSERT INTO Movie_Genre VALUES ('asib', 'Musical');
INSERT INTO Movie_Genre VALUES ('cran', 'Romance');
INSERT INTO Movie_Genre VALUES ('cran', 'Comedy');
INSERT INTO Movie_Genre VALUES ('jker', 'Crime');
INSERT INTO Movie_Genre VALUES ('jker', 'Drama');
INSERT INTO Movie_Genre VALUES ('lucy14', 'Thriller');
INSERT INTO Movie_Genre VALUES ('lucy14', 'Action');
INSERT INTO Movie_Genre VALUES ('clie', 'Comedy');
INSERT INTO Movie_Genre VALUES ('clie', 'Action');
INSERT INTO Movie_Genre VALUES ('tsmd', 'Documentary');


CREATE TABLE Likes_Genre(
	member_ID VARCHAR2(10),
	profile_name VARCHAR2(10),
	m_genre VARCHAR2(25),
	PRIMARY KEY(member_ID, profile_name, m_genre),
	FOREIGN KEY(member_ID, profile_name) REFERENCES Profile(member_ID, profile_name),
	FOREIGN KEY(m_genre) REFERENCES Genre(m_genre));

INSERT INTO Likes_Genre VALUES ('dsmith', 'Sarah', 'Comedy');
INSERT INTO Likes_Genre VALUES ('dsmith', 'Sarah', 'Horror');
INSERT INTO Likes_Genre VALUES ('dsmith', 'Sarah', 'Drama');
INSERT INTO Likes_Genre VALUES ('dsmith', 'Sarah', 'Thriller');
INSERT INTO Likes_Genre VALUES ('dsmith', 'Sarah', 'Romance');
INSERT INTO Likes_Genre VALUES ('dsmith', 'Sarah', 'Musical');
INSERT INTO Likes_Genre VALUES ('dsmith', 'Jenny', 'Fantasy');
INSERT INTO Likes_Genre VALUES ('dsmith', 'Jenny', 'Action');
INSERT INTO Likes_Genre VALUES ('dsmith', 'David', 'Crime');
INSERT INTO Likes_Genre VALUES ('dsmith', 'David', 'Thriller');
INSERT INTO Likes_Genre VALUES ('dsmith', 'David', 'Horror');
INSERT INTO Likes_Genre VALUES ('dsmith', 'David', 'Documentary');
INSERT INTO Likes_Genre VALUES ('ktran', 'Kevin', 'Action');
INSERT INTO Likes_Genre VALUES ('ktran', 'Kevin', 'Drama');
INSERT INTO Likes_Genre VALUES ('ktran', 'Kevin', 'Comedy');
INSERT INTO Likes_Genre VALUES ('ktran', 'Kevin', 'Romance');
INSERT INTO Likes_Genre VALUES ('ktran', 'Kevin', 'Fantasy');
INSERT INTO Likes_Genre VALUES ('ktran', 'Jack', 'Horror');
INSERT INTO Likes_Genre VALUES ('ktran', 'Jack', 'Romance');
INSERT INTO Likes_Genre VALUES ('ktran', 'Jack', 'Crime');
INSERT INTO Likes_Genre VALUES ('awayne', 'Alex', 'Romance');
INSERT INTO Likes_Genre VALUES ('awayne', 'Alex', 'Comedy');
INSERT INTO Likes_Genre VALUES ('awayne', 'Alex', 'Horror');
INSERT INTO Likes_Genre VALUES ('awayne', 'Alex', 'Action');
INSERT INTO Likes_Genre VALUES ('awayne', 'Alex', 'Drama');
INSERT INTO Likes_Genre VALUES ('awayne', 'Lauren', 'Romance');
INSERT INTO Likes_Genre VALUES ('awayne', 'Lauren', 'Drama');
INSERT INTO Likes_Genre VALUES ('awayne', 'Lauren', 'Musical');
INSERT INTO Likes_Genre VALUES ('awayne', 'Lauren', 'Fantasy');
INSERT INTO Likes_Genre VALUES ('awayne', 'Lauren', 'Comedy');
INSERT INTO Likes_Genre VALUES ('awayne', 'Jack', 'Children and Family');
INSERT INTO Likes_Genre VALUES ('jlynn', 'Joanne', 'Action');
INSERT INTO Likes_Genre VALUES ('jlynn', 'Joanne', 'Thriller');
INSERT INTO Likes_Genre VALUES ('jlynn', 'Joanne', 'Comedy');
INSERT INTO Likes_Genre VALUES ('jlynn', 'Joanne', 'Crime');
INSERT INTO Likes_Genre VALUES ('jlynn', 'Joanne', 'Drama');
INSERT INTO Likes_Genre VALUES ('jlynn', 'Joanne', 'Romance');
INSERT INTO Likes_Genre VALUES ('jlynn', 'Kelly', 'Action');
INSERT INTO Likes_Genre VALUES ('jlynn', 'Kelly', 'Romance');
INSERT INTO Likes_Genre VALUES ('cwang', 'Christine', 'Musical');
INSERT INTO Likes_Genre VALUES ('cwang', 'Christine', 'Comedy');
INSERT INTO Likes_Genre VALUES ('cwang', 'Thomas', 'Action');
INSERT INTO Likes_Genre VALUES ('bnelson', 'Bob', 'Action');
INSERT INTO Likes_Genre VALUES ('bnelson', 'Bob', 'Horror');
INSERT INTO Likes_Genre VALUES ('bnelson', 'Lilly', 'Romance');
INSERT INTO Likes_Genre VALUES ('bnelson', 'Olivia', 'Musical');
INSERT INTO Likes_Genre VALUES ('bnelson', 'Olivia', 'Children and Family');
INSERT INTO Likes_Genre VALUES ('bnelson', 'James', 'Horror');
INSERT INTO Likes_Genre VALUES ('bnelson', 'James', 'Thriller');
INSERT INTO Likes_Genre VALUES ('bnelson', 'James', 'Crime');
INSERT INTO Likes_Genre VALUES ('bnelson', 'James', 'Fantasy');
INSERT INTO Likes_Genre VALUES ('bnelson', 'James', 'Documentary');

CREATE TABLE Actor(
	actor_ID VARCHAR2(10),
	first_name VARCHAR2(50),
	last_name VARCHAR2(50),
	PRIMARY KEY(actor_ID));

INSERT INTO Actor VALUES ('jchan', 'Jackie', 'Chan');
INSERT INTO Actor VALUES ('avalta', 'Amber', 'Valletta');
INSERT INTO Actor VALUES ('glopez', 'George', 'Lopez');
INSERT INTO Actor VALUES ('brcyrus', 'Billy', 'Cyrus');
INSERT INTO Actor VALUES ('kjames', 'Kevin', 'James');
INSERT INTO Actor VALUES ('rdawson', 'Rosario', 'Dawson');
INSERT INTO Actor VALUES ('lbibb', 'Leslie', 'Bibb');
INSERT INTO Actor VALUES ('kjeong', 'Ken', 'Jeong');
INSERT INTO Actor VALUES ('dwberg', 'Donnie', 'Wahlberg');
INSERT INTO Actor VALUES ('jrogan', 'Joe', 'Ragon');
INSERT INTO Actor VALUES ('jkrski', 'John', 'Krasinski');
INSERT INTO Actor VALUES ('eblunt', 'Emily', 'Blunt');
INSERT INTO Actor VALUES ('msimonds', 'Millicent', 'Simmonds');
INSERT INTO Actor VALUES ('Njupe', 'Noah', 'Jupa');
INSERT INTO Actor VALUES ('tfarmiga', 'Taissa', 'Farmiga');
INSERT INTO Actor VALUES ('baaron', 'Bonnie', 'Aarons');
INSERT INTO Actor VALUES ('ibisu', 'Ingrid', 'Bisu');
INSERT INTO Actor VALUES ('dbichir', 'Demian', 'Bichir');
INSERT INTO Actor VALUES ('djoson', 'Dwayne', 'Johnson');
INSERT INTO Actor VALUES ('khart', 'Kevin', 'Hart');
INSERT INTO Actor VALUES ('kgilan', 'Karen', 'Gillan');
INSERT INTO Actor VALUES ('jblack', 'Jack', 'Black');
INSERT INTO Actor VALUES ('njonas', 'Nick', 'Jones');
INSERT INTO Actor VALUES ('mismn', 'Madison', 'Iseman');
INSERT INTO Actor VALUES ('awolf', 'Alex', 'Wolff');
INSERT INTO Actor VALUES ('mturner', 'Morgan', 'Turner');
INSERT INTO Actor VALUES ('sblain', 'SerDarius', 'Blain');
INSERT INTO Actor VALUES ('lgaga', 'Lady', 'Gaga');
INSERT INTO Actor VALUES ('bcoper', 'Bradley', 'Cooper');
INSERT INTO Actor VALUES ('seliot', 'Sam', 'Elliott');
INSERT INTO Actor VALUES ('dcpele', 'Dave', 'Chappelle');
INSERT INTO Actor VALUES ('cewu', 'Constance', 'Wu');
INSERT INTO Actor VALUES ('hgolding', 'Henry', 'Golding');
INSERT INTO Actor VALUES ('myeoh', 'Michelle', 'Yeoh');
INSERT INTO Actor VALUES ('jphnix', 'Joaquin', 'Phoenix');
INSERT INTO Actor VALUES ('rniro', 'Robert', 'Niro');
INSERT INTO Actor VALUES ('zbeetz', 'Zazie', 'Beetz');
INSERT INTO Actor VALUES ('fconroy', 'Frances', 'Conroy');
INSERT INTO Actor VALUES ('sjnsson', 'Scarlett', 'Johnsson');
INSERT INTO Actor VALUES ('lbesson', 'Luc', 'Besson');
INSERT INTO Actor VALUES ('mfrman', 'Morgan', 'Freeman');
INSERT INTO Actor VALUES ('awaked', 'Amr', 'Waked');
INSERT INTO Actor VALUES ('smoore', 'Shameik', 'Moore');
INSERT INTO Actor VALUES ('sgisdo', 'Skyler', 'Gisondo');
INSERT INTO Actor VALUES ('khward', 'Kara', 'Hayward');

CREATE TABLE Starred_By(
	movie_ID VARCHAR2(10),
	actor_ID VARCHAR2(10),
	PRIMARY KEY(movie_ID, actor_ID),
	FOREIGN KEY(movie_ID) REFERENCES Movie(movie_ID),
	FOREIGN KEY(actor_ID) REFERENCES Actor(actor_ID));

INSERT INTO Starred_By VALUES ('tsnd', 'jchan');
INSERT INTO Starred_By VALUES ('tsnd', 'avalta');
INSERT INTO Starred_By VALUES ('tsnd', 'glopez');
INSERT INTO Starred_By VALUES ('tsnd', 'brcyrus');
INSERT INTO Starred_By VALUES ('zper', 'kjames');
INSERT INTO Starred_By VALUES ('zper', 'rdawson');
INSERT INTO Starred_By VALUES ('zper', 'lbibb');
INSERT INTO Starred_By VALUES ('zper', 'kjeong');
INSERT INTO Starred_By VALUES ('zper', 'dwberg');
INSERT INTO Starred_By VALUES ('zper', 'jrogan');
INSERT INTO Starred_By VALUES ('aqpl', 'jkrski');
INSERT INTO Starred_By VALUES ('aqpl', 'eblunt');
INSERT INTO Starred_By VALUES ('aqpl', 'msimonds');
INSERT INTO Starred_By VALUES ('aqpl', 'Njupe');
INSERT INTO Starred_By VALUES ('tnun', 'tfarmiga');
INSERT INTO Starred_By VALUES ('tnun', 'baaron');
INSERT INTO Starred_By VALUES ('tnun', 'ibisu');
INSERT INTO Starred_By VALUES ('tnun', 'dbichir');
INSERT INTO Starred_By VALUES ('jwttj', 'djoson');
INSERT INTO Starred_By VALUES ('jwttj', 'khart');
INSERT INTO Starred_By VAlUES ('jwttj', 'kgilan');
INSERT INTO Starred_By VALUES ('jwttj', 'jblack');
INSERT INTO Starred_By VALUES ('jwttj', 'njonas');
INSERT INTO Starred_By VALUES ('jwttj', 'mismn');
INSERT INTO Starred_By VALUES ('jwttj', 'awolf');
INSERT INTO Starred_By VALUES ('jwttj', 'mturner');
INSERT INTO Starred_By VALUES ('jwttj', 'sblain');
INSERT INTO Starred_By VALUES ('asib', 'lgaga');
INSERT INTO Starred_By VALUES ('asib', 'bcoper');
INSERT INTO Starred_By VALUES ('asib', 'seliot');
INSERT INTO Starred_By VALUES ('asib', 'dcpele');
INSERT INTO Starred_By VALUES ('cran', 'cewu');
INSERT INTO Starred_By VALUES ('cran', 'hgolding');
INSERT INTO Starred_By VALUES ('cran', 'myeoh');
INSERT INTO Starred_By VALUES ('jker', 'jphnix');
INSERT INTO Starred_By VALUES ('jker', 'rniro');
INSERT INTO Starred_By VALUES ('jker', 'zbeetz');
INSERT INTO Starred_By VALUES ('jker', 'fconroy');
INSERT INTO Starred_By VALUES ('lucy14', 'sjnsson');
INSERT INTO Starred_By VALUES ('lucy14', 'lbesson');
INSERT INTO Starred_By VALUES ('lucy14', 'mfrman');
INSERT INTO Starred_By VALUES ('lucy14', 'awaked');
INSERT INTO Starred_By VALUES ('clie', 'djoson');
INSERT INTO Starred_By VALUES ('clie', 'khart');
INSERT INTO Starred_By VALUES ('smisv', 'smoore');
INSERT INTO Starred_By VALUES ('tsmd', 'sgisdo');
INSERT INTO Starred_By VALUES ('tsmd', 'khward');

select * from Member;
select * from Profile;
select * from Watch;
select * from Movie;
select * from Genre;
select * from Likes_Genre;
select * from Movie_Genre;
select * from Actor;
select * from Starred_By;


CREATE OR REPLACE TRIGGER calculated_rating
    FOR INSERT OR UPDATE  OR DELETE ON Watch
        COMPOUND TRIGGER 
        count_avg INTEGER;
    
    FOR EACH ROW IS
    BEGIN
        SELECT COUNT(*) INTO count_avg FROM Watch W
            WHERE :NEW.movie_ID=W.movie_ID;
    END BEFORE EACH ROW;
    
    AFTER EACH ROW IS
    BEGIN
        Update Movie M
        SET avg_rating = ROUND((((M.avg_rating*count_avg)+:new.rating)/(count_avg+1)), 2)
        where M.movie_ID = :new.movie_ID;
    
    END AFTER EACH ROW;

END calculated_rating;
/
            
    END AFTER EACH ROW;
    
    AFTER STATEMENT IS 
    BEGIN
        if inserting THEN
            UPDATE Movie M SET (M.rating)=AVG(M.rating+1)
                WHERE M.movie_ID=new_movieID;
        END IF;
        IF updating THEN
            UPDATE Movie M SET (M.rating)=AVG(M.rating+1)
                WHERE M.movie_ID=new_movieID;
        END IF;
    END AFTER STATEMENT;

END calculated_rating;
/

CREATE OR REPLACE TRIGGER num_Profiles_traker
BEFORE INSERT ON Profile
FOR EACH ROW 
DECLARE 
    counter INTEGER;
    reached_five Exception;
BEGIN
    SELECT count(*) INTO counter
    FROM Profile 
    WHERE member_ID = :NEW.member_ID;
    IF counter >= 5 THEN
        RAISE reached_five;
    END IF;
EXCEPTION
    WHEN reached_five THEN 
        Raise_application_error(-2000, 'Reached the Max number of Profiles');
        
END num_Profiles_traker;
/                    
        