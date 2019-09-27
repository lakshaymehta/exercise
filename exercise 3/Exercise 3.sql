USE mydb;
CREATE TABLE users
(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(20),
type ENUM('admin', 'normal'),
PRIMARY KEY(id)
);
INSERT INTO Users(name, type) VALUES ('User1','admin'),
('User2','admin'),
('User3','normal'),
('User4','normal'),
('User5','normal'),
('User6','admin'),
('User7','admin'),
('User8','normal'),
('User9','admin');

CREATE TABLE categories
(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(45) NULL,
PRIMARY KEY (id)
);
INSERT INTO Categories(name) VALUES ('Abstract'),
('Politics'),
('Sports'),
('Technical');
SELECT * FROM categories;

CREATE TABLE articles
(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NULL,
user_id INT,
category_id INT,
PRIMARY KEY (id),
FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
FOREIGN KEY(category_id) REFERENCES categories(id)
);
INSERT INTO Articles (name, User_id, Category_id) VALUES ('Article1',3,1),
('Article2',1,2),
('Article3',8,3),
('Article4',5,4),
('Article5',6,4),
('Article6',7,3),
('Article7',2,2),
('Article8',3,1),
('Article9',3,2),
('Article10',5,3),
('Article11',7,4),
('Article12',6,1),
('Article13',4,2),
('Article14',9,2),
('Article15',1,3),
('Article16',1,4),
('Article17',8,3),
('Article18',9,4),
('Article19',2,1),
('Article20',6,4),
('Article21',5,1),
('Article22',5,4),
('Article23',7,1),
('Article24',8,2),
('Article25',1,3);

CREATE TABLE comments
(
id INT AUTO_INCREMENT,
comment_field VARCHAR(60),
user_id INT,
article_id INT,
PRIMARY KEY(id),
FOREIGN KEY(user_id) REFERENCES users(id),
FOREIGN KEY(article_id) REFERENCES articles(id) ON DELETE CASCADE
);
INSERT INTO comments ( comment_field, User_id, Article_id) VALUES ('comment1',3,2),
('comment2',4,1),
('comment3',5,8),
('comment4',3,20),
('comment5',7,1),
('comment6',1,6),
('comment7',1,10),
('comment8',1,15),
('comment9',9,3),
('comment10',3,24),
('comment11',8,15),
('comment12',1,11),
('comment13',2,15);

	-- manage(create, update, delete) categories, articles, comments, and users --
SELECT * FROM articles;
UPDATE articles SET articles.name='Article26' WHERE (id='25');
DELETE FROM articles WHERE (id='25');
DELETE FROM articles WHERE user_id = '2';

	-- select all articles whose author's name is user3 (Do this exercise using variable also) --
SELECT articles.name FROM articles,users WHERE articles.user_id=users.id AND users.name='User3'; 

SET @u3:='User3';
SELECT articles.name FROM articles JOIN users WHERE articles.user_id=users.id AND users.name=@u3;

	-- For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query (Do this using subquery also) --
SELECT articls.name, GROUP_CONCAT(comment_field) FROM articles JOIN users
ON articles.user_id=users.id LEFT JOIN comments 
ON comments.article_id=articles.id
WHERE users.name = @u3 GROUP BY articles.name;

	-- Write a query to select all articles which do not have any comments (Do using subquery also) --
SELECT articles.name FROM articles LEFT JOIN comments
ON articles.id=comments.article_id WHERE comments.comment_field IS NULL;

SELECT articles.name FROM articles
WHERE articles.id NOT IN
(
SELECT DISTINCT article_id FROM comments
);

	-- Write a query to select article which has maximum comments --
SELECT articles.name, count(comment_field) from articles, comments
WHERE articles.id=comments.article_id
GROUP BY articles.name
ORDER BY count(comment_field) DESC LIMIT 1;

	-- Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by ) --
SELECT articles.name, COUNT(comment_field) FROM articles LEFT JOIN comments
ON articles.id=comments.article_id LEFT JOIN users
ON users.id=comments.user_id 
GROUP BY articles.name 
HAVING COUNT(comments.user_id) = COUNT(DISTINCT comments.user_id);

