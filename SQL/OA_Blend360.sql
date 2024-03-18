-- create database book;

-- DROP TABLE book.Authors;
-- CREATE TABLE book.book.Authors (
--     AuthorID int,
--     AuthorName varchar(255),
--     BirthDate DATE
-- );

-- CREATE TABLE book.book.Books (
--  ISBN varchar(255),
--  BookTitle varchar(255),
--  PublishingCountry varchar(255),
--  AuthorID int
-- );

-- INSERT INTO book.Authors VALUES (1,'David Zola','1984-1-5');
-- INSERT INTO book.Authors VALUES (2,'Jack Black','1981-8-10');
-- INSERT INTO book.Authors VALUES (3,'Zooey Fry','1955-11-1');
-- INSERT INTO book.Authors VALUES (4,'Margaret Johansson','1963-7-5');
-- INSERT INTO book.Authors VALUES (5,'Conrad Dupree','1991-2-6');
-- INSERT INTO book.Authors VALUES (6,'David Clarke','2001-3-4');
-- INSERT INTO book.Authors VALUES (7,'Francis Doss','1980-1-14');
-- INSERT INTO book.Authors VALUES (8,'Constantin Gros','1977-1-26');
-- INSERT INTO book.Authors VALUES (9,'Jack Black','1951-9-30');
-- INSERT INTO book.Authors VALUES (10,'Li Xu','1986-6-27');

-- INSERT INTO book.Books VALUES ('978-3-16-148410-0','My Life on Television','USA',1);
-- INSERT INTO book.Books VALUES ('981-4-35-731121-0','The Rise And Fall And Rise of the Tabloid','GBR',2);
-- INSERT INTO book.Books VALUES ('945-5-99-535121-0','Office Space Ghost','USA',3);
-- INSERT INTO book.Books VALUES ('954-6-94-889651-3','Ford Motor Company The Earlier Years','USA',4);
-- INSERT INTO book.Books VALUES ('987-8-33-733009-7','Go Faster: Racing on the Brink','USA',5);
-- INSERT INTO book.Books VALUES ('922-6-78-002311-8','Henry Ford: A Biography','USA',6);
-- INSERT INTO book.Books VALUES ('951-4-86-736641-4','Your Title Here','DEU',8);
-- INSERT INTO book.Books VALUES ('951-8-11-443131-0','Central Station Stories','DEU',8);
-- INSERT INTO book.Books VALUES ('952-4-11-132660-0','The ALOHA Way','DEU',8);
-- INSERT INTO book.Books VALUES ('915-7-13-600431-9','The Best View of the City','TUR',9);
-- INSERT INTO book.Books VALUES ('981-1-72-333333-0','I Am The Real Jack Black: A Memior','TUR',9);

with cte as
(
	select AuthorID from 
	(
		select AuthorID,Substring(AuthorName, 1, locate(' ', AuthorName, 1)-1) as First_name 
		from book.Authors
	) sq group by First_Name
	having count(1) <= 1
) 
select count(ISBN) from book.books ct
where ct.authorid in (select AuthorID from cte)


