# Pewlett Hackard Analysis

## Overview

Using SQL, PostgreSQL, and pgAdmin, I performed an analysis on employment data from a hypothetical company preparing for upcoming retirements. As baby boomers begin to retire at a rapid rate, this company was looking to offer a retirement package for those who meet certain criteria, and wanted to arrange for the filling of so many newly vacant positions. 

### Purpose

The purpose of this project was to perform employee research using six CSV file provided by the company. This meant creating a number of lists/tables with relevant information, including:
  - Retirement information by department
  - Managers of their departments that are ready for retirement
  - The number of retiring employees by title
  - Employees eligible for the Mentorship Program

## Results

The table below shows the first ten rows of the list of all employees eligible for retirement by title, as well as the time period they were working for this company.

<img width="395" alt="Screen Shot 2022-11-08 at 5 34 27 PM" src="https://user-images.githubusercontent.com/113553238/200690915-4d8dddb2-bd65-405e-bca1-bb93a3574d56.png">

After conducting this analysis, it was found that there is currently a large number of employees of retirement age (37,462 employees holding the position "Senior Engineer" or "Senior Staff"/90,398 total retiring employees * 100 = 41%), with __41%__ of total retiring employees holding senior positions, as shown in the Unique Titles table below. 

<img width="172" alt="Screen Shot 2022-11-08 at 5 16 17 PM" src="https://user-images.githubusercontent.com/113553238/200689025-de71e9d7-6b66-4fa1-93b9-c5708b155d01.png">

The image below shows the first ten rows of the list of candidates that can qualify to become members of the mentorship program, they can be referenced as "senior" employees amongst the general staff that are not yet ready to retire. 

<img width="509" alt="Screen Shot 2022-11-08 at 5 16 52 PM" src="https://user-images.githubusercontent.com/113553238/200688978-fab72f0c-0ada-43d2-9b4e-9036a60f77c8.png">

## Summary

### "The Silver Tsunami"

There are over 90,000 staff at this company that are ready for retirement, meaning they will need an extensive hiring process in the upcoming years to fill those positions. Because of the high volume of vacancies, I suggest the company move forward in phases, so as not to overwhelm departments with so much change and allow for sufficient training of new employees. It may be helpful to create an additional table listing employee who are next in line for senior positions to help facilitate the hiring process.

### Mentorship Eligibility

There are 1,941 employees eligible for the Mentorship Program. This should be a sufficient number of qualified employees to train any newcomers to the company, as long as senior staff participate in the training of those who will be taking over their positions. This way, both completely new employees and promoted staff will receive adequate training for their new positions.  


