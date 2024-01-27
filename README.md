# Attrition Data Analysis

## Background

This dataset includes factors about employees that could contribute to the company’s attrition rate. It is based on a fictional dataset created by IBM data scientists. The data scientists included detailed information about each of the company’s employees along with whether or not the employee had left the company. The key attributes of the employees in this dataset include age, gender, attrition, job role, department, income, marital status, overtime work, and levels of job satisfaction. The goal of this analysis is to determine which of the included factors had the greatest effect on the attrition rate of the business. This project is applicable across a wide range of industries as the reasons behind employee attrition are always something a company should be aware of when making any decisions that will affect its business model and its employees. 

## Business Task

The purpose of this analysis is to determine if any specific factors could be key indicators of whether or not an employee will leave the company. 

## Data Reliability

The data used in this analysis is fictional data created by IBM data scientists to be used as practice data for HR data analysis. The data is made available for public use through the GNU general public license and any potential sensitive data is made private by anonymizing the data. All information that would be used to personally identify any of the employees has been removed. 

## Data Cleaning Process 
	
For the data cleaning aspect of this process, I used SQL Server Management Studio (SSMS). The first step I took after importing the dataset was to run some exploratory queries to learn more about the data and what steps would be needed to clean it. 

![image](https://github.com/ashleybonin/Attrition-Data-Analysis/assets/141379455/ff76e08f-7296-4f11-a033-d7ae369d6609)

After ensuring the data in the above columns was accurate, I then moved on to removing any redundant columns that would not be necessary for my analysis.

![image](https://github.com/ashleybonin/Attrition-Data-Analysis/assets/141379455/c19dc324-29a0-471b-a7ce-a07700f44406)

This dataset included a column for ‘EmployeeCount’ where every individual was given the value ‘1’. Since this column did not have any insightful data it could be removed using the above queries. The same applies to the column ‘Over18’ which had the value of ‘yes’ for every employee. As already determined through the age column, since there is no employee under the age of 18, this column is unnecessary and can be removed. 

Next, I checked the dataset for duplicates using the below query. Since this particular dataset does not have any, I was able to move on from this point.

![image](https://github.com/ashleybonin/Attrition-Data-Analysis/assets/141379455/9a241793-3110-42ac-9db7-604f9f47991b)

I then moved on to modifying some of the other columns to make them more accurate. 

![image](https://github.com/ashleybonin/Attrition-Data-Analysis/assets/141379455/e917f839-96b9-4479-a6f0-81d32a4b0d48)

I renamed the DistanceFromHome column to KilometersFromHome to clarify which distance metrics were being used in the data.

Next, I modified the data in the Education column and replaced the numeric values with category names instead.

![image](https://github.com/ashleybonin/Attrition-Data-Analysis/assets/141379455/a62576b3-b409-49f9-8c04-929526277a23)

I changed the data type of the Education column from integer to Nvarchar so that I would then be able to modify the numeric values of 1-5 to the corresponding education level as shown in the queries above. This makes the data easier to understand from a glance as it was initially unclear what the numeric education levels represented. 

This dataset included the columns DailyRate, HourlyRate, and MonthlyRate. However, upon further inspection, the daily, hourly, and monthly rates did not appear to be consistent. Using the given hourly rate to try to calculate the monthly rate led to vastly different numbers than the given values. As I was not able to ask for further clarification on this data from the source, I decided that for this analysis, it would be best to take the given MonthlyRate and calculate an AnnualIncome and IncomePerPaycheck based on this original MonthlyRate to have more consistent data. I then removed the DailyRate and HourlyRate columns and used the calculated income columns instead as seen in the below queries. 

![image](https://github.com/ashleybonin/Attrition-Data-Analysis/assets/141379455/84582864-eb60-4f8c-9aac-d0d34a8c5f00)

Next, since I knew age would be an important category in my analysis, I wanted a better way to group employees by age. I decided to add a Generation column to the data and assign employees a generation based on their age. 

![image](https://github.com/ashleybonin/Attrition-Data-Analysis/assets/141379455/ab51b57f-32d7-4189-b2fd-6e1b252ab1dc)

To do this, I first determined the max and min ages of the employees to find out what the oldest and youngest working generations would be. After this, I created a new generation column for the dataset and set this new column to be updated based on what ages fit into each generation. 

Finally, after this whole dataset was cleaned and manipulated to be best analyzed, I selected all the data and saved it as a CSV file to be uploaded to Tableau. 

## Data Analysis

For the analysis portion of this project, I chose to use Tableau to visualize the data. I uploaded the cleaned data from SSMS as a CSV file. Using Tableau I created charts showing how different factors affected the attrition rate. These charts include overtime work, work-life balance satisfaction, gender, generation, annual income, and department. 

![image](https://github.com/ashleybonin/Attrition-Data-Analysis/assets/141379455/99e9c05f-3d48-4721-8913-022feeb47bf5)

A total of 1,470 employees are included in this dataset with 1,233 active employees and an attrition count of 237. This results in a company-wide attrition rate of 16%. The company is made up of 60% male employees and 40% female with an average age of 37 years old. 

Based on these graphics we see a higher instance of attrition with employees who work overtime at a rate of 30.5% which is much higher than the company's average rate. We also see a higher attrition rate with employees who have a low work-life balance satisfaction level. However, what seems to be the biggest indicator of attrition in this dataset can be seen in the middle graphic of the visualization. The effect of annual income on the attrition rate graph shows a strong negative correlation between annual income and attrition, with high income showing a low attrition rate and low income showing a high attrition rate. When analyzing other factors in this data set that show high attrition they also seem to correlate with those employees having a low annual income. This can be seen in the generation graphic where it appears the younger the generation, the higher the attrition rate. However, upon closer inspection, this could be attributed to the fact that the younger generations have a lower average annual income than the older generations. 

At this company, there seems to be a problem with retaining employees at the lower levels who do not take home a large annual income. In addition to what is discussed above, this can again be seen in the attrition rate of job roles. The position that sees the greatest attrition rate is the sales representative with an attrition rate of 40% and an average annual income of only $31,512, the lowest at the company. 

As a result of this analysis, we can conclude that the best indicator of whether or not an employee will leave the company seems to be based on their annual income. The average annual income of employees who have left the company is $57,445 while the average annual income of current employees is $81,993. 

## Plan of Action 
 
As discussed in the above analysis, the key indicator of whether or not an employee will stay with the company is their yearly income. The lower the employee’s salary, the less likely they are to stay with the company. This can be attributed to the high cost of living and employees feeling as if their salary does not fairly reflect their quality of work. This is not to say that every employee should suddenly be given a large raise to ensure that they do not leave. However, it gives greater insight into what needs to be changed if the company is interested in lowering its attrition rate. Further analysis into how the salary of these lower-paying jobs compares to the nationwide and statewide averages of that position would be beneficial for the company to know. If their salaries are lower than the averages then an increase to make these positions have a more competitive income could greatly improve the attrition rate. However, if these positions are already at a fair wage then offering some additional benefits could go a long way in improving loyalty in employees. A company that takes care of its employees will see the same quality of care in the work those employees do for their company. 

