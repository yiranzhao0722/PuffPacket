CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	username text,
	email text,
	password text, 
	UNIQUE(username),
	UNIQUE(email)
);

INSERT INTO users(username, email, password) VALUES('admin', 'mail@example.com', '5f4dcc3b5aa765d61d8327deb882cf99');
INSERT INTO users(username, email, password) VALUES('nicola', 'mail@example.com', '7c6a180b36896a0a8c02787eeafb0e4c');
INSERT INTO users(username, email, password) VALUES('alessandro', 'mail@example.com', '6cb75f652a9b52798eb6cf2201057c73');
INSERT INTO users(username, email, password) VALUES('cristian', 'mail@example.com', '819b0643d6b89dc9b579fdfc9094f28e');
INSERT INTO users(username, email, password) VALUES('gianpiero', 'mail@example.com', '34cc93ece0ba9e3f6f235d4af979b16c');