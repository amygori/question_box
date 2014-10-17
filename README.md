## Question Box

This Rails application provides much of the same functionality as Stack Overflow.

### Models

* User
    * requires a name
    * requires an email, which must be unique
    * requires a password
    * has many comments
    * has many votes
* Question
    * requires a title
    * requires text
    * belongs to and requires a user
    * has many comments (polymorphic association)
    * has many votes (polymorphic association)
    * knows its total score (determined by votes)
    * has and belongs to many tags (tags being short phrases that show the topics of the question)
* Answer
    * belongs to and requires a question
    * belongs to and requires a user
    * requires text
    * can be chosen as the correct answer
        * but only one answer per question can be chosen
        * the author of the answer gets +100 points
    * has many comments (polymorphic association)
    * has many votes (polymorphic association)
    * knows its total score (determined by votes)
* Comment
    * belongs to and requires a user
    * belongs to and requires a "commentable" (polymorphic association)
    * requires text
* Vote
    * belongs to a user
    * belongs to a "voteable" (polymorphic association)
    * is positive or negative (+1 or -1)
    * when a positive vote is given to something a user created (question or answer), +10 points to that user
    * when a negative vote is given to something a user created (question or answer), -5 points to that user
    * when a user makes a negative vote, -1 points to that user (yes, it costs from your score to vote something down) 
* Tag
    * has a name
    * has and belongs to many questions
