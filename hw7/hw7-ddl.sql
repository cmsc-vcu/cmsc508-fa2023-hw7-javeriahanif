# hw7-ddl.sql

## DO NOT RENAME OR OTHERWISE CHANGE THE SECTION TITLES OR ORDER.
## The autograder will look for specific code sections. If it can't find them, you'll get a "0"

# Code specifications.
# 0. Where there a conflict between the problem statement in the google doc and this file, this file wins.
# 1. Complete all sections below.
# 2. Table names must MATCH EXACTLY to schemas provided.
# 3. Define primary keys in each table as appropriate.
# 4. Define foreign keys connecting tables as appropriate.
# 5. Assign ID to skills, people, roles manually (you must pick the ID number!)
# 6. Assign ID in the peopleskills and peopleroles automatically (use auto_increment)
# 7. Data types: ONLY use "int", "varchar(255)", "varchar(4096)" or "date" as appropriate.

# Section 1
# Drops all tables.  This section should be amended as new tables are added.

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS peopleskills;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS peopleroles;


# ... 
SET FOREIGN_KEY_CHECKS=1;

# Section 2
# Create skills( id,name, description, tag, url, time_commitment)
# ID, name, description and tag cannot be NULL. Other fields can default to NULL.
# tag is a skill category grouping.  You can assign it based on your skill descriptions.
# time committment offers some sense of how much time was required (or will be required) to gain the skill.
# You can assign the skill descriptions.  Please be creative!

DROP TABLE IF EXISTS skills;
CREATE TABLE skills (
    skills_id int NOT NULL,
    name varchar(255) NOT NULL,
    description varchar(255) NOT NULL,
    tag varchar(255) NOT NULL,
    url varchar(255) DEFAULT 'some url',
    time_commitment int DEFAULT (current_time),
    PRIMARY KEY (skills_id)
);

# Section 3
# Populate skills
# Populates the skills table with eight skills, their tag fields must exactly contain “Skill 1”, “Skill 2”, etc.
# You can assign skill names.  Please be creative!

INSERT INTO skills (skills_id,name,description,tag) values 
(1,'cooking','culinary art','Skill 1'),
(2,'dancing','elegant movements','Skill 2'),
(3,'storytelling','dynamic narratives','Skill 3'),
(4,'coding','endless possiblities','Skill 4'),
(5,'photography','visual poetry','Skill 5'),
(6,'game development','inteactive storytelling','Skill 6'),
(7,'interior design','change of atmosphere','Skill 7'),
(8,'fashion','personalized styling','Skill 8');

# Section 4
# Create people( id,first_name, last_name, email, linkedin_url, headshot_url, discord_handle, brief_bio, date_joined)
# ID cannot be null, Last name cannot be null, date joined cannot be NULL.
# All other fields can default to NULL.

DROP TABLE IF EXISTS people;
CREATE TABLE people (
    people_id int NOT NULL,
    first_name varchar(255),
    last_name varchar(255) NOT NULL,
    email varchar(255) DEFAULT 'insert email',
    linkedin_url varchar(255) DEFAULT 'some url',
    headshot_url varchar(255) DEFAULT 'some url',
    discord_handle varchar(255),
    brief_bio varchar(255),
    date_joined date DEFAULT (current_date),
    PRIMARY KEY (people_id)
);



# Section 5
# Populate people with six people.
# Their last names must exactly be “Person 1”, “Person 2”, etc.
# Other fields are for you to assign.

INSERT INTO people (people_id,first_name,last_name,discord_handle,brief_bio) values 
(1,'Gordon Ramsey','Person 1','pickyeater','celebrity chef'),
(2,'Bella Hadid','Person 2','qweeeenn','fashion icon'),
(3,'Choi Yeonjun','Person 3','yawnzzn','it boy'),
(4,'Geto Suguru','Person 4','depress3d','mother in the morning, cult leader at night'),
(5,'Wheat Bread','Person 5','br0wn','lactose free'),
(6,'Michael Scott','Person 6','worldsbestboss','definitely not the best boss ever!'),
(7,'Miles Morales','Person 7','spiderman','no bio needed'),
(8,'Hasan Minhaj','Person 8','guy','comedian'),
(9,'Javeria','Person 9','bluies','sleep-deprived student'),
(10,'Sohee Han','Person 10','xeesoxee','not like other girls!');



# Section 6
# Create peopleskills( id, skills_id, people_id, date_acquired )
# None of the fields can ba NULL. ID can be auto_increment.

DROP TABLE IF EXISTS peopleskills;
CREATE TABLE peopleskills (
    id int auto_increment,
    people_id int,
    FOREIGN KEY (people_id) REFERENCES people(people_id),
    skills_id int,
    FOREIGN KEY (skills_id) REFERENCES skills(skills_id),
    date_acquired date DEFAULT (current_date),
    PRIMARY KEY (id),
    unique (people_id,skills_id)
);


# Section 7
# Populate peopleskills such that:
# Person 1 has skills 1,3,6;
# Person 2 has skills 3,4,5;
# Person 3 has skills 1,5;
# Person 4 has no skills;
# Person 5 has skills 3,6;
# Person 6 has skills 2,3,4;
# Person 7 has skills 3,5,6;
# Person 8 has skills 1,3,5,6;
# Person 9 has skills 2,5,6;
# Person 10 has skills 1,4,5;
# Note that no one has yet acquired skills 7 and 8.
 
INSERT INTO peopleskills (people_id,skills_id) values 
(1,1),
(1,3),
(1,6),
(2,3),
(2,4),
(2,5),
(3,1),
(3,5),
(5,3),
(5,6),
(6,2),
(6,3),
(6,4),
(7,3),
(7,5),
(7,6),
(8,1),
(8,3),
(8,5),
(8,6),
(9,2),
(9,5),
(9,6),
(10,1),
(10,4),
(10,5);

select * from peopleskills;

select
    last_name,
    name,
    tag
from 
    peopleskills a 
    INNER JOIN people b on (a.people_id=b.people_id)
    INNER JOIN skills c on (a.skills_id=c.skills_id)
;

# Section 8
# Create roles( id, name, sort_priority )
# sort_priority is an integer and is used to provide an order for sorting roles

DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
    roles_id int, 
    name VARCHAR(255),
    sort_priority int,
    PRIMARY KEY (roles_id)
);


# Section 9
# Populate roles
# Designer, Developer, Recruit, Team Lead, Boss, Mentor
# Sort priority is assigned numerically in the order listed above (Designer=10, Developer=20, Recruit=30, etc.)

INSERT INTO roles (roles_id,name,sort_priority) values
(1,'Designer',10),
(2,'Developer',20),
(3,'Recruit',30),
(4,'Team Lead',40),
(5,'Boss',50),
(6,'Mentor',60);

# Section 10
# Create peopleroles( id, people_id, role_id, date_assigned )
# None of the fields can be null.  ID can be auto_increment

DROP TABLE IF EXISTS peopleroles;
CREATE TABLE peopleroles (
    id int auto_increment, 
    people_id int,
    FOREIGN KEY (people_id) REFERENCES people(people_id),
    roles_id int,
    FOREIGN KEY (roles_id) REFERENCES roles(roles_id),
    date_assigned date DEFAULT (current_date),
    PRIMARY KEY (id),
    unique (people_id,roles_id)
);

# Section 11
# Populate peopleroles
# Person 1 is Developer 
# Person 2 is Boss, Mentor
# Person 3 is Developer and Team Lead
# Person 4 is Recruit
# person 5 is Recruit
# Person 6 is Developer and Designer
# Person 7 is Designer
# Person 8 is Designer and Team Lead
# Person 9 is Developer
# Person 10 is Developer and Designer

INSERT INTO peopleroles (people_id,roles_id) values
(1,2),
(2,5),
(2,6),
(3,2),
(3,4),
(4,3),
(5,3),
(6,2),
(6,1),
(7,1),
(8,1),
(8,4),
(9,2),
(10,2),
(10,1);