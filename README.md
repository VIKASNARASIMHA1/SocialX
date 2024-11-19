# SocialX

This repository contains SQL queries designed for interacting with the database of a social media platform - SocialX. The queries allow for performing database operations such as retrieving data, inserting records, updating data, and analyzing user interactions. These queries are intended to be used in a MySQL environment.

## Database Schema Overview

The platform's database consists of the following 9 tables:

1. **users**: Stores user account information (e.g., username, email, password).

2. **user_profiles**: Contains additional user information such as bio, date of birth, gender, etc.

3. **posts**: Stores posts made by users, including content, media, and timestamps.

4. **likes**: Tracks likes on posts by users.

5. **comments**: Stores comments made by users on posts.

6. **messages**: Contains messages exchanged between users.

7. **notifications**: Stores notifications related to posts, comments, likes, and messages.

8. **post_shares**: Tracks when users share posts.

9. **followers**: Tracks user-following relationships between users.

## Sample Data

Below are SQL commands to populate the tables with sample data. This data simulates real-world social media activity including users, posts, comments, likes, messages, notifications, shares, and follows.

### Insert Sample Users

``` 
INSERT INTO users (username, password, email, full_name, bio) VALUES
('john_doe', 'password123', 'john@example.com', 'John Doe', 'Just a regular guy trying to make a difference'),
('jane_smith', 'password123', 'jane@example.com', 'Jane Smith', 'Living life to the fullest'),
-- Add 23 more users similarly
;
``` 
### Insert Sample User Profiles

```
INSERT INTO user_profiles (user_id, date_of_birth, location, website, phone_number, gender) VALUES
(1, '1990-05-01', 'New York, NY', 'http://johndoe.com', '555-1234', 'male'),
(2, '1988-08-15', 'Los Angeles, CA', 'http://janesmith.com', '555-5678', 'female'),
-- Add corresponding profiles for other users
;
```

### Insert Sample Posts

```
INSERT INTO posts (user_id, content, image_url) VALUES
(1, 'Hello world! This is my first post.', 'http://example.com/images/post1.jpg'),
(2, 'Beautiful day for a hike!', 'http://example.com/images/post2.jpg'),
-- Add more posts
;
```

### Insert Sample Comments

```
INSERT INTO comments (post_id, user_id, content) VALUES
(1, 2, 'Great post, John!'),
(2, 1, 'Looks amazing, Jane!'),
-- Add more comments
;
```

### Insert Sample Likes

```
INSERT INTO likes (post_id, user_id) VALUES
(1, 2),
(2, 1),
-- Add more likes
;
```

### Insert Sample Messages

```
INSERT INTO messages (sender_id, receiver_id, message_content) VALUES
(1, 2, 'Hey, how are you?'),
(2, 1, 'I\'m doing great! How about you?'),
-- Add more messages
;
```

### Insert Sample Notifications

```
INSERT INTO notifications (user_id, notification_type, related_entity_id, message) VALUES
(1, 'like', 1, 'Jane liked your post'),
(2, 'comment', 1, 'John commented on your post'),
-- Add more notifications
;
```

### Insert Sample Post Shares

```
INSERT INTO post_shares (post_id, user_id) VALUES
(1, 2),
(2, 1),
-- Add more shares
;
```

### Insert Sample followers

```
INSERT INTO followers (follower_id, following_id) VALUES
(1, 2),
(2, 1),
-- Add more follow relationships
;
```

## Queries

### Get User Profile Information (Including Bio, Date of Birth, Gender, etc.)

```
SELECT u.username, u.full_name, u.email, u.bio, u.profile_picture_url, up.date_of_birth, up.location, up.website, up.phone_number, up.gender
FROM users u
JOIN user_profiles up ON u.user_id = up.user_id
WHERE u.user_id = 3;  -- Replace with the desired user_id
```

### Get all posts made by a specific user, along with the count of likes for each post.

```
SELECT p.post_id, p.content, p.image_url, p.created_at, COUNT(l.like_id) AS like_count
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE p.user_id = 3  -- Replace with the desired user_id
GROUP BY p.post_id
ORDER BY p.created_at DESC;
```

### Retrieve all comments for a specific post, including the user's name who made the comment.

```
SELECT c.comment_id, c.content, c.created_at, u.username, u.full_name
FROM comments c
JOIN users u ON c.user_id = u.user_id
WHERE c.post_id = 1  -- Replace with the desired post_id
ORDER BY c.created_at DESC;
```

### Find the total number of likes for a specific post.

```
SELECT p.post_id, COUNT(l.like_id) AS total_likes
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE p.post_id = 1  -- Replace with the desired post_id
GROUP BY p.post_id;
```

### Find the total number of messages exchanged between two users.

```
SELECT COUNT(m.message_id) AS total_messages
FROM messages m
WHERE (m.sender_id = 1 AND m.receiver_id = 2)  -- Replace with the user_ids
OR (m.sender_id = 2 AND m.receiver_id = 1);
```

### Retrieve all messages sent by a specific user, including the recipient and message content.

```
SELECT m.message_id, m.message_content, m.created_at, u.username AS recipient
FROM messages m
JOIN users u ON m.receiver_id = u.user_id
WHERE m.sender_id = 1  -- Replace with the desired sender user_id
ORDER BY m.created_at DESC;
```

### List all notifications for a user, including the type of notification and whether it’s been read.

```
SELECT n.notification_id, n.notification_type, n.message, n.is_read, n.created_at
FROM notifications n
WHERE n.user_id = 3  -- Replace with the desired user_id
ORDER BY n.created_at DESC;
```

### Retrieve all shares for a specific post, including the message shared with the post.

```
SELECT ps.share_id, ps.share_message, u.username, ps.created_at
FROM post_shares ps
JOIN users u ON ps.user_id = u.user_id
WHERE ps.post_id = 1  -- Replace with the desired post_id
ORDER BY ps.created_at DESC;
```

### List all posts that a specific user has liked.

```
SELECT p.post_id, p.content, p.created_at
FROM posts p
JOIN likes l ON p.post_id = l.post_id
WHERE l.user_id = 1  -- Replace with the desired user_id
ORDER BY p.created_at DESC;
```

### Retrieve all posts with the number of times they have been shared.

```
SELECT p.post_id, p.content, p.created_at, COUNT(ps.share_id) AS share_count
FROM posts p
LEFT JOIN post_shares ps ON p.post_id = ps.post_id
GROUP BY p.post_id
ORDER BY p.created_at DESC;
```

### Retrieve all notifications related to a specific post (likes, comments, shares, etc.).

```
SELECT n.notification_type, n.message, n.is_read, n.created_at
FROM notifications n
WHERE n.related_entity_id = 1  -- Replace with the desired post_id
AND n.notification_type IN ('like', 'comment', 'post_share')
ORDER BY n.created_at DESC;
```

### Get the total number of comments made on a post.

```
SELECT p.post_id, COUNT(c.comment_id) AS total_comments
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE p.post_id = 1  -- Replace with the desired post_id
GROUP BY p.post_id;
```

### List all users who have shared a specific post, along with their share messages.

```
SELECT u.username, u.full_name, ps.share_message, ps.created_at
FROM post_shares ps
JOIN users u ON ps.user_id = u.user_id
WHERE ps.post_id = 1  -- Replace with the desired post_id
ORDER BY ps.created_at DESC;
```

### Find all users who have received messages from a specific user.

```
SELECT DISTINCT u.username, u.full_name
FROM messages m
JOIN users u ON m.receiver_id = u.user_id
WHERE m.sender_id = 1  -- Replace with the sender's user_id
ORDER BY u.username;
```

### List all posts that mention a specific word.

```
SELECT p.post_id, p.content, p.created_at
FROM posts p
WHERE p.content LIKE '%beach%'  -- Replace with the @username of the mentioned user
ORDER BY p.created_at DESC;
```

### Find all users who have interacted with a post (liked, commented, or shared it).

```
SELECT DISTINCT u.username, u.full_name
FROM users u
LEFT JOIN likes l ON u.user_id = l.user_id
LEFT JOIN comments c ON u.user_id = c.user_id
LEFT JOIN post_shares ps ON u.user_id = ps.user_id
WHERE l.post_id = 1  -- Replace with the post_id
   OR c.post_id = 1  -- Replace with the post_id
   OR ps.post_id = 1  -- Replace with the post_id
ORDER BY u.username;
```

### List all posts shared by a specific user, along with any accompanying share messages.

```
SELECT p.post_id, p.content, ps.share_message, ps.created_at
FROM posts p
JOIN post_shares ps ON p.post_id = ps.post_id
WHERE ps.user_id = 1  -- Replace with the target user_id
ORDER BY ps.created_at DESC;
```

### Identify the most active friend of a specific user based on the number of messages exchanged.

```
SELECT u.username, u.full_name, COUNT(m.message_id) AS message_count
FROM messages m
JOIN users u ON m.sender_id = u.user_id
WHERE m.receiver_id = 1  -- Replace with the target user_id
GROUP BY u.user_id
ORDER BY message_count DESC
LIMIT 1;
```

### List all notifications related to posts (likes, comments, shares) for a specific user.

```
SELECT n.notification_type, n.message, n.is_read, n.created_at
FROM notifications n
WHERE n.user_id = 3  -- Replace with the target user_id
AND n.notification_type IN ('like', 'comment', 'post_share')
ORDER BY n.created_at DESC;
```

### Find posts that have at least one comment and one like.

```
SELECT p.post_id, p.content, p.created_at
FROM posts p
JOIN comments c ON p.post_id = c.post_id
JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id
HAVING COUNT(c.comment_id) > 0 AND COUNT(l.like_id) > 0;
```

### Find all users who have sent messages to a particular user.

```
SELECT DISTINCT u.username, u.full_name
FROM users u
JOIN messages m ON u.user_id = m.sender_id
WHERE m.receiver_id = 1  -- Replace with the target user_id
ORDER BY u.username;
```

### Retrieve all unread messages for a specific user.

```
SELECT m.message_id, m.message_content, m.created_at, u.username AS sender
FROM messages m
JOIN users u ON m.sender_id = u.user_id
WHERE m.receiver_id = 1  -- Replace with the desired user_id
AND m.read_status = FALSE
ORDER BY m.created_at DESC;
```

### List all users who have shared any posts.

```
SELECT u.user_id, u.username, u.full_name
FROM users u
LEFT JOIN post_shares ps ON u.user_id = ps.user_id
WHERE ps.share_id IS not NULL;
```

### Find the total number of posts liked by a specific user.

```
SELECT COUNT(DISTINCT l.post_id) AS total_liked_posts
FROM likes l
WHERE l.user_id = 1;  -- Replace with the desired user_id
```

### Get all posts of a specific user along with the count of comments on each post.

```
SELECT p.post_id, p.content, p.created_at, COUNT(c.comment_id) AS comment_count
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE p.user_id = 1  -- Replace with the desired user_id
GROUP BY p.post_id
ORDER BY p.created_at DESC;
```

### Retrieve the most liked post of a specific user, ordered by the number of likes.

```
SELECT p.post_id, p.content, COUNT(l.like_id) AS like_count
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE p.user_id = 1  -- Replace with the desired user_id
GROUP BY p.post_id
ORDER BY like_count DESC
LIMIT 1;  -- Get only the most liked post
```

### Retrieve the post with the highest number of comments made by a specific user.

```
SELECT p.post_id, p.content, COUNT(c.comment_id) AS comment_count
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE p.user_id = 1  -- Replace with the target user_id
GROUP BY p.post_id
ORDER BY comment_count DESC
LIMIT 1;
```

### Retrieve the posts that have been shared the most by users.

```
SELECT p.post_id, p.content, COUNT(ps.share_id) AS share_count
FROM posts p
LEFT JOIN post_shares ps ON p.post_id = ps.post_id
GROUP BY p.post_id
ORDER BY share_count DESC
LIMIT 5;
```

### Identify the user who has made the most comments on posts.

```
SELECT u.username, u.full_name, COUNT(c.comment_id) AS comment_count
FROM users u
JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id
ORDER BY comment_count DESC
LIMIT 1;
```

### List all users who have sent messages to a specific user.

```
SELECT DISTINCT u.username, u.full_name
FROM users u
JOIN messages m ON u.user_id = m.sender_id
WHERE m.receiver_id = 1  -- Replace with the target user_id
ORDER BY u.username;
```

### Retrieve all unread notifications for a specific user.

```
SELECT n.notification_id, n.notification_type, n.message, n.created_at
FROM notifications n
WHERE n.user_id = 3  -- Replace with the user_id
AND n.is_read = FALSE
ORDER BY n.created_at DESC;
```

### Find the total number of posts made in the last 30 days.

```
SELECT COUNT(p.post_id) AS total_posts
FROM posts p
WHERE p.created_at > NOW() - INTERVAL 30 DAY;
```

### Retrieve the total number of comments made by all users on the platform

```
SELECT COUNT(c.comment_id) AS total_comments
FROM comments c;
```

## Conclusion

This README.md provides a full set of SQL queries to interact with the database for a social media platform. It includes data retrieval queries for fetching posts, comments, likes, messages, and notifications..

You can use these queries to manage user data, track interactions, and analyze user behavior on the platform. If you need to extend or modify the functionality, feel free to contribute additional queries or improvements to the repository.

## Contribution Guidelines

If you wish to contribute to this repository, you can:

1. Fork the repository and clone it to your local machine.

2. Add new queries or improve existing ones.

3. Submit a pull request for review.

