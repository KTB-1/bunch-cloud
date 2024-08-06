-- 풀스택DB 초기화 스크립트
CREATE DATABASE fullstackDB;
USE fullstackDB;

CREATE TABLE Users (
    userId BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    profileUrl VARCHAR(255),
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- CREATE TABLE Urls (
--     urlId BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     userId BIGINT NOT NULL,
--     url VARCHAR(255) NOT NULL,
--     isDeleted BOOLEAN NOT NULL DEFAULT FALSE,
--     FOREIGN KEY (userId) REFERENCES Users(userId)
-- );

-- CREATE TABLE Relations (
--     relationId BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     followerId BIGINT NOT NULL,
--     followeeId BIGINT NOT NULL,
--     status ENUM('pending', 'accepted', 'rejected') NOT NULL DEFAULT 'pending',
--     requestedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (followerId) REFERENCES Users(userId),
--     FOREIGN KEY (followeeId) REFERENCES Users(userId)
-- );

-- CREATE TABLE Posts (
--     postId BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--     userId BIGINT NOT NULL,
--     title VARCHAR(255) NOT NULL,
--     newsUrl VARCHAR(255),
--     content TEXT,
--     createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     FOREIGN KEY (userId) REFERENCES Users(userId)
-- );


-- 인공지능DB 초기화 스크립트
CREATE DATABASE aiDB;
USE aiDB;

CREATE TABLE News (
    news_id INT PRIMARY KEY AUTO_INCREMENT,
    news_url VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    summary TEXT,
    embedding TEXT
);

CREATE TABLE UserNewsViews (
    view_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    news_id INT,
    view_date DATETIME,
    FOREIGN KEY (news_id) REFERENCES News(news_id)
);



-- 사용자 생성 및 권한 부여
CREATE USER 'fullstackDB_user'@'%' IDENTIFIED BY 'fullstack1234';
GRANT ALL PRIVILEGES ON fullstackDB.* TO 'fullstackDB_user'@'%';
FLUSH PRIVILEGES;

CREATE USER 'aiDB_user'@'%' IDENTIFIED BY 'ai1234';
GRANT ALL PRIVILEGES ON aiDB.* TO 'aiDB_user'@'%';
FLUSH PRIVILEGES;
