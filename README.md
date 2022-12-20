# SQL Joins

David Eisinger  
December 20, 2022

---

# SQL Joins

At a recent standup, 

---

# SQL Joins

There are four main joins:

![](joins.png)

(<https://learnsql.com/blog/learn-and-practice-sql-joins/learn-and-practice-sql-joins.png>)

---

# SQL Joins

Let's look at an example. First, let's create a `posts` table:

```sql
CREATE TABLE posts (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL
);
```

---

# SQL Joins

Then, a `comments` table:

```sql
CREATE TABLE comments (
  id INTEGER PRIMARY KEY,
  post_id INTEGER NOT NULL, 
  content TEXT NOT NULL,
  FOREIGN KEY(post_id) REFERENCES posts(id)
);
```

---

# SQL Joins

Insert some data:

```sql
INSERT INTO posts (title, content)
  VALUES ("First Post", "This is the first post");
INSERT INTO posts (title, content)
  VALUES ("Second Post", "This is the second post");
INSERT INTO posts (title, content)
  VALUES ("Third Post", "This is the third post");

INSERT INTO comments (post_id, content)
  VALUES (1, "What a great post");
INSERT INTO comments (post_id, content)
  VALUES (1, "I concur");
INSERT INTO comments (post_id, content)
  VALUES (3, "This post is just alright");
```
