# Quiz and Question Microservices

This project demonstrates the implementation of microservices architecture using Spring Boot, focusing on the development of two primary services: Quiz Service and Question Service. <br>
The project is designed to practice and enhance skills in:

    Java Streams and Lambda Expressions
    Spring Boot
    Microservices architecture
    Inter-service communication using OpenFeign
    Liquibase for database versioning (to be applied soon)

## Project Overview: <br>
1) Microservices


    Quiz Service: Manages quizzes, including the list of questions for each quiz and the calculation of quiz results.
    Question Service: Manages individual questions and their details.

2) Database Structure


    Both services share a single database but operate within separate schemas.
    Schemas:
        quiz_schema for the Quiz Service
        question_schema for the Question Service

3) Technologies Used


    Spring Boot for building the microservices.
    Spring Data JPA for data persistence.
    PostgreSQL as the database.
    Eureka for service discovery.
    Spring Cloud Gateway for routing.
    OpenFeign for declarative REST client.
    Liquibase for database migrations (to be applied soon).


## SQL Scripts
1) Database Creation

`CREATE DATABASE quizapp_db;`

2) Schema Creation

`CREATE SCHEMA quiz_schema;
CREATE SCHEMA question_schema;`

3) Table Creation

`CREATE TABLE question ( 
id SERIAL PRIMARY KEY, 
category VARCHAR(255) NOT NULL, 
difficulty_level VARCHAR(255) not null,
question_title VARCHAR(255) NOT NULL, 
option1 VARCHAR(255) not null,
option2 VARCHAR(255) not null,
option3 VARCHAR(255) not null,
option4 VARCHAR(255) not null,
right_answer VARCHAR(255) NOT null)`

4) Insert Data <br>

`INSERT INTO question
(category, difficulty_level, option1, option2, option3, option4, question_title, right_answer)
VALUES
('Java', 'Easy', 'class', 'interface', 'extends', 'implements', 'Which Java keyword is used to create a subclass?', 'extends'),
('Java', 'Easy', '4', '5', '6', 'Compile error', 'What is the output of the following Java code snippet? \nint x = 5; \nSystem.out.println(x++);', '5'),
('Java', 'Easy', 'TRUE', 'FALSE', '0', 'null', 'In Java, what is the default value of an uninitialized boolean variable?', 'FALSE'),
('Java', 'Easy', 'try', 'throw', 'catch', 'finally', 'Which Java keyword is used to explicitly throw an exception?', 'throw'),
('Java', 'Easy', 'It indicates that a variable is constant.', 'It indicates that a method can be accessed without creating an instance of the class.', 'It indicates that a class cannot be extended.', 'It indicates that a variable is of primitive type.', 'What does the ''static'' keyword mean in Java?', 'It indicates that a method can be accessed without creating an instance of the class.'),
('Java', 'Easy', 'constant int x = 5;', 'final int x = 5;', 'static int x = 5;', 'readonly int x = 5;', 'What is the correct way to declare a constant variable in Java?', 'final int x = 5;'),
('Java', 'Easy', 'for loop', 'while loop', 'do-while loop', 'switch loop', 'Which loop in Java allows the code to be executed at least once?', 'do-while loop'),
('Java', 'Easy', 'To terminate a loop or switch statement and transfer control to the next statement.', 'To skip the rest of the code in a loop and move to the next iteration.', 'To define a label for a loop or switch statement.', 'To check a condition and execute a block of code repeatedly.', 'What is the purpose of the ''break'' statement in Java?', 'To terminate a loop or switch statement and transfer control to the next statement.'),
('Java', 'Easy', '+', '-', '*', '/', 'Which Java operator is used to concatenate two strings?', '+'),
('Java', 'Easy', 'HashMap', 'ArrayList', 'LinkedList', 'HashSet', 'In Java, which collection class provides an implementation of a dynamic array?', 'ArrayList'),
('Python', 'Easy', 'count()', 'size()', 'length()', 'len()', 'Which Python function is used to calculate the length of a list?', 'len()'),
('Python', 'Easy', '[1, 2, 3]', '[1, 2, 3, 4]', '[4, 3, 2, 1]', 'Error', 'What is the output of the following Python code snippet? \nx = [1, 2, 3] \nx.append(4) \nprint(x)', '[1, 2, 3, 4]'),
('Python', 'Easy', 'break', 'continue', 'pass', 'return', 'Which Python statement is used to exit from a loop prematurely?', 'break'),
('Python', 'Easy', 'To generate a random number within a given range.', 'To iterate over a sequence of numbers.', 'To sort a list in ascending order.', 'To calculate the length of a string.', 'What is the purpose of the ''range()'' function in Python?', 'To iterate over a sequence of numbers.'),
('Python', 'Easy', 'int', 'float', 'str', 'list', 'In Python, which data type is mutable?', 'list'),
('Python', 'Easy', 'datetime', 'math', 'os', 'sys', 'Which Python module is used for working with dates and times?', 'datetime')
;`

## API Endpoints
http://localhost:8765
1) Quiz Service

    `POST /quiz/create`: Create a new quiz. <br>
    `GET /quiz/{id}`: Retrieve a quiz by its ID. <br>
    `POST /quiz/submit/{id}`: Submit responses and calculate the result.

2) Question Service

    `GET /question/{id}:` Retrieve a question by its ID. <br>
    `GET /queston/all:` Retrieve all questions. <br>
    `GET /question/category/{cat}:` Retrieve questions by category. <br>
    `GET /question/get-questions:` Retrieve questions by IDs. <br>
    `POST /question/add:` Create new question. <br>
    `POST /question/generate:` Generate a set of questions based on criteria. <br>
    `POST /question/get-results:` Calculate results based on user responses. <br>
    `PUT /question/edit/{id}:` Edit question details. <br>
    `DELETE /question/delete/{id}:` Remove a question by its ID. <br>
