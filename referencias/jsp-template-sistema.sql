
CREATE DATABASE jsptemplatesistema;

USE jsptemplatesistema;

CREATE TABLE profiles
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(40) NOT NULL,
  CONSTRAINT pk_profiles PRIMARY KEY (id)
);

CREATE TABLE users
(
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(60) NOT NULL,
  telephone CHAR(15) NULL,
  email VARCHAR(60) NULL,
  login CHAR(15) NOT NULL,
  password CHAR(120) NOT NULL,
  CONSTRAINT pk_users PRIMARY KEY (id)
);

CREATE TABLE users_profiles
(
  id_user INTEGER NOT NULL,
  id_profile INTEGER NOT NULL,
  CONSTRAINT pk_users_profiles PRIMARY KEY (id_user, id_profile),
  CONSTRAINT fk_users_profiles_users FOREIGN KEY (id_user) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_users_profiles_profiles FOREIGN KEY (id_profile) REFERENCES profiles(id) ON DELETE CASCADE
);


INSERT INTO profiles (id, name)
VALUES (1, 'Administrador');

INSERT INTO users (id, name, telephone, email, login, password)
VALUES (1, 'admin', null, null, 'admin', '21232f297a57a5a743894a0e4a801fc3');

INSERT INTO users_profiles (id_user, id_profile)
VALUES (1, 1);

