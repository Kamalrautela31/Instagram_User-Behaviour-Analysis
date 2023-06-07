
use  ig_clone;
select * from users;
select * from likes;
select * from follows;
select * from tags;
select * from comments;
select * from photo_tags;
select * from photos;
-- Mandatory project solutions :
/** 1.)create ER diagram or draw schema for the given database - seperat doc. file is submitted**/

/** 2). we want to reward the user who has been the longest, find the 5 oldest users **/

select username, created_at
from users
order by created_at asc
limit 5;

/** 3). To target inactive users in an email ad campaign, find the users who have never posted a photo **/

SELECT username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

/** 4.) Suppose your are running a contest to find out who got the most likes on a photo. Find out **/

SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

/** 5.) The investor want to know  how many times  does average user post **/

SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2) as Avg_user_post;


/** 6.) A brand want to know which hashtag to use on a post, and find the top5 most used hashtags **/

SELECT tag_name, COUNT(tag_name) AS total
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC
limit 5;

/**7.) To find out if there are bots,find users who have liked every single photos on the site **/

SELECT users.id,username, COUNT(users.id) As total_likes_by_user
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);

/** 8). Find the users who have created instagramid in may and select top 5 newest joiners from it**/

select username,created_at
from users
where monthname(created_at) = 'may' 
order by created_at desc
limit 5;

/** 9.)can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?**/

select  distinct photos.user_id,username
from likes
inner join photos on likes.user_id= photos.user_id
inner join users on users.id= photos.user_id
where username like'c%'  and username REGEXP '[[:digit:]]$';

/** 10.)Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5 **/

SELECT users.username,COUNT(photos.image_url) as photos_posted
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY user_id 
having photos_posted>=3 and photos_posted<=5
order by photos_posted
limit 30
;


