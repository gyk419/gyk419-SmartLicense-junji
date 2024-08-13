CREATE TABLE detail_license
(
    detail_license_idx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	detail_license_name VARCHAR(100) NOT NULL,
    create_date TIMESTAMP DEFAULT NOW(),
    detail_license_description VARCHAR(255),
    license_idx INT NOT NULL
);

CREATE TABLE exam_log_info
(
	idx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	event_time TIMESTAMP DEFAULT NOW(),
    ip VARCHAR(50) NOT NULL,
    device VARCHAR(100) NOT NULL,
    browser_name VARCHAR(50),
    event_type VARCHAR(100) NOT NULL,
    event_type_info VARCHAR(255),
    member_id VARCHAR(100) NOT NULL
);

CREATE TABLE license
(
    license_idx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	license_name VARCHAR(100) NOT NULL,
    create_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE login_log_info
(
	idx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    event_time TIMESTAMP DEFAULT NOW(),
    ip VARCHAR(50) NOT NULL,
    device VARCHAR(100) NOT NULL,
    browser_name VARCHAR(50),
    member_id VARCHAR(100) NOT NULL
);

CREATE TABLE member
(
	member_id VARCHAR(50) NOT NULL PRIMARY KEY,
    member_password VARCHAR(255) NOT NULL,
    member_name VARCHAR(20) NOT NULL,
    member_phone_number VARCHAR(20) NOT NULL,
    member_nickname VARCHAR(30) NOT NULL,
    member_gender CHAR(1),
    is_active CHAR(1) NOT NULL DEFAULT '1',  
    registration_date TIMESTAMP DEFAULT NOW(),
    update_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE question
(
	question_idx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    question TEXT NOT NULL,
    option1 TEXT NOT NULL,
    option2 TEXT NOT NULL,
    option3 TEXT NOT NULL,
    option4 TEXT NOT NULL,
    answer TEXT NOT NULL,
    create_date TIMESTAMP DEFAULT NOW(),
    image VARCHAR(255) DEFAULT NULL,
    subject_idx int NOT NULL,
    question_description TEXT DEFAULT NULL
);

CREATE TABLE session_question
(
	session_question_idx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    exam_date VARCHAR(50) NOT NULL,
    total_question_number INT NOT NULL,
    create_date TIMESTAMP DEFAULT NOW(),
    question_idx INT NOT NULL
);

CREATE TABLE subject
(
    subject_idx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	subject_name VARCHAR(100) NOT NULL,
    subject_number INT NOT NULL,
    question_total_count INT NOT NULL,
    exam_duration INT NOT NULL,
    create_date TIMESTAMP DEFAULT NOW(),
    detail_license_idx int NOT NULL
);

CREATE TABLE exam_record
(
	exam_record_idx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    mode CHAR(4) NOT NULL,
    remaining_time VARCHAR(25) NOT NULL,
    correct_count INT NOT NULL,
    start_test_date VARCHAR(50) NOT NULL,
    member_id VARCHAR(50) NOT NULL,
    exam_date VARCHAR(50) NOT NULL ,
    subject_count INT NOT NULL,
    question_count INT NOT NULL,
    is_pass CHAR(1) NOT NULL,
    create_date TIMESTAMP DEFAULT NOW(),
    detail_license_name VARCHAR(100) NOT NULL,
    is_active CHAR(1) NOT NULL DEFAULT NOW()
);

CREATE TABLE user_select_answer
(
	user_select_answer_idx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    is_correct TINYINT(1) NOT NULL,
    select_answer TEXT NOT NULL,
    start_test_date VARCHAR(50) NOT NULL,
    member_id VARCHAR(50) NOT NULL,
    question_idx int NOT NULL,
    create_date TIMESTAMP DEFAULT NOW()
);

ALTER TABLE detail_license
ADD FOREIGN KEY R_9 (license_idx) REFERENCES license (license_idx);

ALTER TABLE exam_log_info
ADD FOREIGN KEY R_17 (member_id) REFERENCES member (member_id);

ALTER TABLE exam_record
ADD FOREIGN KEY R_20 (member_id) REFERENCES member (member_id);

ALTER TABLE login_log_info
ADD FOREIGN KEY R_16 (member_id) REFERENCES member (member_id);

ALTER TABLE question
ADD FOREIGN KEY R_22 (subject_idx) REFERENCES subject (subject_idx);

ALTER TABLE session_question
ADD FOREIGN KEY R_26 (question_idx) REFERENCES question (question_idx);

ALTER TABLE subject
ADD FOREIGN KEY R_10 (detail_license_idx) REFERENCES detail_license (detail_license_idx);

ALTER TABLE user_select_answer
ADD FOREIGN KEY R_11 (member_id) REFERENCES member (member_id);

ALTER TABLE user_select_answer
ADD FOREIGN KEY R_30 (question_idx) REFERENCES question (question_idx);