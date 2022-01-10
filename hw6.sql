USE vk;

/*
 * Задача 1
 * Пусть задан некоторый пользователь. 
 * Из всех друзей этого пользователя найдите человека, 
 * который больше всех общался с нашим пользователем.
 */

SELECT from_user_id FROM messages m 
WHERE to_user_id = 1 GROUP BY from_user_id ORDER BY count(*) DESC LIMIT 1;

/*
 * Задача 2
 * Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.
 */

SELECT count(*) FROM likes WHERE user_id IN (SELECT user_id FROM profiles WHERE (TO_DAYS(NOW()) - TO_DAYS(birthday)) / 365.25 < 11);

/*
 * Задача 3
 * Определить кто больше поставил лайков (всего): мужчины или женщины.
 */

SELECT 
	count(likes.user_id) AS num_likes,
	gender
FROM likes
INNER JOIN profiles 
ON likes.user_id = profiles.user_id
GROUP BY gender
ORDER BY num_likes DESC
LIMIT 1;