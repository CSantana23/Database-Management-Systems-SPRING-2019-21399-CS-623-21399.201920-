#Creating Database PAPER_REVIEWS

CREATE DATABASE PAPER_REVIEWS ;
USE PAPER_REVIEWS;

#Creating Author Table with EmailAddr as Primary Key

CREATE TABLE Authors (
	EmailAddr VARCHAR(255) PRIMARY KEY,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL
);

#Creating Paper with id as Primary Key
#Auto_Increment function keeps the primary key from repeating

CREATE TABLE Papers (
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(255) NOT NULL,
	absrract TEXT,
	fileName VARCHAR(255) NOT NULL,
	authorId VARCHAR(255) NOT NULL,
	reviewerId VARCHAR(255) NOT NULL, 
	FOREIGN KEY (authorId) REFERENCES Author(emailAddr),
	FOREIGN KEY (reviewerId) REFERENCES Reviewer(emailAddr) 
);

#Creating Reviewer Table with EmailAddr as Primary Key

CREATE TABLE Reviewers (
	emailAddr VARCHAR(255) PRIMARY KEY,
	firstName VARCHAR(255) NOT NULL,
	lastName VARCHAR(255) NOT NULL,
	authorFeedBack TEXT,
	commiteeFeedBack TEXT,
	phoneNum VARCHAR(13) NOT NULL,
	affiliation VARCHAR(255) NOT NULL,
	topicId INT NOT NULL,
FOREIGN KEY (topicId) REFERENCES Topic(id)
);

#Creating Topic Table with ID as Primary Key

CREATE TABLE Topics (
	ID INT PRIMARY KEY AUTO_INCREMENT,
	TopicName VARCHAR(255) NOT NULL
);

#Creating weak entity Review Table with id as Primary Key
#Foreign key are used from papers and reviewers tables

CREATE TABLE Reviews (
	ID INT PRIMARY KEY AUTO_INCREMENT,
	Recommendation TEXT,
	MeritScore TINYINT NOT NULL,
	ReadabilityScore TINYINT NOT NULL,
	RelevanceScore TINYINT NOT NULL,	
	OriginalityScore TINYINT NOT NULL,
	PaperId INT NOT NULL,
	ReviewerId VARCHAR(255) NOT NULL,
	FOREIGN KEY (PaperId) REFERENCES Papers (Id),
	FOREIGN KEY (ReviewerId) REFERENCES Reviewers (EmailAddr)
);

#Create Submits Relation between Author and Paper tables
#Unique keyword creates constraints to ensure the Paper and Author ID are different

CREATE TABLE Author_Submits_Paper(
	AuthorId VARCHAR(255) NOT Null,
	PaperId INT NOT Null,
	FOREIGN KEY (AuthorID) REFERENCES Authors (EmailAddr),
	FOREIGN KEY (PaperID) REFERENCES Papers (ID),
	UNIQUE(PaperID),
	UNIQUE(AuthorID)
);

#Create Submit Relation between Paper and Reviewer

CREATE TABLE Paper_Assigned_Reviewer(
	ReviewerID VARCHAR(255) NOT Null,
	PaperID INT NOT Null,
	FOREIGN KEY (ReviewerID) REFERENCES Reviewers (EmailAddr),
	FOREIGN KEY (PaperID) REFERENCES Papers (ID)
);


#Create Has Relation between Reviewer and Topic

CREATE TABLE Reviewer_Has_Topic(
	ReviewerID VARCHAR(255) NOT Null,
	TopicID INT NOT Null,
	FOREIGN KEY (ReviewerID) REFERENCES Reviewers (EmailAddr),
	FOREIGN KEY (TopicID) REFERENCES Topics (ID),
	UNIQUE(TopicID)
);

#Create Submits Relation between Reviewer and Review

CREATE TABLE Reviewer_Submits_Review(
	ReviewerID VARCHAR(255) NOT Null,
	ReviewID INT NOT Null,
	FOREIGN KEY (ReviewerID) REFERENCES Reviewers (EmailAddr),
	FOREIGN KEY (ReviewID) REFERENCES Reviews (ID),
	UNIQUE(ReviewID)
);
