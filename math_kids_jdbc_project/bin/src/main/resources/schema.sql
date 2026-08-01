-- ============================================================
-- SQL Schema PostgreSQL cho hệ thống Website Học Toán Trẻ Em
-- ============================================================

DROP TABLE IF EXISTS progress CASCADE;
DROP TABLE IF EXISTS quizzes CASCADE;
DROP TABLE IF EXISTS lessons CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Bảng người dùng (trẻ em / phụ huynh / admin)
CREATE TABLE users (
    id          SERIAL PRIMARY KEY,
    username    VARCHAR(50) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    full_name   VARCHAR(100),
    role        VARCHAR(20) NOT NULL DEFAULT 'CHILD', -- ADMIN / CHILD
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng bài học toán
CREATE TABLE lessons (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    description TEXT,
    grade       INT NOT NULL DEFAULT 1,
    content     TEXT,
    video_url   VARCHAR(500),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng câu đố / bài tập trắc nghiệm
CREATE TABLE quizzes (
    id              SERIAL PRIMARY KEY,
    lesson_id       INT NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
    question        TEXT NOT NULL,
    option_a        VARCHAR(255) NOT NULL,
    option_b        VARCHAR(255) NOT NULL,
    option_c        VARCHAR(255) NOT NULL,
    option_d        VARCHAR(255) NOT NULL,
    correct_option  CHAR(1) NOT NULL CHECK (correct_option IN ('A','B','C','D')),
    explanation     TEXT,
    points          INT DEFAULT 10
);

-- Bảng tiến độ học tập
CREATE TABLE progress (
    id              SERIAL PRIMARY KEY,
    user_id         INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    quiz_id         INT NOT NULL REFERENCES quizzes(id) ON DELETE CASCADE,
    selected_option CHAR(1),
    is_correct      BOOLEAN,
    score           INT DEFAULT 0,
    completed_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, quiz_id)
);

-- Dữ liệu mẫu
INSERT INTO users (username, password, full_name, role) VALUES
('admin', 'admin123', 'Quản trị viên', 'ADMIN'),
('be_nam', '123456', 'Bé Nam', 'CHILD'),
('be_linh', '123456', 'Bé Linh', 'CHILD');

INSERT INTO lessons (title, description, grade, content, video_url) VALUES
('Cộng hai số đến 10', 'Học cách cộng hai số có tổng không vượt quá 10', 1,
 'Cộng là ghép hai nhóm đồ vật lại với nhau. Ví dụ: 3 quả táo + 2 quả táo = 5 quả táo.', NULL),
('Trừ trong phạm vi 10', 'Học phép trừ khi số bị trừ không vượt quá 10', 1,
 'Trừ là lấy đi một phần. Ví dụ: 7 kẹo - 2 kẹo = 5 kẹo.', NULL),
('Nhận biết hình học', 'Làm quen với hình tròn, vuông, tam giác, chữ nhật', 1,
 'Hình tròn tròn trịa, hình vuông có 4 cạnh bằng nhau, tam giác có 3 cạnh.', NULL);

INSERT INTO quizzes (lesson_id, question, option_a, option_b, option_c, option_d, correct_option, explanation, points) VALUES
(1, '3 + 2 = ?', '4', '5', '6', '7', 'B', '3 + 2 = 5', 10),
(1, '4 + 4 = ?', '7', '8', '9', '10', 'B', '4 + 4 = 8', 10),
(1, '1 + 6 = ?', '5', '6', '7', '8', 'C', '1 + 6 = 7', 10),
(2, '7 - 2 = ?', '4', '5', '6', '7', 'B', '7 - 2 = 5', 10),
(2, '9 - 4 = ?', '4', '5', '6', '3', 'B', '9 - 4 = 5', 10),
(3, 'Hình nào có 3 cạnh?', 'Tròn', 'Vuông', 'Tam giác', 'Chữ nhật', 'C', 'Tam giác có 3 cạnh', 10);
