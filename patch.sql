--
-- Структура таблицы `prefix_session`
--

CREATE TABLE IF NOT EXISTS `prefix_session` (
  `session_key` varchar(32) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `session_ip_create` varchar(15) NOT NULL,
  `session_ip_last` varchar(15) NOT NULL,
  `session_date_create` datetime NOT NULL default '0000-00-00 00:00:00',
  `session_date_last` datetime NOT NULL,
  PRIMARY KEY  (`session_key`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `prefix_session`
--
ALTER TABLE `prefix_session`
  ADD CONSTRAINT `prefix_session_fk` FOREIGN KEY (`user_id`) REFERENCES `prefix_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
  
ALTER TABLE `prefix_user` DROP `user_key` ;
ALTER TABLE `prefix_user` DROP `user_date_last` ;
ALTER TABLE `prefix_user` DROP `user_ip_last` ;

ALTER TABLE `prefix_friend` DROP FOREIGN KEY `prefix_frend_fk1`;
ALTER TABLE `prefix_friend` CHANGE `user_frend_id` `user_friend_id` INT( 11 ) UNSIGNED;
ALTER TABLE `prefix_friend` ADD CONSTRAINT `prefix_friend_ibfk_1` FOREIGN KEY (`user_friend_id`) REFERENCES `prefix_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `prefix_topic_comment` ADD `comment_publish` TINYINT( 1 ) DEFAULT '1' NOT NULL ;
ALTER TABLE `prefix_topic_comment` DROP FOREIGN KEY `topic_comment_fk`;
ALTER TABLE `prefix_topic_comment` CHANGE `topic_id` `target_id` INT( 11 ) UNSIGNED;
ALTER TABLE `prefix_topic_comment` ADD `target_type` ENUM( "topic", "talk" ) DEFAULT 'topic' NOT NULL AFTER `target_id` ;

ALTER TABLE `prefix_topic_comment_online` DROP FOREIGN KEY `prefix_topic_comment_online_fk`;
ALTER TABLE `prefix_topic_comment_online` CHANGE `topic_id` `target_id` INT( 11 ) UNSIGNED DEFAULT NULL ;
ALTER TABLE `prefix_topic_comment_online` ADD `target_type` ENUM( "topic", "talk" ) DEFAULT 'topic' NOT NULL AFTER `target_id` ;

ALTER TABLE `prefix_topic_comment` RENAME `prefix_comment` ;
ALTER TABLE `prefix_topic_comment_online` RENAME `prefix_comment_online` ;

ALTER TABLE `prefix_topic_vote` RENAME `prefix_vote` ;
ALTER TABLE `prefix_vote` DROP FOREIGN KEY `prefix_topic_vote_fk`;
ALTER TABLE `prefix_vote` CHANGE `topic_id` `target_id` INT( 11 ) UNSIGNED;
ALTER TABLE `prefix_vote` ADD `target_type` ENUM( "topic", "blog", "user", "comment" ) DEFAULT 'topic' NOT NULL AFTER `target_id` ;
ALTER TABLE `prefix_vote` CHANGE `vote_delta` `vote_direction` TINYINT( 2 ) DEFAULT '0';
ALTER TABLE `prefix_vote` ADD `vote_value` FLOAT( 9, 3 ) DEFAULT '0' NOT NULL ;
ALTER TABLE `prefix_vote` ADD `vote_date` DATETIME NOT NULL ;
ALTER TABLE `prefix_vote` DROP INDEX `topic_id_user_voter_id_uniq` ;
ALTER TABLE `prefix_vote` DROP INDEX `topic_id` ;
ALTER TABLE `prefix_vote` ADD PRIMARY KEY ( `target_id` , `target_type` , `user_voter_id` ) ;


ALTER TABLE `prefix_talk` ADD `talk_count_comment` INT DEFAULT '0' NOT NULL ;
ALTER TABLE `prefix_talk_user` ADD `comment_id_last` INT DEFAULT '0' NOT NULL ;
ALTER TABLE `prefix_talk_user` ADD `comment_count_new` INT DEFAULT '0' NOT NULL ;
--
-- Переход на единую систему избранного
--
ALTER TABLE  `prefix_favourite_topic` RENAME  `prefix_favourite`;
ALTER TABLE  `prefix_favourite` DROP INDEX  `topic_id`;
ALTER TABLE  `prefix_favourite` DROP INDEX  `topic_publish`;
ALTER TABLE  `prefix_favourite` CHANGE  `topic_id`  `target_id` INT( 11 ) UNSIGNED;
ALTER TABLE  `prefix_favourite` CHANGE  `topic_publish`  `target_publish` TINYINT( 1 ) DEFAULT  '1';
ALTER TABLE  `prefix_favourite` ADD  `target_type` ENUM(  'topic',  'comment' ) DEFAULT  'topic' NOT NULL AFTER  `target_id` ;
ALTER TABLE  `prefix_favourite` DROP INDEX  `user_id_topic_id`,
ADD UNIQUE  `user_id_target_id_type` (  `user_id` ,  `target_id` ,  `target_type` );
ALTER TABLE  `prefix_favourite` DROP INDEX  `topic_publish`,
ADD INDEX  `target_publish` (  `target_publish` );