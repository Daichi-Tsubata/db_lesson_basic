
Q1
新しいテーブルの追加
CREATE TABLE `departments` (
`department_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR (20)NOT NULL,
`created_at`TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
`updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


Q2
peopleへのカラム追加
カラムの追加
ALTER TABLE people ADD department_id INT UNSIGNED COMMENT '1営業 2開発 3経理 4人事 5情シス';
カラムの順番の変更
ALTER TABLE people MODIFY department_id INT UNSIGNED AFTER email;


訂正
ALTER TABLE people ADD department_id INT UNSIGNED AFTER email;

Q3
レコードの追加
部署
INSERT INTO departments (name) VALUES 
("営業"),
("開発"),
("経理"),
("人事"),
("情報システム"),

UPDATE departments SET name = '営業' WHERE department_id = 1;
UPDATE departments SET name = '開発' WHERE department_id = 2;
UPDATE departments SET name = '経理' WHERE department_id = 3;
UPDATE departments SET name = '人事' WHERE department_id = 4;
UPDATE departments SET name = '情報システム' WHERE department_id = 5;
人
UPDATE people SET department_id = 1 WHERE person_id = 1;
UPDATE people SET department_id = 1 WHERE person_id = 2;
UPDATE people SET department_id = 1 WHERE person_id = 3;
UPDATE people SET department_id = 2 WHERE person_id = 4;
UPDATE people SET department_id = 2 WHERE person_id = 6;
UPDATE people SET department_id = 2 WHERE person_id = 7;

INSERT INTO people (name, email, department_id, age, gender)VALUES
("猫 ひろし","neko@gizumo.jp",2,47,1),
("たむら けんじ","tamu@gizumo.jp",3,51,1),
("渡辺 直美","watanabe@gizumo.jp",4,37,2),
("本田 翼","tubasa@gizumo.jp",5,32,2);

UPDATE people SET person_id = 5 WHERE person_id = 11;
 
 日報
 UPDATE reports SET content = "特に書くことがない…文字数稼ぎ" WHERE person_id = 1;
 UPDATE reports SET content = "今日の晩御飯はロールキャベツでした" WHERE person_id = 2;
 UPDATE reports SET content = "キャンプってお金かからない趣味だと思ってました" WHERE person_id = 3;
 UPDATE reports SET content = "実は全然そんなことなかったです" WHERE person_id = 4;
 UPDATE reports SET content = "まず車を用意する段階で200万消えます" WHERE person_id = 5;
 UPDATE reports SET content = "そして他のギアも大体１万近い物だらけです" WHERE person_id = 6;

INSERT INTO reports(person_id,content) VALUES( 7,'早くプログラマーになって沢山キャンプ行きたい');
INSERT INTO reports(person_id,content) VALUES( 8,'さぁいよいよ書くことが無くなってきた');
INSERT INTO reports(person_id,content) VALUES( 9,'でももうすぐで１０件分書き終わるぞ');
INSERT INTO reports(person_id,content) VALUES( 10,'長男だから頑張れる、次男なら無理だった');

Q4
申し訳ありません。
問題をよく理解しておらず、Q3の段階でもともといた人に部署と日報を割り振ってしまっておりました。
この人たち以外に10人追加しなくては行けなったようですね…

UPDATE people SET department_id = "1" WHERE person_id = 12;

Q5
年齢の降順で男性の名前と年齢を取得
SELECT name,age FROM people WHERE gender = 1  ORDER BY age DESC;

Q6
テーブル・レコード・カラムという3つの単語を適切に使用して、下記のSQL文を日本語で説明
SELECT
  `name`, `email`, `age`
FROM
  `people`
WHERE
  `department_id` = 1
ORDER BY
  `created_at`;

 selectでカラム（陳列棚）を指定して
 fromでテーブル（コーナー）を指定して
 whereでレコード（商品名）を指定する
ORDER BYでは期待結果を並べ替える句なので今回は作成日時（created_at）で並べ替えてる

Q7
20代の女性と40代の男性の名前一覧を取得
SELECT name
FROM people
WHERE (gender = 2 AND age BETWEEN 20 AND 29)
OR (gender = 1 AND age BETWEEN 40 AND 49);


Q8
営業部に所属する人だけを年齢の昇順で取得
SELECT name,age,department_id
FROM people
WHERE(department_id = 1)ORDER BY age asc;
「ORDER BY age asc;」はディフォルトが昇順なので今回はなくても可

Q9
開発部に所属している女性の平均年齢を取得
SELECT AVG(age) AS average_age
FROM people
WHERE department_id = 2 AND gender = 2;

Q10
名前と部署名とその人が提出した日報の内容を同時に取得（日報を提出していない人は含めない）

SELECT 
p.name AS person_name, 
d.name AS department_name, 
r.content AS report_content
FROM 
people p
JOIN 
reports r ON p.person_id = r.person_id
JOIN 
departments d ON p.department_id = d.department_id
WHERE 
r.content IS NOT NULL;

Q11
日報を一つも提出していない人の名前一覧を取得してください。

SELECT p.name
FROM people AS p
LEFT JOIN reports AS r ON p.person_id = r.person_id
WHERE r.report_id IS NULL;
全ての人に部署と日報を割り当ててしまっていた為、Empty set が出ていました。
その為、以下の人物を追加しました。
INSERT INTO people (name, email, age, gender) VALUES ('松橋 嬉', 'yosi@gizumo.jp', 25, 2);