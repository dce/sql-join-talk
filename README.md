# SQL Joins

**David Eisinger**  
December 20, 2022

---

# SQL Joins

At a recent standup, I joked that there are really only two kinds of joins you need to know.

Today I wanted to talk through them, how they work, and when you might choose one versus the other.

---

# SQL Joins

There are four main joins:

![](joins.png)

(<https://learnsql.com/blog/learn-and-practice-sql-joins/learn-and-practice-sql-joins.png>)

---

# SQL Joins

There are four main joins:

![](joins.png)

The ones we're concerned with are **inner join** and **left join**.

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

---

# SQL Joins

Let's boot up a couple shells:

```bash
sqlite3 -init blog.sql
```

```bash
irb -r ./blog
```

---

# SQL Joins

Alright, now let's try the two joins.

First, an inner join:

```sql
SELECT *
FROM posts
INNER JOIN comments
ON comments.post_id = posts.id;
```

And in ActiveRecord:

```ruby
Post.joins(:comments)
```

---

# SQL Joins

And now, a left join:

```sql
SELECT *
FROM posts
LEFT JOIN comments
ON comments.post_id = posts.id;
```

```ruby
Post.left_joins(:comments)
```

---

# SQL Joins

What if we only want posts that have comments? What kind of join should we use?

---

# SQL Joins

What if we only want posts that have comments? What kind of join should we use?

```sql
SELECT posts.*
FROM posts
INNER JOIN comments
ON comments.post_id = posts.id
GROUP BY post_id;
```

```ruby
Post.joins(:comments).group(:post_id)
```

---

# SQL Joins

What if we only want posts that **no** comments? What kind of join should we use? What else do we need to do?

---

# SQL Joins

What if we only want posts that **no** comments? What kind of join should we use? What else do we need to do?

```sql
SELECT posts.*
FROM posts
LEFT JOIN comments
ON comments.post_id = posts.id
WHERE post_id IS NULL;
```

```ruby
Post.left_joins(:comments).where(comments: { post_id: nil })
```

---

# SQL Joins

What if we want to include a comment count along with post data?

---

# SQL Joins

What if we want to include a comment count along with post data?

```sql
SELECT posts.*, COUNT(post_id) AS comment_count
FROM posts
LEFT JOIN comments
ON comments.post_id = posts.id
GROUP BY post_id;
```

```ruby
Post.
  select("posts.*, COUNT(post_id) AS comment_count").
  left_joins(:comments).
  group(:post_id)
```

---

# SQL Joins

What if we want posts with more than one comment?

---

# SQL Joins

What if we want posts with more than one comment?

```sql
SELECT posts.*, COUNT(post_id) AS comment_count
FROM posts
INNER JOIN comments
ON comments.post_id = posts.id
GROUP BY post_id
HAVING comment_count > 1;
```

```ruby
Post.
  select("posts.*, COUNT(post_id) AS comment_count").
  joins(:comments).
  group(:post_id).
  having("comment_count > ?", 1)
```
