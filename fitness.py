from datetime import datetime

def main():
    gender = input('Please enter your gender (M or F):')
    birthdate = input('Enter your birthdate (YYYY-MM-DD):')
    weight = float(input('Enter your weight in U.S. pounds'))
    height = float(input('Enter your height in U.S. inches: '))

    age = compute_age(birthdate)
    weight_kg = kg_from_lb(weight)
    height_cm = cm_from_in (height)
    bmi = body_mass_index(weight, height)
    basal = basal_metabolic_rate (gender, weight, height, age)

    print(f'Age (years): {age}')
    print(f'Weight (kg): {weight_kg:.2f}')
    print(f'Height (cm): {height_cm:.2f}')
    print(f'Body mass index:{bmi:.2f}')
    print(f'Basal metabolic rate (kcal/day):{basal:.2f}')


def compute_age(birth_str):
    birthdate = datetime.strptime(birth_str, "%Y-%m-%d")
    today = datetime.now()

    years = today.year - birthdate.year

    if birthdate.month > today.month or \
        (birthdate.month == today.month and \
            birthdate.day > today.day):
        years -= 1

    return years

def kg_from_lb(pounds):
    kg = pounds * 0.45359237

    return kg 

def cm_from_in(inches):
    cm = inches * 2.54

    return cm

def body_mass_index(weight, height):
    bmi = (10000*weight) / height**2

    return bmi 

def basal_metabolic_rate(gender, weight, height, age):
    if gender.lower() == 'm':
        bmr_m = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
        return bmr_m
    elif gender.lower() == 'f':
        bmr_f = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
        return bmr_f
    else:
        print("Invalid gender entered. Please enter 'm' or 'f'.")


main()