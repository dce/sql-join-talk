PRAGMA foreign_keys = ON;
.mode table

CREATE TABLE posts (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL
);

CREATE TABLE comments (
  id INTEGER PRIMARY KEY,
  post_id INTEGER NOT NULL, 
  content TEXT NOT NULL,
  FOREIGN KEY(post_id) REFERENCES posts(id)
);

INSERT INTO posts (title, content) VALUES ("First Post", "This is the first post");
INSERT INTO posts (title, content) VALUES ("Second Post", "This is the second post");
INSERT INTO posts (title, content) VALUES ("Third Post", "This is the third post");

INSERT INTO comments (post_id, content) VALUES (1, "What a great post");
INSERT INTO comments (post_id, content) VALUES (1, "I concur");
INSERT INTO comments (post_id, content) VALUES (3, "This post is just alright");
