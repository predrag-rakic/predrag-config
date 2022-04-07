https://www.youtube.com/watch?v=6sNmJtoKDCo&ab_channel=CodeSync

## Code

- small PRs
- small commits
- clarified code

- Separation of concerns!!!

- Normalization vs validation
  

## Testing

- Purpose: to gain confidence in system correctness!
- Focus on behavior - less on lower level abstractions
- Test unit of behavior, not the unit of code

- Create DB entries using APIs, public or private
- Not by inserting directly into DB (implementation detail coupling)
- Insert invalid data (according to business rules)
- "Once it starts failing (which it will) I wish you a lot of luck because you are going to need ti!"