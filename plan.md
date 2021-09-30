cduser will be able to
  - choose from a list of three surveys
  - go to fill out a new survey
  - see a list of scores and dates of survey
  - sign up
  - sign in
  - log out
  - remove a survey
  - delete account
  
database will need
  - users
    - id
    - name
    - passwordhash
  - anxietysurveys
    - id
    - user_id
    - date
    - score
  - depressionsurveys
    - id
    - user_id
    - date
    - score
  - relationshipsurveys
    - id
    - user_id
    - date
    - score

screens needed
- log in/sign up
- logged in home page
- new anxiety survey
- new depression survey
- new relationship survey
- see reports/remove reports
  - filter by date or type of survey, show degree of symptoms
- delete account

helper programs
- given a list of questions and a list responses, a program will output the appropriate html I can use

currently - 
- working on signing in, trying to save userid in session, and give error message if not