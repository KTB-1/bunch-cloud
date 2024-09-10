-- 풀스택DB 초기화 스크립트
CREATE DATABASE fullstackDB;
USE fullstackDB;

CREATE TABLE Users (
    userId VARCHAR(255) NOT NULL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    profileUrl VARCHAR(255),
    createdAt TIMESTAMP NOT NULL,
    updateAt TIMESTAMP NOT NULL
);

CREATE TABLE Uris (
    urlId BIGINT NOT NULL PRIMARY KEY,
    userId VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    isDeleted BOOLEAN DEFAULT FALSE,
    created TIMESTAMP NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users(userId)
);

CREATE TABLE Relations (
    relationId BIGINT NOT NULL PRIMARY KEY,
    followerId VARCHAR(255) NOT NULL,
    followeeId VARCHAR(255) NOT NULL,
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    createdAt TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP NOT NULL,
    isDeleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (followerId) REFERENCES Users(userId),
    FOREIGN KEY (followeeId) REFERENCES Users(userId)
);

CREATE TABLE Posts (
    postId BIGINT NOT NULL PRIMARY KEY,
    userId VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    newsUrl VARCHAR(255),
    content TEXT,
    createdAt TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP NOT NULL,
    isDeleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (userId) REFERENCES Users(userId)
);



-- 인공지능DB 초기화 스크립트
CREATE DATABASE aiDB;
USE aiDB;

CREATE TABLE IF NOT EXISTS News (
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

CREATE TABLE IF NOT EXISTS UserNewsViews (
        view_id INT AUTO_INCREMENT PRIMARY KEY,
        user_id VARCHAR(255),
        news_id INT,
        view_date VARCHAR(255),
        FOREIGN KEY (news_id) REFERENCES News(news_id)
);



-- 사용자 생성 및 권한 부여
CREATE USER 'fullstackDB_user'@'%' IDENTIFIED BY 'fullstack1234';
GRANT ALL PRIVILEGES ON fullstackDB.* TO 'fullstackDB_user'@'%';
FLUSH PRIVILEGES;

CREATE USER 'aiDB_user'@'%' IDENTIFIED BY 'ai1234';
GRANT ALL PRIVILEGES ON aiDB.* TO 'aiDB_user'@'%';
FLUSH PRIVILEGES;
