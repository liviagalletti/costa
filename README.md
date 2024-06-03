# Health Metrics Calculator (Python)

### Overview
This Python script calculates various health metrics based on user input such as gender, birthdate, weight, and height. It provides the user with essential health information including age, body mass index (BMI), and basal metabolic rate (BMR).

### Code Explanation

#### Main Function (`main()`):
- **User Input**: Prompts the user to input their gender, birthdate, weight, and height.
- **Metric Calculation**: Calls helper functions to compute age, convert weight and height units, calculate BMI, and BMR.
- **Output**: Displays the calculated metrics including age, weight (in kilograms), height (in centimeters), BMI, and BMR.

#### Helper Functions:
- `compute_age(birth_str)`: Calculates the user's age based on their birthdate.
- `kg_from_lb(pounds)`: Converts weight from U.S. pounds to kilograms.
- `cm_from_in(inches)`: Converts height from U.S. inches to centimeters.
- `body_mass_index(weight, height)`: Calculates the user's BMI.
- `basal_metabolic_rate(gender, weight, height, age)`: Calculates the user's BMR based on gender, weight, height, and age.

[Link Health Metrics Calculator on GitHub](https://github.com/liviagalletti/costa/blob/master/fitness.py)
