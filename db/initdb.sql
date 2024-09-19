-- 풀스택DB 초기화 스크립트
CREATE DATABASE fullstackdb;
USE fullstackdb;

CREATE TABLE users (
    userId VARCHAR(255) NOT NULL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    profileUrl VARCHAR(255),
    createdAt TIMESTAMP NOT NULL,
    updateAt TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS urls (
    url_id BIGINT(20) NOT NULL AUTO_INCREMENT,
    created_at DATETIME(6) DEFAULT NULL,
    updated_at DATETIME(6) DEFAULT NULL,
    is_deleted BIT(1) NOT NULL DEFAULT 0,
    url VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    PRIMARY KEY (url_id),
    KEY idx_user_id (user_id) -- user_id에 대한 인덱스
);

CREATE TABLE relations (
    relationId BIGINT NOT NULL PRIMARY KEY,
    followerId VARCHAR(255) NOT NULL,
    followeeId VARCHAR(255) NOT NULL,
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    createdAt TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP NOT NULL,
    isDeleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (followerId) REFERENCES users(userId),
    FOREIGN KEY (followeeId) REFERENCES users(userId)
);

CREATE TABLE posts (
    postId BIGINT NOT NULL PRIMARY KEY,
    userId VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    newsUrl VARCHAR(255),
    content TEXT,
    createdAt TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP NOT NULL,
    isDeleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (userId) REFERENCES users(userId)
);



-- 인공지능DB 초기화 스크립트
CREATE DATABASE aidb;
USE aidb;

CREATE TABLE IF NOT EXISTS news (
        news_id INT AUTO_INCREMENT PRIMARY KEY,
        category TEXT,
        news_url VARCHAR(255),
        title VARCHAR(255),
        description TEXT,
        content TEXT,
        summary TEXT,
        publication_date VARCHAR(255),
        embedding INT
);

CREATE TABLE IF NOT EXISTS usernewsviews (
        view_id INT AUTO_INCREMENT PRIMARY KEY,
        user_id VARCHAR(255),
        news_id INT,
        view_date VARCHAR(255),
        FOREIGN KEY (news_id) REFERENCES news(news_id)
);



-- 사용자 생성 및 권한 부여
CREATE USER 'fullstackdb_user'@'%' IDENTIFIED BY 'fullstack1234';
GRANT ALL PRIVILEGES ON fullstackdb.* TO 'fullstackdb_user'@'%';
FLUSH PRIVILEGES;

CREATE USER 'aidb_user'@'%' IDENTIFIED BY 'ai1234';
GRANT ALL PRIVILEGES ON aidb.* TO 'aidb_user'@'%';
GRANT ALL PRIVILEGES ON fullstackdb.urls TO 'aidb_user'@'%';
GRANT SELECT, SHOW VIEW ON fullstackdb.users TO 'aidb_user'@'%';
FLUSH PRIVILEGES;
