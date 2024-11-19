create database socialX;
use socialX;

-- users_table

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    bio TEXT,
    profile_picture_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role ENUM('user', 'admin') DEFAULT 'user'
);

-- User_Profile_Table

CREATE TABLE user_profiles (
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    date_of_birth DATE,
    location VARCHAR(255),
    website VARCHAR(255),
    phone_number VARCHAR(20),
    gender ENUM('male', 'female', 'other'),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);


-- posts_table

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT NOT NULL,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- comments_table

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- likes_table

CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Friends_table

CREATE TABLE friends (
    user_id_1 INT,
    user_id_2 INT,
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id_1, user_id_2),
    FOREIGN KEY (user_id_1) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id_2) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Messages_Table

CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    message_content TEXT NOT NULL,
    read_status BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Notifications_Table

CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    notification_type ENUM('like', 'comment', 'friend_request', 'message', 'post_share', 'mention'),
    related_entity_id INT,  -- For example, related to a post_id, comment_id, etc.
    message TEXT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- post_shares_table

CREATE TABLE post_shares (
    share_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    share_message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);


-- Insert 25 sample users into the users table
INSERT INTO users (username, password, email, full_name, bio)
VALUES
('john_doe', 'password123', 'john.doe@example.com', 'John Doe', 'This is John\'s bio.'),
('jane_smith', 'password456', 'jane.smith@example.com', 'Jane Smith', 'This is Jane\'s bio.'),
('mike_lee', 'mikepassword', 'mike.lee@example.com', 'Mike Lee', 'Just a regular guy.'),
('emily_brown', 'mypassword123', 'emily.brown@example.com', 'Emily Brown', 'Loves to travel and explore the world.'),
('david_jones', 'password789', 'david.jones@example.com', 'David Jones', 'Music lover and tech enthusiast.'),
('sarah_williams', 'sarahpassword', 'sarah.williams@example.com', 'Sarah Williams', 'Life is short, enjoy every moment!'),
('alex_davis', 'alexpass123', 'alex.davis@example.com', 'Alex Davis', 'Avid gamer and tech geek.'),
('lisa_martinez', 'lisa1234', 'lisa.martinez@example.com', 'Lisa Martinez', 'Lover of photography and good food.'),
('james_garcia', 'garcia123', 'james.garcia@example.com', 'James Garcia', 'Sports enthusiast and coffee addict.'),
('olivia_moore', 'oliviamoore', 'olivia.moore@example.com', 'Olivia Moore', 'Fashion and beauty lover.'),
('daniel_hernandez', 'danielpass', 'daniel.hernandez@example.com', 'Daniel Hernandez', 'Coding is life.'),
('lucy_wilson', 'lucy12345', 'lucy.wilson@example.com', 'Lucy Wilson', 'Mom of two and full-time professional.'),
('andrew_taylor', 'andrew123', 'andrew.taylor@example.com', 'Andrew Taylor', 'Love tech and everything futuristic.'),
('kate_thompson', 'katepass', 'kate.thompson@example.com', 'Kate Thompson', 'Bookworm and nature enthusiast.'),
('jack_clark', 'jack_clark_123', 'jack.clark@example.com', 'Jack Clark', 'Learning something new every day.'),
('maria_moore', 'maria1234', 'maria.moore@example.com', 'Maria Moore', 'Creative thinker and entrepreneur.'),
('william_jackson', 'williampassword', 'william.jackson@example.com', 'William Jackson', 'Tech lover and social media junkie.'),
('zoe_lee', 'zoepassword', 'zoe.lee@example.com', 'Zoe Lee', 'Yoga and mindfulness advocate.'),
('thomas_white', 'thomaswhite', 'thomas.white@example.com', 'Thomas White', 'Adventure lover and traveler.'),
('rachel_walker', 'rachelpass123', 'rachel.walker@example.com', 'Rachel Walker', 'Fitness freak and foodie.'),
('henry_harris', 'henry123password', 'henry.harris@example.com', 'Henry Harris', 'Design thinking and innovation enthusiast.'),
('victoria_scott', 'victoriapass', 'victoria.scott@example.com', 'Victoria Scott', 'Marketing professional and art lover.'),
('noah_adams', 'noahpassword', 'noah.adams@example.com', 'Noah Adams', 'Love working on open-source projects.'),
('megan_robinson', 'meganpassword123', 'megan.robinson@example.com', 'Megan Robinson', 'Interior designer and travel blogger.'),
('chris_evans', 'chris1234', 'chris.evans@example.com', 'Chris Evans', 'Fitness coach and nature lover.');

-- Insert 25 sample user profiles into the user_profiles table
INSERT INTO user_profiles (user_id, date_of_birth, location, website, phone_number, gender)
VALUES
(1, '1990-01-01', 'New York, USA', 'http://johnswebsite.com', '123-456-7890', 'male'),
(2, '1992-05-15', 'Los Angeles, USA', 'http://janeswebsite.com', '234-567-8901', 'female'),
(3, '1988-11-23', 'Chicago, USA', 'http://mikeswebsite.com', '345-678-9012', 'male'),
(4, '1995-07-02', 'Miami, USA', 'http://emilyswebsite.com', '456-789-0123', 'female'),
(5, '1985-02-28', 'Houston, USA', 'http://davidswebsite.com', '567-890-1234', 'male'),
(6, '1994-10-10', 'Seattle, USA', 'http://sarahswebsite.com', '678-901-2345', 'female'),
(7, '1989-04-15', 'San Francisco, USA', 'http://alexdavis.com', '789-012-3456', 'male'),
(8, '1991-08-29', 'Los Angeles, USA', 'http://lisaswebsite.com', '890-123-4567', 'female'),
(9, '1993-01-01', 'Austin, USA', 'http://jameswebsite.com', '901-234-5678', 'male'),
(10, '1987-12-25', 'Chicago, USA', 'http://oliviaswebsite.com', '012-345-6789', 'female'),
(11, '1990-06-18', 'Dallas, USA', 'http://danielswebsite.com', '123-456-7890', 'male'),
(12, '1992-04-07', 'Los Angeles, USA', 'http://lucywilson.com', '234-567-8901', 'female'),
(13, '1987-09-12', 'San Francisco, USA', 'http://andrewtaylor.com', '345-678-9012', 'male'),
(14, '1994-11-01', 'Boston, USA', 'http://katethompson.com', '456-789-0123', 'female'),
(15, '1991-05-10', 'Dallas, USA', 'http://jackclark.com', '567-890-1234', 'male'),
(16, '1993-02-22', 'Miami, USA', 'http://mariamoore.com', '678-901-2345', 'female'),
(17, '1989-03-14', 'San Diego, USA', 'http://williamjackson.com', '789-012-3456', 'male'),
(18, '1992-12-31', 'Phoenix, USA', 'http://zoelee.com', '890-123-4567', 'female'),
(19, '1988-07-04', 'Denver, USA', 'http://thomaswhite.com', '901-234-5678', 'male'),
(20, '1990-01-22', 'Miami, USA', 'http://rachelwalker.com', '012-345-6789', 'female'),
(21, '1987-08-19', 'Seattle, USA', 'http://henryharris.com', '123-456-7890', 'male'),
(22, '1993-03-11', 'Chicago, USA', 'http://victoriascott.com', '234-567-8901', 'female'),
(23, '1990-04-20', 'San Francisco, USA', 'http://noahadams.com', '345-678-9012', 'male'),
(24, '1991-09-03', 'Los Angeles, USA', 'http://meganrobinson.com', '456-789-0123', 'female'),
(25, '1989-10-12', 'Boston, USA', 'http://chrisevans.com', '567-890-1234', 'male');

-- Insert 25 sample posts into the posts table
INSERT INTO posts (user_id, content, image_url)
VALUES
(1, 'Excited to start my new journey in coding! #newbeginnings', 'http://example.com/images/post1.jpg'),
(2, 'Loving the new book I just picked up. Anyone else into reading? #bookworm', 'http://example.com/images/post2.jpg'),
(3, 'Just finished a 10-mile run! Feeling great! #fitness', 'http://example.com/images/post3.jpg'),
(4, 'Trying a new recipe today. Can\'t wait to share it with you all! #foodie', 'http://example.com/images/post4.jpg'),
(5, 'Learning something new every day. Anyone have cool tech tips? #techlover', 'http://example.com/images/post5.jpg'),
(6, 'Had a wonderful weekend at the beach! #vacationvibes', 'http://example.com/images/post6.jpg'),
(7, 'Gaming all day! Can\'t believe the new update for this game! #gamerlife', 'http://example.com/images/post7.jpg'),
(8, 'So excited to finally get my photography portfolio online! #photography', 'http://example.com/images/post8.jpg'),
(9, 'A cup of coffee and good conversation – that\'s all I need this morning. #coffeeaddict', 'http://example.com/images/post9.jpg'),
(10, 'Can\'t believe how much my workout routine has improved. #gymmotivation', 'http://example.com/images/post10.jpg'),
(11, 'A new chapter begins today. Let\'s see what the future holds. #newbeginnings', 'http://example.com/images/post11.jpg'),
(12, 'Trying out a new hiking trail. Nature is beautiful! #outdoors', 'http://example.com/images/post12.jpg'),
(13, 'Visited a new city last weekend. Check out the amazing sights! #travel', 'http://example.com/images/post13.jpg'),
(14, 'Spending the weekend getting creative with some new art ideas. #artlife', 'http://example.com/images/post14.jpg'),
(15, 'Happy to announce a big personal achievement today! #milestone', 'http://example.com/images/post15.jpg'),
(16, 'Chillin\' with some friends after a busy week. #weekendvibes', 'http://example.com/images/post16.jpg'),
(17, 'Launching my new online store! Come check it out! #shoplocal', 'http://example.com/images/post17.jpg'),
(18, 'Had an amazing workout session this morning! #fitnessjourney', 'http://example.com/images/post18.jpg'),
(19, 'Time to take a break and watch a good movie. What do you recommend? #movienight', 'http://example.com/images/post19.jpg'),
(20, 'Celebrating small victories today. Every step counts! #progress', 'http://example.com/images/post20.jpg'),
(21, 'What a great day at the park with the family! #familytime', 'http://example.com/images/post21.jpg'),
(22, 'Finished reading an inspiring book. Highly recommend it to everyone! #booklover', 'http://example.com/images/post22.jpg'),
(23, 'Working on a big project today. Stay tuned! #entrepreneur', 'http://example.com/images/post23.jpg'),
(24, 'Had a delicious homemade dinner tonight. #homecooking', 'http://example.com/images/post24.jpg'),
(25, 'Feeling motivated to start a new fitness routine! Who\'s with me? #fitfam', 'http://example.com/images/post25.jpg');

-- Insert 25 sample comments into the comments table
INSERT INTO comments (post_id, user_id, content)
VALUES
(1, 2, 'That\'s awesome, John! Keep going! #inspiration'),
(1, 3, 'I\'m on the same journey, John! Let\'s do this!'),
(2, 1, 'What book are you reading, Jane? I\'m looking for new recommendations.'),
(2, 4, 'Love reading! Any fiction recommendations?'),
(3, 5, '10 miles? That\'s incredible, Mike! Great job!'),
(3, 6, 'Wow, Mike! Keep it up! I need to get to your level.'),
(4, 7, 'Looking forward to seeing the recipe, Emily!'),
(4, 8, 'I love cooking! Can\'t wait for the recipe.'),
(5, 9, 'Tech tips coming your way! Check out this cool framework.'),
(5, 10, 'I\'m all about tech too! Let me know if you need any tips.'),
(6, 11, 'Beach vibes are the best! Glad you had a great weekend, Sarah.'),
(6, 12, 'The beach is always so relaxing. Hope you had fun, Sarah!'),
(7, 13, 'What game are you playing, Alex? I need a new one!'),
(7, 14, 'Gaming is life! Let me know if you want to play together, Alex.'),
(8, 15, 'Amazing photos, Lisa! Your portfolio looks incredible.'),
(8, 16, 'I need to step up my photography game, Lisa! So inspiring.'),
(9, 17, 'Coffee + friends = best combo, James. Enjoy your day!'),
(9, 18, 'Nothing beats a good cup of coffee to start the day!'),
(10, 19, 'I need to get back to the gym, Olivia! Great job with your routine.'),
(10, 20, 'Keep pushing yourself, Olivia! The results will come.'),
(11, 21, 'New beginnings are exciting! Best of luck, Daniel!'),
(11, 22, 'I love the energy, Daniel! Can\'t wait to see what\'s next for you.'),
(12, 23, 'The trail looks beautiful, Lucy! Where is this trail?'),
(12, 24, 'Nature is so refreshing! I need to get outdoors more, Lucy.'),
(13, 25, 'Amazing sights, Andrew! Where are you traveling to next?'),
(13, 1, 'I\'m adding that city to my travel list, Andrew! Looks amazing.'),
(14, 2, 'Your art is so creative, Kate! Keep going, girl!'),
(14, 3, 'Loving the creativity, Kate! Can\'t wait to see more.'),
(15, 4, 'Congratulations, Jack! What an achievement. #goals'),
(15, 5, 'Such an inspiring post, Jack! Keep achieving those goals!'),
(16, 6, 'Sounds like a fun weekend, Maria! What did you do?'),
(16, 7, 'Great to hear, Maria! It\'s so important to relax sometimes.'),
(17, 8, 'Congrats on launching your store, William! I\'ll definitely check it out.'),
(17, 9, 'Exciting times, William! Can\'t wait to support your store!'),
(18, 10, 'Your workout routine is paying off, Zoey! Keep at it!'),
(18, 11, 'The results are showing, Zoey! Keep pushing yourself!'),
(19, 12, 'What movie are you watching, Thomas? I need new suggestions.'),
(19, 13, 'Movies are the best way to relax. Let me know what you\'re watching, Thomas.'),
(20, 14, 'Every step counts, Rachel! Proud of you for celebrating the small victories.'),
(20, 15, 'This is a great mindset, Rachel. Let\'s keep moving forward together!'),
(21, 16, 'That park looks so peaceful, Henry. Family time is always precious.'),
(21, 17, 'Glad you had a great time with the family, Henry! Those moments are priceless.'),
(22, 18, 'I\'ve been hearing great things about that book, Victoria! What did you think of it?'),
(22, 19, 'I love reading too, Victoria! Let\'s share book recommendations.'),
(23, 20, 'Looking forward to seeing your project, Noah!'),
(23, 21, 'Best of luck with your project, Noah! I know it\'ll be amazing.'),
(24, 22, 'Homemade meals are the best! What did you cook, Megan?'),
(24, 23, 'Can\'t wait to see the dish, Megan! Homemade always tastes better.'),
(25, 24, 'I\'m in! Starting a fitness routine with you, Chris!'),
(25, 25, 'Let\'s do this! Ready to start the fitness journey, Chris! #fitfam');

-- Insert 25 sample likes into the likes table
INSERT INTO likes (post_id, user_id)
VALUES
(1, 2),  -- User 2 likes Post 1
(1, 3),  -- User 3 likes Post 1
(2, 1),  -- User 1 likes Post 2
(2, 4),  -- User 4 likes Post 2
(3, 5),  -- User 5 likes Post 3
(3, 6),  -- User 6 likes Post 3
(4, 7),  -- User 7 likes Post 4
(4, 8),  -- User 8 likes Post 4
(5, 9),  -- User 9 likes Post 5
(5, 10), -- User 10 likes Post 5
(6, 11), -- User 11 likes Post 6
(6, 12), -- User 12 likes Post 6
(7, 13), -- User 13 likes Post 7
(7, 14), -- User 14 likes Post 7
(8, 15), -- User 15 likes Post 8
(8, 16), -- User 16 likes Post 8
(9, 17), -- User 17 likes Post 9
(9, 18), -- User 18 likes Post 9
(10, 19), -- User 19 likes Post 10
(10, 20), -- User 20 likes Post 10
(11, 21), -- User 21 likes Post 11
(11, 22), -- User 22 likes Post 11
(12, 23), -- User 23 likes Post 12
(12, 24), -- User 24 likes Post 12
(13, 25); -- User 25 likes Post 13

-- Insert 25 sample messages into the messages table
INSERT INTO messages (sender_id, receiver_id, message_content)
VALUES
(1, 2, 'Hey Jane, I just started learning to code! Any tips?'),
(2, 1, 'That\'s awesome, John! Start with the basics. You\'ve got this!'),
(3, 4, 'Hey Emily, how was your weekend? I saw your beach photos!'),
(4, 3, 'It was amazing, Mike! The weather was perfect for a beach day.'),
(5, 6, 'Sarah, I need some tech advice! Do you know anything about frameworks?'),
(6, 5, 'Of course! I recommend checking out React if you\'re starting with front-end.'),
(7, 8, 'Lisa, I love your photography! How did you get started?'),
(8, 7, 'Thanks, Alex! I started with a basic camera and some online tutorials.'),
(9, 10, 'Olivia, your workout routine is impressive. What are your tips?'),
(10, 9, 'Thank you, James! Stay consistent, and make sure to rest between sessions.'),
(11, 12, 'Sarah, I checked out your new blog post! Loved it!'),
(12, 11, 'Thanks, Daniel! I appreciate your support.'),
(13, 14, 'Kate, your art is so inspiring! How do you find your inspiration?'),
(14, 13, 'Thanks, Andrew! I usually draw inspiration from nature and people around me.'),
(15, 16, 'Maria, I saw your new product launch! Congrats!'),
(16, 15, 'Thanks, Henry! It\'s been a long road, but I\'m excited for what\'s to come!'),
(17, 18, 'Zoey, how do you keep up with your fitness goals?'),
(18, 17, 'Consistency is key, Thomas! Set small goals and track your progress.'),
(19, 20, 'Rachel, I loved the book you recommended! What’s your next read?'),
(20, 19, 'Thanks, Victoria! I\'m currently reading a biography of Steve Jobs.'),
(21, 22, 'Megan, your park photos are amazing! Where did you take them?'),
(22, 21, 'Thanks, Noah! They were taken in the local park during golden hour.'),
(23, 24, 'Chris, I saw your fitness post. Let\'s start a workout challenge together!'),
(24, 23, 'I\'m in, Noah! Let\'s push ourselves to the limit.'),
(25, 1, 'I saw your post about coding, John. You\'re doing great!'),
(1, 25, 'Thanks, Chris! Your support means a lot to me!'),
(2, 3, 'Mike, I saw your post about running. That\'s incredible!'),
(3, 2, 'Thanks, Jane! I\'ve been training hard.'),
(4, 5, 'David, I tried your recipe. It turned out amazing!'),
(5, 4, 'So glad you liked it, Emily! What did you think of the flavor?');

-- Insert 25 sample notifications into the notifications table
INSERT INTO notifications (user_id, notification_type, related_entity_id, message)
VALUES
(2, 'like', 1, 'John liked your post: "Excited to start my new journey in coding!"'),
(3, 'comment', 1, 'Jane commented on your post: "That\'s awesome, John! Start with the basics."'),
(4, 'like', 2, 'Mike liked your post: "Loving the new book I just picked up. Anyone else into reading?"'),
(5, 'like', 3, 'Olivia liked your post: "Just finished a 10-mile run! Feeling great!"'),
(6, 'comment', 3, 'Emily commented on your post: "Wow, Mike! Keep it up! I need to get to your level."'),
(7, 'like', 4, 'David liked your post: "Trying a new recipe today. Can\'t wait to share it with you all!"'),
(8, 'comment', 5, 'Sarah commented on your post: "Tech tips coming your way! Check out this cool framework."'),
(9, 'like', 6, 'Rachel liked your post: "Had a wonderful weekend at the beach!"'),
(10, 'message', 7, 'John sent you a message: "Hey Jane, I just started learning to code! Any tips?"'),
(11, 'like', 7, 'James liked your post: "Trying out a new hiking trail. Nature is beautiful!"'),
(12, 'comment', 9, 'Victoria commented on your post: "Fitness goals are so important! Keep going!"'),
(13, 'like', 9, 'Henry liked your post: "Celebrating small victories today. Every step counts!"'),
(14, 'message', 10, 'Mike sent you a message: "Your new blog post is amazing!"'),
(15, 'like', 11, 'Zoey liked your post: "A cup of coffee and good conversation."'),
(16, 'like', 12, 'Chris liked your post: "I\'m launching a new product today!"'),
(17, 'message', 12, 'David sent you a message: "Can you share that new recipe with me?"'),
(18, 'comment', 13, 'Andrew commented on your post: "Love this view! Where are you hiking?"'),
(19, 'like', 14, 'Rachel liked your post: "Happy to announce a big personal achievement!"'),
(20, 'like', 15, 'Emily liked your post: "What a great day at the park with the family!"'),
(21, 'comment', 17, 'Olivia commented on your post: "Congratulations on your new online store! I\'ll definitely check it out!"'),
(22, 'message', 18, 'Sarah sent you a message: "Your new fitness routine is inspiring!"'),
(23, 'like', 19, 'Zoey liked your post: "Can\'t wait to see the fitness results!"'),
(24, 'comment', 20, 'Daniel commented on your post: "Every step counts! Let\'s keep moving forward!"'),
(25, 'like', 21, 'Chris liked your post: "Spending the weekend getting creative with some new art ideas."');

-- Insert 25 sample shares into the post_shares table
INSERT INTO post_shares (post_id, user_id)
VALUES
(1, 2),  -- User 2 shares Post 1
(1, 3),  -- User 3 shares Post 1
(2, 4),  -- User 4 shares Post 2
(2, 5),  -- User 5 shares Post 2
(3, 6),  -- User 6 shares Post 3
(3, 7),  -- User 7 shares Post 3
(4, 8),  -- User 8 shares Post 4
(5, 9),  -- User 9 shares Post 5
(5, 10), -- User 10 shares Post 5
(6, 11), -- User 11 shares Post 6
(7, 12), -- User 12 shares Post 7
(8, 13), -- User 13 shares Post 8
(8, 14), -- User 14 shares Post 8
(9, 15), -- User 15 shares Post 9
(9, 16), -- User 16 shares Post 9
(10, 17), -- User 17 shares Post 10
(11, 18), -- User 18 shares Post 11
(12, 19), -- User 19 shares Post 12
(12, 20), -- User 20 shares Post 12
(13, 21), -- User 21 shares Post 13
(14, 22), -- User 22 shares Post 14
(15, 23), -- User 23 shares Post 15
(16, 24), -- User 24 shares Post 16
(17, 25), -- User 25 shares Post 17
(18, 1);  -- User 1 shares Post 18

-- Get User Profile Information (Including Bio, Date of Birth, Gender, etc.):
-- Retrieve full profile information for a specific user, including bio, date of birth, and gender.

SELECT u.username, u.full_name, u.email, u.bio, u.profile_picture_url, up.date_of_birth, up.location, up.website, up.phone_number, up.gender
FROM users u
JOIN user_profiles up ON u.user_id = up.user_id
WHERE u.user_id = 3;  -- Replace with the desired user_id

-- Get All Posts of a Specific User with Like Count:
-- Get all posts made by a specific user, along with the count of likes for each post.

SELECT p.post_id, p.content, p.image_url, p.created_at, COUNT(l.like_id) AS like_count
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE p.user_id = 3  -- Replace with the desired user_id
GROUP BY p.post_id
ORDER BY p.created_at DESC;

-- Get All Comments on a Specific Post:
-- Retrieve all comments for a specific post, including the user's name who made the comment.

SELECT c.comment_id, c.content, c.created_at, u.username, u.full_name
FROM comments c
JOIN users u ON c.user_id = u.user_id
WHERE c.post_id = 1  -- Replace with the desired post_id
ORDER BY c.created_at DESC;

-- Get Total Number of Likes for a Specific Post:
-- Find the total number of likes for a specific post.

SELECT p.post_id, COUNT(l.like_id) AS total_likes
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE p.post_id = 1  -- Replace with the desired post_id
GROUP BY p.post_id;

-- Get Total Number of Messages Between Two Users:
-- Find the total number of messages exchanged between two users.

SELECT COUNT(m.message_id) AS total_messages
FROM messages m
WHERE (m.sender_id = 1 AND m.receiver_id = 2)  -- Replace with the user_ids
   OR (m.sender_id = 2 AND m.receiver_id = 1);
   
-- Get All Messages Sent by a User:
-- Retrieve all messages sent by a specific user, including the recipient and message content.
   
SELECT m.message_id, m.message_content, m.created_at, u.username AS recipient
FROM messages m
JOIN users u ON m.receiver_id = u.user_id
WHERE m.sender_id = 1  -- Replace with the desired sender user_id
ORDER BY m.created_at DESC;

-- Get All Notifications for a User:
-- List all notifications for a user, including the type of notification and whether it’s been read.

SELECT n.notification_id, n.notification_type, n.message, n.is_read, n.created_at
FROM notifications n
WHERE n.user_id = 3  -- Replace with the desired user_id
ORDER BY n.created_at DESC;

-- Get All Shares for a Specific Post:
-- Retrieve all shares for a specific post, including the message shared with the post.

SELECT ps.share_id, ps.share_message, u.username, ps.created_at
FROM post_shares ps
JOIN users u ON ps.user_id = u.user_id
WHERE ps.post_id = 1  -- Replace with the desired post_id
ORDER BY ps.created_at DESC;

-- Get All Posts That a User Has Liked:
-- List all posts that a specific user has liked.

SELECT p.post_id, p.content, p.created_at
FROM posts p
JOIN likes l ON p.post_id = l.post_id
WHERE l.user_id = 1  -- Replace with the desired user_id
ORDER BY p.created_at DESC;

-- Get All Posts with the Number of Shares:
-- Retrieve all posts with the number of times they have been shared.

SELECT p.post_id, p.content, p.created_at, COUNT(ps.share_id) AS share_count
FROM posts p
LEFT JOIN post_shares ps ON p.post_id = ps.post_id
GROUP BY p.post_id
ORDER BY p.created_at DESC;

-- Get All Notifications for a Specific Post (Like, Comment, Share):
-- Retrieve all notifications related to a specific post (likes, comments, shares, etc.).

SELECT n.notification_type, n.message, n.is_read, n.created_at
FROM notifications n
WHERE n.related_entity_id = 1  -- Replace with the desired post_id
  AND n.notification_type IN ('like', 'comment', 'post_share')
ORDER BY n.created_at DESC;

-- Get the Total Number of Comments on a Post:
-- Get the total number of comments made on a post.

SELECT p.post_id, COUNT(c.comment_id) AS total_comments
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE p.post_id = 1  -- Replace with the desired post_id
GROUP BY p.post_id;

-- Get All Users Who Have Shared a Specific Post:
-- List all users who have shared a specific post, along with their share messages.

SELECT u.username, u.full_name, ps.share_message, ps.created_at
FROM post_shares ps
JOIN users u ON ps.user_id = u.user_id
WHERE ps.post_id = 1  -- Replace with the desired post_id
ORDER BY ps.created_at DESC;

-- Get Users Who Have Received Messages from Another User:
-- Find all users who have received messages from a specific user.

SELECT DISTINCT u.username, u.full_name
FROM messages m
JOIN users u ON m.receiver_id = u.user_id
WHERE m.sender_id = 1  -- Replace with the sender's user_id
ORDER BY u.username;

-- Get All Posts That Mention a Specific Word (Based on Post Content):
-- List all posts that mention a specific word.

SELECT p.post_id, p.content, p.created_at
FROM posts p
WHERE p.content LIKE '%beach%'  -- Replace with the @username of the mentioned user
ORDER BY p.created_at DESC;

-- Get All Users Who Are Following a Post (Based on Likes, Shares, Comments):
-- Find all users who have interacted with a post (liked, commented, or shared it).

SELECT DISTINCT u.username, u.full_name
FROM users u
LEFT JOIN likes l ON u.user_id = l.user_id
LEFT JOIN comments c ON u.user_id = c.user_id
LEFT JOIN post_shares ps ON u.user_id = ps.user_id
WHERE l.post_id = 1  -- Replace with the post_id
   OR c.post_id = 1  -- Replace with the post_id
   OR ps.post_id = 1  -- Replace with the post_id
ORDER BY u.username;

-- Get All Posts Shared by a Specific User (including Share Message):
-- List all posts shared by a specific user, along with any accompanying share messages.

SELECT p.post_id, p.content, ps.share_message, ps.created_at
FROM posts p
JOIN post_shares ps ON p.post_id = ps.post_id
WHERE ps.user_id = 1  -- Replace with the target user_id
ORDER BY ps.created_at DESC;

-- Get Most Active Friend in Terms of Messages:
-- Identify the most active friend of a specific user based on the number of messages exchanged.

SELECT u.username, u.full_name, COUNT(m.message_id) AS message_count
FROM messages m
JOIN users u ON m.sender_id = u.user_id
WHERE m.receiver_id = 1  -- Replace with the target user_id
GROUP BY u.user_id
ORDER BY message_count DESC
LIMIT 1;

--  Get All Notifications Related to Posts (Likes, Comments, Shares) for a User:
-- List all notifications related to posts (likes, comments, shares) for a specific user.

SELECT n.notification_type, n.message, n.is_read, n.created_at
FROM notifications n
WHERE n.user_id = 3  -- Replace with the target user_id
  AND n.notification_type IN ('like', 'comment', 'post_share')
ORDER BY n.created_at DESC;

-- Get Posts That Have Both Comments and Likes:
-- Find posts that have at least one comment and one like.

SELECT p.post_id, p.content, p.created_at
FROM posts p
JOIN comments c ON p.post_id = c.post_id
JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id
HAVING COUNT(c.comment_id) > 0 AND COUNT(l.like_id) > 0;

-- Get All Users Who Have Sent Messages to a Specific User:
-- Find all users who have sent messages to a particular user.

SELECT DISTINCT u.username, u.full_name
FROM users u
JOIN messages m ON u.user_id = m.sender_id
WHERE m.receiver_id = 1  -- Replace with the target user_id
ORDER BY u.username;

-- Get All Unread Messages for a User:
-- Retrieve all unread messages for a specific user.

SELECT m.message_id, m.message_content, m.created_at, u.username AS sender
FROM messages m
JOIN users u ON m.sender_id = u.user_id
WHERE m.receiver_id = 1  -- Replace with the desired user_id
  AND m.read_status = FALSE
ORDER BY m.created_at DESC;

-- Get Users Who Have Shared Any Posts:
-- List all users who have shared any posts.

SELECT u.user_id, u.username, u.full_name
FROM users u
LEFT JOIN post_shares ps ON u.user_id = ps.user_id
WHERE ps.share_id IS not NULL;

-- Get Total Number of Posts Liked by a User:
-- Find the total number of posts liked by a specific user.

SELECT COUNT(DISTINCT l.post_id) AS total_liked_posts
FROM likes l
WHERE l.user_id = 1;  -- Replace with the desired user_id

-- Get All Posts of a Specific User and Their Comments Count:
-- Get all posts of a specific user along with the count of comments on each post.

SELECT p.post_id, p.content, p.created_at, COUNT(c.comment_id) AS comment_count
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE p.user_id = 1  -- Replace with the desired user_id
GROUP BY p.post_id
ORDER BY p.created_at DESC;

-- Get Most Liked Post of a Specific User:
-- Retrieve the most liked post of a specific user, ordered by the number of likes.

SELECT p.post_id, p.content, COUNT(l.like_id) AS like_count
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
WHERE p.user_id = 1  -- Replace with the desired user_id
GROUP BY p.post_id
ORDER BY like_count DESC
LIMIT 1;  -- Get only the most liked post

-- Get the Most Commented Post for a Specific User:
-- Retrieve the post with the highest number of comments made by a specific user.

SELECT p.post_id, p.content, COUNT(c.comment_id) AS comment_count
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE p.user_id = 1  -- Replace with the target user_id
GROUP BY p.post_id
ORDER BY comment_count DESC
LIMIT 1;

-- Get Posts That Have Been Shared the Most:
-- Retrieve the posts that have been shared the most by users.

SELECT p.post_id, p.content, COUNT(ps.share_id) AS share_count
FROM posts p
LEFT JOIN post_shares ps ON p.post_id = ps.post_id
GROUP BY p.post_id
ORDER BY share_count DESC
LIMIT 5;

-- Get the Most Active User in Terms of Comments on Posts:
-- Identify the user who has made the most comments on posts.

SELECT u.username, u.full_name, COUNT(c.comment_id) AS comment_count
FROM users u
JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id
ORDER BY comment_count DESC
LIMIT 1;

-- Get Users Who Have Sent Messages to a Specific User:
-- List all users who have sent messages to a specific user.

SELECT DISTINCT u.username, u.full_name
FROM users u
JOIN messages m ON u.user_id = m.sender_id
WHERE m.receiver_id = 1  -- Replace with the target user_id
ORDER BY u.username;

-- Get Unread Notifications for a Specific User:
-- Retrieve all unread notifications for a specific user.

SELECT n.notification_id, n.notification_type, n.message, n.created_at
FROM notifications n
WHERE n.user_id = 3  -- Replace with the user_id
  AND n.is_read = FALSE
ORDER BY n.created_at DESC;

-- Get Total Number of Posts Made in a Specific Time Period:
-- Find the total number of posts made in the last 30 days.

SELECT COUNT(p.post_id) AS total_posts
FROM posts p
WHERE p.created_at > NOW() - INTERVAL 30 DAY;

-- Get the Total Number of Comments by All Users:
-- Retrieve the total number of comments made by all users on the platform

SELECT COUNT(c.comment_id) AS total_comments
FROM comments c;



   


























