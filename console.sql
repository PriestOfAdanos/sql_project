CREATE SCHEMA imdb;
SET SCHEMA 'imdb';

CREATE DOMAIN isbn AS VARCHAR(13);
CREATE DOMAIN copy_number DECIMAL(3) CHECK ( value >=1);

CREATE DOMAIN positive_int INTEGER CHECK ( value >=0);

CREATE TABLE review (
    rating  INTEGER,
    description VARCHAR,
    creator VARCHAR,
    target INTEGER,
    FOREIGN KEY (creator) REFERENCES forum_user(username),
    FOREIGN KEY (target) REFERENCES movie(movieID)
);

CREATE TABLE forum_user (
    name VARCHAR,
    username VARCHAR,
    email VARCHAR,
    password VARCHAR,
    seen_movies positive_int,
    PRIMARY KEY (username),
    FOREIGN KEY (seen_movies) REFERENCES movie(movieID)
);

CREATE TABLE movie (
    movieID INTEGER UNIQUE ,
    title VARCHAR,
    production_year positive_int,
    rating VARCHAR,
    image VARCHAR,
    production_company INTEGER,
    crew VARCHAR,
    PRIMARY KEY (movieID),
    FOREIGN KEY (image) REFERENCES image(url),
    FOREIGN KEY (rating) REFERENCES review(rating),
    FOREIGN KEY (production_company) REFERENCES production_companies(COMPANYID),
    FOREIGN KEY (crew) REFERENCES person(cpr)
);
CREATE TABLE image (
    url VARCHAR,
    description VARCHAR,
    movie positive_int,
    creator VARCHAR,
    PRIMARY KEY (url),
    FOREIGN KEY (creator) REFERENCES person(cpr)
);
CREATE TABLE person (
    cpr VARCHAR, --?
    name VARCHAR,
    birthday DATE,
    gender VARCHAR,
    place_of_birth VARCHAR,
    nb_movie positive_int, --?
    age positive_int,
    isDirector BOOLEAN,
    isActor BOOLEAN,
    isProducer BOOLEAN,
    isWriter BOOLEAN,
    biography VARCHAR,
    images VARCHAR,
    PRIMARY KEY (cpr),
    FOREIGN KEY (images) REFERENCES image(url)
);
CREATE TABLE production_companies (
    companyID INTEGER UNIQUE,
    name VARCHAR,
    country VARCHAR,
    productionID INTEGER,
    PRIMARY KEY (companyID),
    FOREIGN KEY (productionID) REFERENCES movie(movieID)
)
